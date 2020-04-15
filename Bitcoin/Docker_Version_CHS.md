# Poolin Bitcoin 智能代理使用说明 (docker 方法运行)

## 1. 安装docker
|Platform|x86_64/amd64|ARM|ARM64/AARCH64|
|---|---|---|---|
|[CentOS](https://docs.docker.com/install/linux/docker-ce/centos/)|yes|no|yes|
|[Debian](https://docs.docker.com/install/linux/docker-ce/debian/)|yes|yes|yes|
|[Fedora](https://docs.docker.com/install/linux/docker-ce/fedora/)|yes|no|yes|
|[Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)|yes|yes|yes| 
|[Windows](https://docs.docker.com/docker-for-windows/install/)|yes | no | no |
|[Mac](https://docs.docker.com/docker-for-mac/install/) | no | no | no |


## 2. 配置目录结构

在`/`下新建一个文件夹，作为工作目录。这里以`agent`作为文件夹的名字。在`agent`目录下新建一个`log`目录。

下面是建立好的目录结构
```
agent/
   |---log/
```

## 3. 新增配置文件
在`agent`目录下新建一个`agent_conf.json`的文件。***注意*** `agent_conf.json`名字不要错。

现在目录结构是这样的

```
agent/
   |---agent_conf.json
   |---log/
```
全路径应该是

```
/agent/agent_conf.json
/agent/log/
```

***注意*** 配置文件`agent_conf.json`与目录`log`是同一级别的，即都在`agent`目录下。

## 4. 修改配置文件

配置文件格式如下，可以复制到`agent_conf.json`中然后进行修改。


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
   "offline_disconnect_delay_sec":false,
   "pools":[  
      {  
         "address":"btc.ss.poolin.com",
         "port":443
      },
      {  
         "address":"btc.ss.poolin.com",
         "port":25
      },
      {  
         "address":"btc.ss.poolin.com",
         "port":1883
      }
   ]
}
```

配置文件含义如下

- account `[list]`: 代理子账号。如果account_mode 是1的话，代理会用这个作为子账号在矿池挖矿而不会使用矿机中的子账号。
  - name `[string]`    : 子账号 
  - weight `[int 1-99]`: 权重 ,如果有多个子账号，代理会把权重求和，然后计算每个账号对应的算力百分比. 
- account_mode `[int 0-1]`: 代理的账号模式 
  - 0 : 将会使用每个矿机中的子账号。 本配置文件中的account字段则无效。
  - 1 : 将会使用本配置文件中account字段的子账号并且根据权重分配算力。矿机中的子账号无效。
- agent_listen_ip `[string]`: 代理监听的ip, 写 “0.0.0.0” 表示本机ip。
- agent_listen_port `[int 0 - 65535]`: 代理监听的端口. 
- offline_disconnect_delay_sec `[int]`: 断网保持负载多长时间，单位为秒。断网期间，代理会不断尝试重新连接矿池，同时继续空转矿机以保持矿机的功率不下降。建议为120。 
- pools`[list]`: 矿池地址的相关配置。最多写三个。配置多个矿池地址可以避免因网络抖动其中一个挖矿地址断开导致的矿机算力抖动。
  - address `[string]` : 矿池地址
  - port `[int 0-65535]` : 矿池端口


## 5. 下载docker镜像

仅以linux下的操作为例。

```shell
docker pull registry.cn-beijing.aliyuncs.com/poolin_public/btcagent:3.0.6
```

## 6. 运行代理镜像

1. 确保刚刚新建的文件夹是 `/agent`
2. 配置文件的`agent_listen_port`要记住，这里以`8888`为例

```shell
docker run -d -v /agent/:/work/agent --name btcagent --network="host" --restart=always registry.cn-beijing.aliyuncs.com/poolin_public/btcagent:3.0.6
```

## 7. 矿机连接

1. 地址是代理服务器的 **内网** IP
2. 端口是`agent_listen_port`。代理监听的端口,在`agent_conf.json`中配置的。

## 8. 查看日志

查看日志有2种方法。

1. 在`/agent/log/`文件夹下有所有日志
2. 输入下面命令以查看实时日志

```bash
docker logs --tail=50 --follow btcagent
```
