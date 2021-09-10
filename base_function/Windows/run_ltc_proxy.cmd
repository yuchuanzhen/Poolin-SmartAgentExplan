cd "C:\Program Files\Docker\Docker"

DockerCli.exe -SwitchDaemon

set docker_version=registry.cn-beijing.aliyuncs.com/poolin_public/proxy_ltc:latest

set docker_name=proxy_ltc
set host_coin=LTC
set proxy_port=8002

docker pull %docker_version%

docker stop -t 3 %docker_name%
docker rm %docker_name%

docker run -it --restart always -d ^
        --dns 119.29.29.29 ^
        --dns 223.5.5.5 ^
        --privileged=true ^
        --env HOST_COIN=%host_coin% ^
        -v /work:/work ^
        --name %docker_name% ^
        -p %proxy_port%:1801 ^
       %docker_version%
pause
