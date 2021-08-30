# Poolin智能代理基本功能运行脚本

---
***Windows***
## 硬件及系统要求
```asm
机器配置： 最低配置要求 2C 2G及以上，推荐 4C 4G及以上
系统要求： Windows10
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
***本脚本仅支持基本的挖矿代理，需要更多功能请查看进阶版本说明***