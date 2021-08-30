# Poolin智能代理基本功能运行脚本

---
***Windows***
## 硬件要求
```asm
机器配置： 最低配置要求 2C 2G及以上，推荐 4C 4G及以上
系统要求: Windows10
```
---
## ETH 代理运行
- 创建目录
 ```asm
C:/work/script
```
- 将对应的ETH代理脚本拷贝到上述目录
- 运行ETH代理脚本
```asm
双击 C:/work/script/run_eth_proxy.cmd
```
- 查看日志
```asm
docker logs -f proxy_eth --follow --tail 10
```

## BTC 代理运行
- 创建目录
 ```asm
C:/work/script
```
- 将对应的BTC代理脚本拷贝到上述目录
- 运行BTC代理脚本
```asm
双击 C:/work/script/run_btc_proxy.cmd
```
- 查看日志
```asm
docker logs -f proxy_btc --follow --tail 10
```

# 连接矿机
## ETH连接代理
```asm
矿机挖矿地 stratum+tcp://本机ip:8005
```
## BTC连接代理
```asm
矿机挖矿地 stratum+tcp://本机ip:8001
```
---
---
# 更多功能

### 配置参数说明
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
