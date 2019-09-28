########################################################################################
# inspired by https://jeremievallee.com/2018/05/28/kubernetes-rbac-namespace-user.html #
########################################################################################

#!/bin/bash

if [[ $# != 2 ]]; then
    echo "$0 user_name k8s_endpoint"
    exit 0
fi

USER_NAME=$1
KUBECTL_ENDPOINT=$2

kubectl create namespace $USER_NAME
cat > access.yaml << EOF
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: $USER_NAME-user
  namespace: $USER_NAME

---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: $USER_NAME-user-full-access
  namespace: $USER_NAME
rules:
- apiGroups: ["", "extensions", "apps"]
  resources: ["*"]
  verbs: ["*"]
- apiGroups: ["batch"]
  resources:
  - jobs
  - cronjobs
  verbs: ["*"]

---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: $USER_NAME-user-view
  namespace: $USER_NAME
subjects:
- kind: ServiceAccount
  name: $USER_NAME-user
  namespace: $USER_NAME
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: $USER_NAME-user-full-access
EOF

kubectl apply -f ./access.yaml
sleep 1s

TOKEN_NAME=`kubectl describe sa $USER_NAME-user -n $USER_NAME | grep Tokens | sed 's/[[:space:]]//g' | cut -d ':' -f 2`
TOKEN=`kubectl get secret $TOKEN_NAME -n $USER_NAME -o "jsonpath={.data.token}" | base64 -d`
CERT=`kubectl get secret $TOKEN_NAME -n $USER_NAME -o "jsonpath={.data['ca\.crt']}"`

cat > config << EOF
apiVersion: v1
kind: Config
preferences: {}

# Define the cluster
clusters:
- cluster:
    certificate-authority-data: $CERT
    # You'll need the API endpoint of your Cluster here:
    server: $KUBECTL_ENDPOINT
  name: my-cluster

# Define the user
users:
- name: $USER_NAME-user
  user:
    as-user-extra: {}
    client-key-data: $CERT
    token: $TOKEN

# Define the context: linking a user to a cluster
contexts:
- context:
    cluster: my-cluster
    namespace: $USER_NAME
    user: $USER_NAME-user
  name: $USER_NAME

# Define current context
current-context: $USER_NAME
EOF