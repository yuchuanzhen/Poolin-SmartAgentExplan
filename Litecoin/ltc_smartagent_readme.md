# Poolin-SmartAgentExplan
Poolin智能代理使用说明

## 1. Install depency 安装依赖

You can just follow the instructions below.

依照下属操作即可

```shell
apt-get update
apt-get install -y build-essential cmake git

#
# install libevent
#
mkdir -p /root/source && cd /root/source
wget https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz
tar zxvf libevent-2.0.22-stable.tar.gz
cd libevent-2.0.22-stable
./configure
make
make install

#
# install glog
#
mkdir -p /root/source && cd /root/source
wget https://github.com/google/glog/archive/v0.3.4.tar.gz
tar zxvf v0.3.4.tar.gz
cd glog-0.3.4
./configure && make && make install
```

## 2. Make config file for agent 为代理程序创建一个配置文件

The contents of the configuration file are as follows.

配置文件的内容如下。


```json
{
    "agent_listen_ip": "0.0.0.0",
    "agent_listen_port": 3333,
    "pools": [
        ["ltc.ss.poolin.com", 1800, "poolin"],
        ["ltc.ss.poolin.com", 1800, "poolin"]
    ]
}
```

- agent_listen_ip :  Agent's listen IP address. `string`
- agent_listen_port : Agent's listen port, miners will connect to this port.`int 0 - 65535`
- pools: pools settings which Agent will connect. You can put serval pool's settings here.`array`
  - ["<stratum_server_host>", <stratum_server_port>, "<pool_username>"]`array`
  
- agent_listen_ip : 代理监听的ip, 写 “0.0.0.0” 表示本机ip。 `字符串`
- agent_listen_port : 代理监听的端口. `整数 0 - 65535`
- pools: 矿池地址的是相关配置。最多写三个。`数组`
  - ["<矿池地址>",<矿池端口>,"<子账户名称>"] `字符串, 整数, 字符串`
  
Save your config tho agent_conf.json
将上述内容保存到agent_conf.json
  
## 3. Start/Stop agent 启动/停止代理

```shell
# start
# 启动
mkdir log
./ltcagent -c agent_conf.json -l log

# stop: `kill` the process pid or use `Control+C`
# 结束 ： 使用kill 命令杀掉进程或按 ctrl + c
kill `pgrep 'ltcagent'`
```

## 4. Q&A 相关问题

### 4.1  recommand to use supervisor to manage it 推荐使用supervieor监控代理程序

Make this supervisord config file as agent.conf
新建下面内容的supervisord 配置文件 名字是 agent.conf

```
[program:agent]
directory=/work/agent
command=/work/agent/ltcagent -c /work/agent/agent_conf.json -l /work/agent/log
autostart=true
autorestart=true
startsecs=3
startretries=100
```

执行以下命令

```shell
$ mkdir -p /work/agent
$ cd /work/agent
# copy ltcagent and config.json into this dir
# 拷贝配置代理的配置文件和二进制程序到本目录
$ apt-get install -y supervisor
$ cp agent.conf /etc/supervisor/conf.d/
$ supervisorctl
supervisor> reread
agent: available
supervisor> update
agent: added process group
supervisor> status
agent                            RUNNING    pid 21296, uptime 0:00:09
supervisor> exit
```
modify supervisord min fd number.
修改supervisord的fd数
```
vim /etc/supervisor/supervisord.conf

# add or modify follow section
# 增加或者修改下面字段

[supervisord]
minfds=65535
```


### 4.2 How to run multi programs in one machine. 如何多开程序 
Modify the config file make sure listen port is different.
编辑配置文件确保监听端口不同即可。

### 4.3 Too many open files problem. 打开文件句柄数目过多
If you get Too many open files error, it means you need to increase the system file limits. Usually the default value is 1024 so you can't connect more than 1024 miners at one agent.

一般系统默认最大句柄数1024个，这就限制了最大矿机连接量1024个。需要手动修改接触限制。

```vi
vim /etc/security/limits.conf
# open this config file，add follow lines.
# 打开这个配置文件, 新增下面4行
root soft nofile 65535
root hard nofile 65535
* soft nofile 65535
* hard nofile 65535

## :wq 保存退出vim
```

You need to logout shell than login again. Check the value, should as below:
```
$ ulimit -Sn
65535
$ ulimit -Hn
65535
```


