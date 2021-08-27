cd "C:\Program Files\Docker\Docker"

DockerCli.exe -SwitchDaemon

set docker_version=registry.cn-beijing.aliyuncs.com/poolin_public/proxy:latest

set docker_name=no_net_work_pool_btc
set host_coin=BTC
set no_net_work_port=18001
set exec_file=no_network_pool

docker pull %docker_version%

docker stop -t 3 %docker_name%
docker rm %docker_name%

docker run -it --restart always -d ^
        --dns 119.29.29.29 ^
        --dns 223.5.5.5 ^
        --privileged=true ^
        --env HOST_COIN=%host_coin% ^
        --env EXEC_FILE=%exec_file% ^
        -v /work:/work ^
        --name %docker_name% ^
        -p %no_net_work_port%:1801 ^
       %docker_version%
pause