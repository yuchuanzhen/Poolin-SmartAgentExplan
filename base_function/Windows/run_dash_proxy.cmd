cd "C:\Program Files\Docker\Docker"
DockerCli.exe -SwitchDaemon

set docker_version=registry.cn-beijing.aliyuncs.com/poolin_public/proxy_dash:latest

REM 必填
set docker_name=proxy_dash
set host_coin=DASH
set proxy_port=8003

REM -----------further founction settings-----------------
REM 均为可填选项

REM 连接上一级服务的模式 (代理默认AUTO)
up_server_mode=
REM `list` 指定当前代理的上级服务地址，可用","分隔多个
up_server_address=
REM 钉钉/Slack notify token设置
notify_token=""
REM notify当前代理标签
host=""
REM 设置矿机统一子账号(默认为空,矿机设置生效,非空则以代理设置为准)
user_name=""
REM 健康检查检测失败时间设置
health_check_fail_duration=
REM share 拒绝数计量
reject_share_count=
REM ------------------------------------------------------

docker pull %docker_version%

docker stop -t 3 %docker_name%
docker rm %docker_name%

docker run -it --restart always -d ^
        --dns 119.29.29.29 ^
        --dns 223.5.5.5 ^
        --privileged=true ^
        --env UP_SERVER_ADDRESS=%up_server_address% ^
        --env UP_SERVER_MODE=%up_server_mode% ^
        --env HOST_COIN=%host_coin% ^
        --env USER_NAME=%user_name% ^
        --env NOTIFY_TOKEN=%notify_token% ^
        --env HOST_COIN=%host_coin% ^
        --env HEALTH_CHECK_FAIL_DURATION=%health_check_fail_duration% ^
        --env REJECT_SHARE_COUNT=%reject_share_count% ^
        -v /work:/work ^
        --name %docker_name% ^
        -p %proxy_port%:1801 ^
       %docker_version%
pause
