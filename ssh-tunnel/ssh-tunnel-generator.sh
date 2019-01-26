#!/bin/bash

if [[ $# < 3 ]]; then
	echo "Usage: $0 tunel_name ssh_host_name localport:remotePort"
	exit 0
fi

if [ ! -d "/opt/ssh-tunnel" ]; then
	mkdir -p /opt/ssh-tunnel
fi

local_port=`echo $3 | cut -d : -f 1`
remote_port=`echo $3 | cut -d : -f 2`
cat <<EOF > /opt/ssh-tunnel/$1.sh
#!/bin/bash

ssh -N -L 0.0.0.0:$local_port:127.0.0.1:$remote_port $2

EOF

cat <<EOF > /usr/lib/systemd/system/$1.service
[Unit]
Description = $1
After = network.target

[Service]
Restart = always
RestartSec = 1min
ExecStart = /opt/ssh-tunnel/$1.sh

[Install]
WantedBy = multi-user.target

EOF

chmod +x /opt/ssh-tunnel/$1.sh
systemctl enable $1.service
systemctl start $1.service