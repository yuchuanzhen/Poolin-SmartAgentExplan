# Poolin-SmartAgent

This is an usage document for [SmartAgent](https://s.blockin.com/pool-assets/assets/SmartAgent_BTC_Ubuntu.zip)

## 0. Basic usage
### 0.1. Make sure binary file can be exec.

```bash
unzip SmartAgent_BTC_Ubuntu.zip
chmod +x btcagent
```

### 0.2. Check out version 

```bash
./btcagent -v
```
Should print those messages.
```
3.0.5#
```

### 0.3. Check out help

```bash
./btcagent -h
```
Should print those messages.
```log
./btcagent: option requires an argument -- 'h'
Usage:
	-c : Where the config file is.
	-l : Where to store log files.
	-v : Show agent's version.
Best Practices
	./btcagent -c "agent_conf.json" -l "log_dir
```

## 1. System environment

```
ubuntu 18.04
```

## 2. Set configuration
### 2.1. make a config file
```bash
touch agent_conf.json
```

### 2.2. modify the config file
```bash 
vi agent_config.json
```

and input follow context into it.

```json
{  
   "account":[  
      {  
         "name":"poolin",
         "weight":1
      }
   ],
   "account_mode":0,
   "agent_listen_ip":"0.0.0.0",
   "agent_listen_port":8888,
   "pools":[  
      {  
         "address":"btc.ss.poolin.com",
         "port":443
      },
      {  
         "address":"btc.ss.poolin.com",
         "port":1883
      },
      {  
         "address":"btc.ss.poolin.com",
         "port":25
      }
   ]
}
```

- account : agent account, if account_mode is 1, agent will use this account to mining in the pool. `array`
  - name : account `string `
  - weight : if there are multi account , agent will calculate the weight.`int 1-99`
- account_mode : agent type. `int 0 - 1`
   - 0 : Will use the account name in every miner.
   - 1 : Will use the account name in this config file.
- agent_listen_ip :  Agent's listen IP address."0.0.0.0" is for local host. 
If you don't know what is means, just do not modify. `string`
- agent_listen_port : Agent's listen port, miners will connect to this port.`int 0 - 65535`
- pools: pools settings which Agent will connect. You can put serval pool's settings here.`array`

### 2.3. save the config file.
  
## 3. Start/Stop agent 

```shell
# start
mkdir log
./btcagent -c agent_conf.json -l log
```

## 4. Let miner connect to the agent
### 4.1. get LAN IP address which your agent program running on.
```bash
ifconfig
```

if your LAN IP is : 193.168.0.2
### 4.2. Login miner's web backend, set pool
```
url : 193.168.0.2:8888
account : your_own_account
password : 
```

## 5. Q&A 

### 5.1  recommand to use supervisor to manage it 

Make this supervisord config file as agent.conf

```
[program:agent]
directory=/work/agent
command=/work/agent/ltcagent -c /work/agent/agent_conf.json -l /work/agent/log
autostart=true
autorestart=true
startsecs=3
startretries=100
```

Do those commands in shell.

```shell
$ mkdir -p /work/agent
$ cd /work/agent
# copy ltcagent and config.json into this dir
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
```
vim /etc/supervisor/supervisord.conf

# add or modify follow section

[supervisord]
minfds=65535
```


### 5.2 How to run multi programs in one machine.
Modify the config file make sure listen port is different.

### 5.3 Too many open files problem. 
If you get Too many open files error, it means you need to increase the system file limits. Usually the default value is 1024 so you can't connect more 

```vi
vim /etc/security/limits.conf
# open this config file，add follow lines.
root soft nofile 65535
root hard nofile 65535
* soft nofile 65535
* hard nofile 65535

## :wq 
```

You need to logout shell than login again. Check the value, should as below:
```
$ ulimit -Sn
65535
$ ulimit -Hn
65535
```


