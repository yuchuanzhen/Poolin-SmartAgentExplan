# Poolin智能代理基本功能运行脚本

---

***Linux***

## 硬件要求

```asm
机器配置： 最低配置要求 2C 2G及以上，推荐 4C 4G及以上
```

---

## ETH 代理运行

- 创建目录
  
 ```asm
makdir -p /work/script
```

- 将对应的ETH代理脚本拷贝到上述目录
- 运行ETH代理脚本

```asm
bash /work/script/run_eth_proxy.sh
```

- 查看日志

```asm
docker logs -f proxy_eth --follow --tail 10
```

- journal 导出24小时日志

```asm
  journalctl -o cat CONTAINER_NAME=proxy_eth -S "24 hour ago" >> /work/proxy_eth_log.log
```

## BTC 代理运行

- 创建目录

 ```asm
makdir -p /work/script
```

- 将对应的BTC代理脚本拷贝到上述目录
- 运行BTC代理脚本
  
```asm
bash /work/script/run_btc_proxy.sh
```

- 查看日志
  
```asm
docker logs -f proxy_btc --follow --tail 10
```

- journal 导出24小时日志
  
```asm
  journalctl -o cat CONTAINER_NAME=proxy_btc -S "24 hour ago" >> /work/proxy_btc_log.log
```

## LTC 代理运行

- 创建目录

 ```asm
makdir -p /work/script
```

- 将对应的LTC代理脚本拷贝到上述目录
- 运行LTC代理脚本
  
```asm
bash /work/script/run_ltc_proxy.sh
```

- 查看日志
  
```asm
docker logs -f proxy_ltc --follow --tail 10
```

- journal 导出24小时日志
  
```asm
  journalctl -o cat CONTAINER_NAME=proxy_ltc -S "24 hour ago" >> /work/proxy_ltc_log.log
```

## DASH 代理运行

- 创建目录

 ```asm
makdir -p /work/script
```

- 将对应的DASH代理脚本拷贝到上述目录
- 运行DASH代理脚本
  
```asm
bash /work/script/run_dash_proxy.sh
```

- 查看日志
  
```asm
docker logs -f proxy_dash --follow --tail 10
```

- journal 导出24小时日志
  
```asm
  journalctl -o cat CONTAINER_NAME=proxy_dash -S "24 hour ago" >> /work/proxy_dash_log.log
```

## 连接矿机

### ETH连接代理

```asm
矿机挖矿地 stratum+tcp://本机ip:8005
```

### BTC连接代理

```asm
矿机挖矿地 stratum+tcp://本机ip:8001
```

### LTC连接代理

```asm
矿机挖矿地 stratum+tcp://本机ip:8002
```

### DASH连接代理

```asm
矿机挖矿地 stratum+tcp://本机ip:8003
```

---
---

## 更多功能

### 配置参数说明

- 必填项
  - host_coin `[string]`       : 要代理的币种，目前支持BTC/ETH，其他币种后续逐渐支持。
  - proxy_port `[int 0-65535]` : 代理机器stratum 端口，默认端口 BTC：8001， ETH：8005；可根据端口占用实际情况修改。
  - docker_name `[string]`     : 代理docker容器名称，默认名称   BTC：proxy_btc ETH: proxy_eth。

- 进阶参数（非必填）
  - up_server_mode `[string]`  : 连接上一级服务的模式 (代理默认AUTO)
    - AUTO       自动模式:(proxy 默认): 自动选择网络通信最好的 ip；
    - SEQUENCE   顺序模式:(pool server 默认): 按配置文件的顺序设置 ip 优先级，若优先级高的 ip 不可用, 会选择下一个优先级最高的 ip. 优先级最高的 ip 可用后, 会自动切回；
    - CONFUSE    混淆模式:(满足部分矿场需求): 随机选择 ip, 单个 ip 通信时间不会超过 60 分钟, 可能连接到境外 ip, 会切换到通信不好的 ip 上, 可能影响算力。

    - user_name `[string]`       :代理机器设置矿机统一子账号(默认为空,矿机设置生效,非空则以代理设置为准)。
    - up_server_address`[list]`  :代理可以连接的poolin矿池地址用","分隔，默认 eth-agent3.ss.poolin.com。
    - notify_token `[string]`    :用于代理运行时候异常报警出口：目前支持钉钉/Slack的机器人，此处填写机器人token，可及时提示代理任何异常，例如job超时，网络延迟等;

    ```asm
    例如:
    notify_token="https://oapi.dingtalk.com/robot/send?access_token=ccfe489...c7f673"
    notify_token="https://hooks.slack.com/services/T01A3MY4UTW/B02CS0JU8KC/PsQd...j0Lq"
    ```

    - host `[string]`            :钉钉/Slack通知时代理机器的描述字符串，例如host="my_eth_proxy_001"
  
    - health_check_fail_duration `[int]`:代理健康检查检测失败时间设置 单位分钟 0:表示永远保持矿机连接，默认值为1分钟，如果健康检查失败超过一分钟则重启代理服务
    - reject_share_count `[int]`  :矿机提交最后一个被接受share后, 累计拒绝 share 数量最大值，若设置为0则不做判断,默认值 10，超过则断开矿机

***系统不支持jouranlctl可将docker run中对应的行删除***
