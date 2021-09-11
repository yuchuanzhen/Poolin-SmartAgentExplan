# Poolin Smart Agent Usage

## 币印新版智能代理特色

- 外网网络连接降低至个位数

- 支持外网 ip 混淆, 约 10 分钟 - 1 小时切换一次 ip 地址

- 流量全加密

- 大幅缩减网络流量, 1 台矿机 vs 1 万台矿机, 下行流量几乎不变, 上行流量减少 85%

- 单台代理支撑 2w - 20w 矿机(依赖主机性能)

- 智能代理统一设置子账户(挖矿账户)

- 可设置 钉钉/Slack 报警通知,代理健康状况随时掌控

- 按客户特殊需求支持多种复杂网络拓扑结构

***智能代理支持币种持续上线中***

|支持币种|默认端口|备注|
|---|---|---|
|BTC|8001|已支持|
|ETH|8005|已支持|
|LTC|8002|已支持|
|DASH|8003|已支持|
|ZEC|8006|近期开放|
|BCH|8010|近期开放|
|DCR|8012|近期开放|
|BSV|8017|近期开放|
|HNS|8020|近期开放|
|CKB|8023|近期开放|
|ZEN|8024|近期开放|
|STC|8026|近期开放|

---

## Poolin 智能代理使用说明

***Poolin 智能代理的运行依赖于 docker***

## 第一步: 安装docker

|操作系统|Docker安装教程|
|---|---|
|[Linux](https://docs.docker.com/install/linux/docker-ce/ubuntu/)|[点击查看](https://docs.docker.com/install/linux/docker-ce/ubuntu/)|
|[Windows](https://docs.docker.com/docker-for-windows/install/)|[点击查看](https://docs.docker.com/docker-for-windows/install/)|
|[Mac](https://docs.docker.com/desktop/mac/install/) |[点击查看](https://docs.docker.com/desktop/mac/install/)|

---

## 第二步: 启动代理

[启动脚本](https://github.com/iblockin/Poolin-SmartAgentExplan/tree/master/run_scripts)

---

## 可选: 断网宝服务

断网宝用于断网场景下, 保持矿机运行, 维持矿场电力负载稳定

[启动脚本](https://github.com/iblockin/Poolin-SmartAgentExplan/tree/master/no_nework_pool)

---

## 可选: 更多参数设置

[参数说明](https://github.com/iblockin/Poolin-SmartAgentExplan/tree/master/parameters)

---

## 可选: 多种部署形式

[更多网络拓扑结构支持](https://github.com/iblockin/Poolin-SmartAgentExplan/tree/master/deployments)
