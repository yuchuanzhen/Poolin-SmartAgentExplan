# Poolin断网宝

---

***Windows***

## 硬件要求

```asm
机器配置： 2C 8G及以上
系统要求： Windows10
```

---

## ETH 断网宝运行

- 创建目录

 ```asm
C:/work/script
```

- 将对应的ETH断网宝脚本拷贝到上述目录
- 运行ETH断网宝脚本

```asm
双击 C:/work/script/run_eth_no_network_pool.cmd
```

- 查看日志

```asm
docker logs -f no_net_work_pool_eth --follow --tail 10
```

## BTC 断网宝运行

- 创建目录

 ```asm
C:/work/script
```

- 将对应的BTC断网宝脚本拷贝到上述目录
- 运行BTC断网宝脚本

```asm
双击 C:/work/script/run_btc_no_network_pool.cmd
```

- 查看日志

```asm
docker logs -f no_net_work_pool_btc --follow --tail 10
```

## 连接矿机

### ETH连接断网宝

```asm
矿机挖矿地 stratum+tcp://本机ip:18005
```

### BTC连接断网宝

```asm
矿机挖矿地 stratum+tcp://本机ip:18001
```

***注意：断网宝端口可在脚本中修改***

```asm
#BTC 断网宝默认端口 18001
#ETH 断网宝默认端口 18005
no_network_port=
```

---
