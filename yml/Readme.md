# Deploy ElasticSearch and Kibana V7.1.1

```shell
kubectl apply -f kube-logging.yml
kubectl apply -f pv.yaml
kubectl apply -f elasticsearch_svc.yml
kubectl apply -f elasticsearch_statefulset.yaml
kubectl apply -f kibana.yaml
```

## 注意事项

* 若想使用 elasticsearch 集群，需要将 elasticsearch_statefulset.yaml 中的 slice 修改为节点数，同时，在 `cluster.initial_master_nodes` 处添加上其它节点的名称（仿造第一个节点即可）。同时，需要为 pv 设置 dynamic provisioner
* 所有的内容都是在 kube-logging 命名空间中
* 创建 pv 时，注意修改 pv.yaml 中的路径，防止权限问题等，导致 pvc pending 或者 elasticsearch 启动失败
* kibana 只有在成功连接上 elasticsearch 的时候，才会启动服务器，所以如果 kibana 启动失败，那么可能是没有连接上 elasticsearch，进而可能是 elasticsearch 集群配置有问题
