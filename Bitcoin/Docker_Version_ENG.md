


# Poolin Bitcoin SmartAgent Usage (docker)

## 1. Install docker


|Platform|x86_64/amd64|ARM|ARM64/AARCH64|
|---|---|---|---|
|[CentOS](https://docs.docker.com/install/linux/docker-ce/centos/)|yes|no|yes|
|[Debian](https://docs.docker.com/install/linux/docker-ce/debian/)|yes|yes|yes|
|[Fedora](https://docs.docker.com/install/linux/docker-ce/fedora/)|yes|no|yes|
|[Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)|yes|yes|yes| 
|[Windows](https://docs.docker.com/docker-for-windows/install/)|yes | no | no |
|[Mac](https://docs.docker.com/docker-for-mac/install/) | no | no | no |


## 2. Make volume directory

We show an example in linux.

```bash
# Get root right
su

# make a run time directory for mount
mkdir /agent

# make log dir for store log files
cd /agent
mkdir log
```

There is the directory struct
```bash
/
`-- agent
     `-- log
```

## 3. Make config file
Make a new config file named `agent_conf.json`. 

***Attention*** Config file name is `agent_conf.json`. **DO NOT MODIFY IT**.

```bash
cd /agent
touch agent_conf.json
```

Now here is the directory struct

```bash
/
`-- agent
    |-- agent_conf.json
    `-- log
```
The full path of those files and directory are

```
/agent/agent_conf.json
/agent/log/
```

***Attention*** The config file `agent_conf.json` and the directory `log` are same level , both of those are in the `agent` directory.

## 4. Modify config file content

The format of config file is showing down below. You can copy the example into your  `agent_conf.json` and modify base on that.


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
   "agent_rpc_port":16580,
   "auto_start":false,
   "offline_keep_mining":false,
   "pools":[  
      {  
         "address":"btc.ss.poolin.com",
         "port":443
      }
   ]
}
```


- account `[array]`: agent account, if account_mode is 1, agent will use this account to mining in the pool. 
  - name `[string]`: account 
  - weight `[int 1-99]`: if there are multi account , agent will calculate the weight.
- account_mode `[int 0-1]`: agent type. 
  - 0 : Will use the account name in every miner.
  - 1 : Will use the account name in this config file.
- agent_rpc_port `[int 0-65535]` : useless . 
- agent_listen_ip `[string]`:  Agent's listen IP address. 
- agent_listen_port  `[int 0-65535]`: Agent's listen port, miners will connect to this port.
- auto_start `[bool]`: useless.
- offline_keep_mining  `[bool]`: useless
- pools`[array]`: pools settings which Agent will connect. You can put serval pool's settings here.
  - address `[string]` : Mining pool address. You can simply use `btc.ss.poolin.com`.
  - port `[int 0-65535]` : Mining pool listen port.Poolin.com are use `1883`, `443`, `25`.


## 5. Download docker image 


```docker
docker pull registry.cn-beijing.aliyuncs.com/poolin_public/btcagent:3.2.1
```

## 6. Run docker imgae

1. Make sure you have create the `/agent` directory
2. Make sure you have create the config file `agent_conf.json` and have a `log` directory in the save `agent` directory.

```docker
docker run -d -v /agent/:/work/agent --name btcagent --network="host" --restart=always registry.cn-beijing.aliyuncs.com/poolin_public/btcagent:3.2.1
```

## 7. Miner connect

1. address is the LAN IP of computer which the smart agent docker image is running on.
2. Port is `agent_listen_port` which in your config file `agent_conf.json`.

## 8. Check logs

There are 2 way to check logs.

1. All logs are in the `/agent/log/` dirctory.
2. Input below command to see the realtime logs.

```bash
docker logs --tail=50 --follow btcagent
```
