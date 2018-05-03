## 初始化 Initialization

首先执行:

```
tendermint init
```

以上命令将在默认的文件夹下生成单节点相关的配置文件：

查看 `$HOME/.tendermint`目录:

```
$ ls $HOME/.tendermint

config.toml  data  genesis.json  priv_validator.json
```

对于单节点来说，无需更多配置就可以运行。多节点集群的配置将在之后介绍。

## 本地单节点 Local Node

通过启动一个内置的应用来运行Tendermint:

```
tendermint node --proxy_app=kvstore
```

之后你可以看到区块生成的信息不断出现：

```
I[01-06|01:45:15.592] Executed block                               module=state height=1 validTxs=0 invalidTxs=0
I[01-06|01:45:15.624] Committed state                              module=state height=1 txs=0 appHash=
```

通过RPC 查看状态：

```
curl -s localhost:46657/status
```

### 发送交易 

在保证 kvstore运行的状态下，可以通过以下方式发送交易：

```
curl -s 'localhost:46657/broadcast_tx_commit?tx="abcd"'
```

通过abci查询语句确认交易已打包:

```
curl -s 'localhost:46657/abci_query?data="abcd"'
```

我们也可以通过键值对的方式发送交易：

```
curl -s 'localhost:46657/broadcast_tx_commit?tx="name=satoshi"'
```

然后通过key查询数据:

```
curl -s 'localhost:46657/abci_query?data="name"'
```

返回的数据是16进制的。

## 本地集群 Cluster of Nodes

假设你有四台安装有Ubuntu 16.04 x64系统的服务器，IP地址分别是 IP1, IP2, IP3, IP4。

登陆到服务器上，然后完成go v1.10的安装。[执行以下脚本](https://git.io/vNLfY):

```
curl -L https://git.io/vNLfY | bash
source ~/.profile
```

这样就可以完成`go` 和其他相关依赖的安装。然后可以编译生成	`tendermint`的可执行文件。

然后进入 `docs/examples`目录，在每一个节点执行以下命令：

```
tendermint node --home ./node1 --proxy_app=kvstore --p2p.persistent_peers="3a558bd6f8c97453aa6c2372bb800e8b6ed8e6db@IP1:46656,ccf30d873fddda10a495f42687c8f33472a6569f@IP2:46656,9a4c3de5d6788a76c6ee3cd9ff41e3b45b4cfd14@IP3:46656,58e6f2ab297b3ceae107ba4c8c2898da5c009ff4@IP4:46656"
tendermint node --home ./node2 --proxy_app=kvstore --p2p.persistent_peers="3a558bd6f8c97453aa6c2372bb800e8b6ed8e6db@IP1:46656,ccf30d873fddda10a495f42687c8f33472a6569f@IP2:46656,9a4c3de5d6788a76c6ee3cd9ff41e3b45b4cfd14@IP3:46656,58e6f2ab297b3ceae107ba4c8c2898da5c009ff4@IP4:46656"
tendermint node --home ./node3 --proxy_app=kvstore --p2p.persistent_peers="3a558bd6f8c97453aa6c2372bb800e8b6ed8e6db@IP1:46656,ccf30d873fddda10a495f42687c8f33472a6569f@IP2:46656,9a4c3de5d6788a76c6ee3cd9ff41e3b45b4cfd14@IP3:46656,58e6f2ab297b3ceae107ba4c8c2898da5c009ff4@IP4:46656"
tendermint node --home ./node4 --proxy_app=kvstore --p2p.persistent_peers="3a558bd6f8c97453aa6c2372bb800e8b6ed8e6db@IP1:46656,ccf30d873fddda10a495f42687c8f33472a6569f@IP2:46656,9a4c3de5d6788a76c6ee3cd9ff41e3b45b4cfd14@IP3:46656,58e6f2ab297b3ceae107ba4c8c2898da5c009ff4@IP4:46656"
```

注意到当第三个节点启动后，系统可以出块。因为超过2/3的验证人已经上线。

