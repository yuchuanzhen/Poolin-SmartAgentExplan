# Poolin No_Network_Pool Usage

## 断网宝

- 场地断网情况不掉负荷，降低对电力设备的损坏。

---

```asm
对于场地电力负荷有稳定要求的用户可以开启断网宝功能，
场地网络中断时可使得机器获取模拟job，
继续保持电力消耗，达到稳定负荷的作用。
```

### 安装方法

[断网宝Linux安装教程](https://github.com/iblockin/Poolin-SmartAgentExplan/tree/master/no_nework_pool/Linux)

[断网宝Windows安装教程](https://github.com/iblockin/Poolin-SmartAgentExplan/tree/master/no_nework_pool/Windows)

### 断网宝矿机配置方式

```asm
建议：
矿机第一挖矿地址使用智能代理
矿机第二挖矿地址直连矿池

矿机第三挖矿地址使用断网宝
```

#### 例如

```asm
第一挖矿地址: stratum+tcp://192.168.1.254:8001
第二挖矿地址: stratum+tcp://btc.ss.poolin.com:443
第三挖矿地址: stratum+tcp://192.168.1.254:18001
```

***这样配置可以使得智能代理与直接连接矿池挖矿地址互相灾备，当场地网络完全中断的情况会自动切换到断网宝模式***
