set -ex
#必填
host_coin=BTC

#选填
proxy_port=
docker_name=

#--------------further founction settings------------
#均为可填选项

#连接上一级服务的模式 (代理默认AUTO)
up_server_mode=
#`list` 指定当前代理的上级服务地址，可用","分隔多个
up_server_address=
#钉钉/Slack notify token设置
notify_token=""
#notify当前代理标签
host=""
#设置矿机统一子账号(默认为空,矿机设置生效,非空则以代理设置为准)
user_name=""
#----------------------------------------------------


host_coin=`echo $host_coin| tr 'a-z' 'A-Z'`
#  docker_name
if [ -z "${docker_name}" ]; then
  docker_name=proxy_`echo $host_coin| tr 'A-Z' 'a-z'`
  echo "docker_name not set, default value: ${docker_name}"
fi

# proxy_port
if [ -z "${proxy_port}" ]; then
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
        --env UP_SERVER_MODE=${up_server_mode} \
        --env HOST_COIN=${host_coin} \
        --env USER_NAME=${user_name} \
        --env NOTIFY_TOKEN=${notify_token} \
        --env HOST=${host} \
        --log-opt mode=non-blocking --log-opt max-buffer-size=4m --log-driver journald \
        -v /work:/work \
        --name ${docker_name} \
        -p ${proxy_port}:1801 \
        ${docker_version}