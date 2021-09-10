# 智能代理参数设置说明

- 必填项
  - host_coin `[string]`       : 要代理的币种，目前支持 BTC/ETH/DASH/LTC，其他币种会逐渐支持。
  - proxy_port `[int 0-65535]` : 代理机器 stratum 端口，默认端口 BTC：8001， ETH：8005；可根据端口占用实际情况修改。
  - docker_name `[string]`     : 代理 docker 容器名称，默认名称   BTC：proxy_btc ETH: proxy_eth。

- 可选项
  - up_server_mode `[string]`  : 连接上一级服务(通常为矿池)的模式 (代理默认 AUTO )
    - AUTO       自动模式:(proxy 默认): 自动选择网络通信最好的 ip；
    - SEQUENCE   顺序模式:(pool server 默认): 按配置文件的顺序设置 ip 优先级，若优先级高的 ip 不可用, 会依次按优先级选择下一个 ip. 优先级最高的 ip 可用后, 会自动切回；
    - CONFUSE    混淆模式:(满足部分矿场需求): 随机选择 ip, 单个 ip 通信时间不会超过 60 分钟, 可能连接到境外 ip, 会切换到通信不好的 ip 上, 可能影响算力。

  - user_name `[string]`       : 代理机器设置矿机统一子账号(默认为空,矿机设置生效,非空则以代理设置为准)。
  - up_server_address`[list]`  : 代理可以连接的poolin矿池地址用","分隔，默认 eth-agent3.ss.poolin.com。
  - notify_token `[string]`    : 用于代理运行时候异常报警出口：目前支持钉钉/Slack的机器人，此处填写机器人token，可及时提示代理任何异常，例如 job 超时，网络延迟等;

  ```asm
  例如:
  notify_token="https://oapi.dingtalk.com/robot/send?access_token=ccfe489...c7f673"
  notify_token="https://hooks.slack.com/services/T01A3MY4UTW/B02CS0JU8KC/PsQd...j0Lq"
  ```

  - host `[string]`            : 钉钉/Slack通知时代理机器的描述字符串，例如 host="my_eth_proxy_001"
  - health_check_fail_duration `[int]`: 健康检查检测失败后, 多少分钟内不会断开矿机连接 0:表示永远保持矿机连接，默认值为1分钟后断开矿机连接.
  - reject_share_count `[int]`  : 矿机提交最后一个被接受 share 后, 累计拒绝 share 数量, 触发后断开矿机连接. 若设置为 0 则不做判断. 默认值 10，超过 10 个 share 连续被拒绝, 则断开矿机连接.
