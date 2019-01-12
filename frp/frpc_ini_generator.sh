#!/bin/bash 

if [[ $# < 3 ]]; then 
    echo "$0: Not enough parameter"
    echo "$0 TARGET_FILE SERVER_IP SERVER_PORT local_port:remote_port ..."
fi

target_file=$1
server_ip=$2
server_port=$3

shift 
shift 
shift 

cat <<EOF > $target_file
[common]
server_addr = $server_ip
server_port = $server_port

EOF

while [ $# -ne 0 ]
do 
    param=$1
    local_port=`echo $1 | cut -d : -f 1`
    remote_port=`echo $1 | cut -d : -f 2`
    shift
    echo $local_port:$remote_port
    cat <<EOF >> $target_file
[port_$local_port]
type = tcp
local_ip = 127.0.0.1
local_port = $local_port
remote_port = $remote_port

EOF
done

