# Poolin Bitcoin 智能代理使用说明 (docker 方法运行)


## 1. 安装docker
|Platform|x86_64/amd64|ARM|ARM64/AARCH64|
|---|---|---|---|
|[CentOS](https://docs.docker.com/install/linux/docker-ce/centos/)|yes|no|yes|
|[Debian](https://docs.docker.com/install/linux/docker-ce/debian/)|yes|yes|yes|
|[Fedora](https://docs.docker.com/install/linux/docker-ce/fedora/)|yes|no|yes|
|[Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)|yes|yes|yes| 
|[Mac](https://docs.docker.com/docker-for-mac/install/) | no | no | no |


## 2. 配置目录结构

```
mkdir -p /work/script
```

## 智能代理docker脚本
在`/work/script`目录下新建一个`run_poolin_proxy.sh`的文件。 <br>
***注意*** `run_poolin_proxy.sh`名字可以根据不通币种命名: <br>
```asm
run_poolin_eth_proxy.sh
或者
run_poolin_btc_proxy.sh
```
---
---
#基础功能

***脚本内容*** `vim run_poolin_proxy.sh`
<br>
***以ETH代理配置为例：***
```shell
set -ex
#必填
host_coin=ETH

#选填
proxy_port=
docker_name=

###内部参数处理###
host_coin=`echo $host_coin| tr 'a-z' 'A-Z'`
#  docker_name 未填写则默认 proxy_$$host_coin
if [ -z "${docker_name}" ]; then
  docker_name=proxy_`echo $host_coin| tr 'A-Z' 'a-z'`
  echo "docker_name not set, default value: ${docker_name}"
fi

# proxy_port  未填写则默认以下值
f [ -z "${proxy_port}" ]; then
        case $host_coin in
                "BTC")
                        proxy_port=8001
                        ;;
                "ETH")
                        proxy_port=8005
                        ;;
                *)
                        echo "$host_coin not support by proxy yet!"
                        exit 1;
                        ;;
        esac

  echo "proxy_port not set, default value: ${proxy_port}"
fi

docker_version=registry.cn-beijing.aliyuncs.com/poolin_public/proxy:latest
docker pull ${docker_version}

docker stop -t 3 ${docker_name} || /bin/true
docker rm ${docker_name} || /bin/true

docker run -it --restart always -d \
        --dns 119.29.29.29 \
        --dns 223.5.5.5 \
        --privileged=true \
        --env HOST_COIN=${host_coin} \
        --log-opt mode=non-blocking --log-opt max-buffer-size=4m --log-driver journald \
        -v /work:/work \
        --name ${docker_name} \
        -p ${proxy_port}:1801 \
        ${docker_version}
```

###参数说明
- 必填项
  - host_coin `[string]`       : 要代理的币种，目前支持BTC/ETH，其他币种后续逐渐支持。
- 选填项
  - proxy_port `[int 0-65535]` : 代理机器stratum 端口，默认端口 BTC：8001， ETH：8005；可根据端口占用实际情况修改。
  - docker_name `[string]`     : 代理docker容器名称，默认名称   BTC：proxy_btc ETH: proxy_eth。
  
---
---

#进阶功能
***本段内容是在上述基本挖矿代理基础上对一些进阶功能的补充描述，都为可选项，不配置不会影响代理挖矿***<br>
***以ETH代理配置为例：***

***脚本内容*** `vim run_poolin_proxy.sh`
```shell
set -ex
#必填项
host_coin=ETH

#选填
proxy_port=
docker_name=
up_server_mode=
up_server_address=eth-agent3.ss.poolin.com
ding_ding="https://oapi.dingtalk.com/robot/send?access_token=ccfe489......c7f673"
host=""
user_name=""

###内部参数处理###
host_coin=`echo $host_coin| tr 'a-z' 'A-Z'`
#  docker_name 未填写则默认 proxy_$$host_coin
if [ -z "${docker_name}" ]; then
  docker_name=proxy_`echo $host_coin| tr 'A-Z' 'a-z'`
  echo "docker_name not set, default value: ${docker_name}"
fi

# proxy_port 未填写则默认以下值 （目前仅支持BTC/ETH两币种，其余为今后陆续支持币种）
f [ -z "${proxy_port}" ]; then
        case $host_coin in
                "BTC")
                        proxy_port=8001
                        ;;
                "LTC")
                        proxy_port=8002
                        ;;
                "DASH")
                        proxy_port=8003
                        ;;
                "ETH")
                        proxy_port=8005
                        ;;
                "ZEC")
                        proxy_port=8006
                        ;;
                "BCH")
                        proxy_port=8010
                        ;;
                "DCR")
                        proxy_port=8012
                        ;;
                "BSV")
                        proxy_port=8017
                        ;;
                "HNS")
                        proxy_port=8020
                        ;;
                "CKB")
                        proxy_port=8023
                        ;;
                "ZEN")
                        proxy_port=8024
                        ;;
                "STC")
                        proxy_port=8026
                        ;;
                *)
                        echo "$host_coin not support by proxy yet!"
                        exit 1;
                        ;;
        esac

  echo "proxy_port not set, default value: ${proxy_port}"
fi


docker_version=registry.cn-beijing.aliyuncs.com/poolin_public/proxy:latest
docker pull ${docker_version}

docker stop -t 3 ${docker_name} || /bin/true
docker rm ${docker_name} || /bin/true

docker run -it --restart always -d \
        --dns 119.29.29.29 \
        --dns 223.5.5.5 \
        --privileged=true \
        --env EXEC_FILE=${exec_file} \
        --env UP_SERVER_ADDRESS=${up_server_address} \
        --env UP_SERVER_MODE=AUTO \
        --env HOST_COIN=${host_coin} \
        --env USER_NAME=${user_name} \
        --env DING_DING=${ding_ding} \
        --env HOST=${host} \
        --log-opt mode=non-blocking --log-opt max-buffer-size=4m --log-driver journald \
        -v /work:/work \
        --name ${docker_name} \
        -p ${proxy_port}:1801 \
        ${docker_version}
```

###进阶配置参数说明
- 必填项
  - host_coin `[string]`       : 要代理的币种，目前支持BTC/ETH，其他币种后续逐渐支持。
- 选填项
  - proxy_port `[int 0-65535]` : 代理机器stratum 端口，默认端口 BTC：8001， ETH：8005；可根据端口占用实际情况修改。
  - docker_name `[string]`     : 代理docker容器名称，默认名称   BTC：proxy_btc ETH: proxy_eth。
  
- 进阶参数（非必填）
  - up_server_mode `[string]`  : 连接上一级服务的模式 (代理默认AUTO)
    - AUTO       自动模式:(proxy 默认): 自动选择网络通信最好的 ip；
    - SEQUENCE   顺序模式:(pool server 默认): 按配置文件的顺序设置 ip 优先级，若优先级高的 ip 不可用, 会选择下一个优先级最高的 ip. 优先级最高的 ip 可用后, 会自动切回；
    - CONFUSE    混淆模式:(满足部分矿场需求): 随机选择 ip, 单个 ip 通信时间不会超过 60 分钟, 可能连接到境外 ip, 会切换到通信不好的 ip 上, 可能影响算力。
    
  - user_name `[string]`       :代理机器设置矿机统一子账号(默认为空,矿机设置生效,非空则以代理设置为准)。
  - up_server_address`[list]`  :代理可以连接的poolin矿池地址用","分隔，默认 eth-agent3.ss.poolin.com。
  - ding_ding `[string]`       :用于代理运行时候异常报警出口：目前仅支持钉钉群的机器人，此处填写钉钉群的机器人token，钉钉群可及时提示代理任何异常，例如job超时，网络延迟等等，<br>
                                例如:ding_ding="https://oapi.dingtalk.com/robot/send?access_token=ccfe489......c7f673"。
    
  - host `[string]`            :钉钉群通知时代理机器的描述字符串，例如host="my_eth_proxy_001"
---
---

#运行及连接
## 1. 运行代理

```shell
bash /work/script/run_poolin_proxy.sh
```

## 2. 矿机连接

1. 地址是代理服务器的 **内网** IP <br>
   端口是代理服务器的 **设置或默认** 端口
2. 矿机填写挖矿地址: stratum+tcp://IP:端口

## 3. 查看日志

查看日志有2种方法。
1. 查看docker运行日志 <br>
docker logs -f <容器名称> --follow --tail 10<br>
   例如
```asm
  docker logs -f proxy_btc --follow --tail 10
```
2. journal 日志
journalctl -o cat CONTAINER_NAME=<容器名称> -S "24 hour ago" >> /work/proxy_log.log<br>
   例如
```bash
journalctl -o cat CONTAINER_NAME=proxy_btc -S "24 hour ago" >> /work/proxy_log.log
```
