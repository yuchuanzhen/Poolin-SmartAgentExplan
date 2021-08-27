set -ex
#必填
host_coin=BTC
exec_file=no_network_pool

#选填
no_network_port=
docker_name=no_net_work_pool_btc

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
                        proxy_port=18001
                        ;;
                "ETH")
                        proxy_port=18005
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
        --env EXEC_FILE=${exec_file} \
        --log-opt mode=non-blocking --log-opt max-buffer-size=4m --log-driver journald \
        -v /work:/work \
        --name ${docker_name} \
        -p ${no_network_port}:1801 \
        ${docker_version}
