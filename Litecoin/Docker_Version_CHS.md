# Poolin Litecoin 智能代理使用说明 (docker 方法运行)

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
    "agent_listen_ip": "0.0.0.0",
    "agent_listen_port": 8888,
    "pools": [
        ["ltc.ss.poolin.com", 25, "replace_your_account"]
    ]
}
```

配置文件含义如下

- agent_listen_ip `[string]`: 代理监听的ip, 写 “0.0.0.0” 表示本机ip。
- agent_listen_port `[int 0 - 65535]`: 代理监听的端口. 
- pools`[list]`: 矿池地址的相关配置。最多写三个。配置多个矿池地址可以避免因网络抖动其中一个挖矿地址断开导致的矿机算力抖动。
  - 第一个参数 `[string]` : 矿池地址
  - 第二个参数 `[int 0-65535]` : 矿池端口
  - 第三个参数 `[string]` : 子账户


## 5. 下载docker镜像

仅以linux下的操作为例。

```shell
docker pull registry.cn-beijing.aliyuncs.com/poolin_public/ltcagent:0.0.1
```

## 6. 运行代理镜像

1. 确保刚刚新建的文件夹是 `/agent`
2. 配置文件的`agent_listen_port`要记住，这里以`8888`为例

```shell
docker run -d -v /agent/:/work/agent --name ltcagent --network="host" --dns 119.29.29.29  --dns 182.254.116.116 --dns 1.1.1.1 --restart=always registry.cn-beijing.aliyuncs.com/poolin_public/ltcagent:0.0.1
```

## 7. 矿机连接

1. 地址是代理服务器的 **内网** IP
2. 端口是`agent_listen_port`。代理监听的端口,在`agent_conf.json`中配置的。

## 8. 查看日志

查看日志有2种方法。

1. 在`/agent/log/`文件夹下有所有日志
2. 输入下面命令以查看实时日志

```bash
docker logs --tail=50 --follow ltcagent
```
