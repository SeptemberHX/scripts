# scripts
My daily scripts

**所有内容均以 CentOS 7 为运行环境**

### 结构

* `basic_utils.sh` ：基础工具安装，这个是**基础，必须安装**
* k8s：Kubernetes 相关内容
  * `k8s_install.sh` : 安装 k8s，包括 docker，kubeadm
  * `install_docker.sh` ：独立的 docker 安装脚本，在 `k8s_install.sh` 中会自动执行
  * `k8s_gxrcio.sh` ：k8s 相关镜像在国内由于网络原因一般无法直接拉取。这个工具从 gxrcio 仓库中拉取镜像
  * `k8s_reset.sh` ：k8s reset
* frp：frp 内网穿透工具相关
  * `frp_install.sh` ：安装 frp 到 `/opt/frp` 中
  * `frp_ini_generator.sh` ：根据参数自动生成 `/opt/frp/frpc.ini` 配置文件
* shadowsocks：服务器代理工具
  * `ss_install.sh`：安装 shadowsocks，privoxy，proxychains4，成功后，按照提示放置 shadowsocks 配置文件，然后在所有命令前加上 proxychains4 即可使用代理，如：`proxychains4 curl www.google.com`
* zsh：zsh 相关
  * `zshrc_auto.sh` ：安装 `oh-my-zsh` 以及其他常用插件
* ssh-tunnel: ssh tunnel 相关
  * `ssh-tunnel-generator.sh` : 为 ssh 指定端口的隧道建立 service，自动生成的脚本放于 `/opt/ssh-tunnel` 中

### 使用说明

* 没有说明的均为无参数，直接执行即可
* `k8s`
  * `k8s_install.sh` ：需要指定版本参数，注意参数格式。`./k8s_install.sh 1.13.1-0`
  * `k8s_gxrcio.sh` ：需要指定版本参数，注意参数格式。`./k8s_gxrcio.sh v1.13.1`
* `frp`
  * `frp_install.sh` ：需要指定是服务端还是客户端：`./frp_install.sh s|c`
  * `frp_ini_generator.sh` ：需要指定服务端 IP、端口，以及 tcp 端口映射：`./frp_ini_generator.sh /opt/frp/frpc.ini IP PORT local_port:remote_port local_port:remote_port ...`
* `ssh-tunnel`
  * `ssh-tunnel-generator.sh` : 指定 服务名称， 远端主机名（应配置 ssh 使用 key 连接），本地端口：远程端口：`./ssh-tunnel-generator.sh test hostname 11111:11111`

