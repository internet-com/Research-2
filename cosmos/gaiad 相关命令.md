Gaiad 使用说明

1.Gaiad 可用指令：

```
gaiad --help
Gaia Daemon (server)

Usage:
  gaiad [command]

Available Commands:
  init             Initialize genesis config, priv-validator file, and p2p-node file
  start            Run the full node
  unsafe_reset_all Reset blockchain database, priv_validator.json file, and the logger

  tendermint       Tendermint subcommands
  export           Export state to JSON

  version          Print the app version
  help             Help about any command

Flags:
  -h, --help               help for gaiad
      --home string        directory for config and data (default "/Users/suyu/.gaiad")
      --log_level string   Log level (default "main:info,state:info,*:error")
      --trace              print out full stack trace on errors

Use "gaiad [command] --help" for more information about a command.
```

1.1 初始化

```
gaiad init --home=<path-to-home> --name=<your-name>
```
home默认为~/.gaiad
示例输出：
```
gaiad init --name=suyu
{
  "chain_id": "test-chain-45SHiw",
  "node_id": "aabf05a67b2f399807dc602d05bf97b0ed283ac2",
  "app_message": {
    "secret": "artwork road denial knock truly allow enact write about remove market soon jewel auction august abandon"
  }
}
```
在home路径下生成以下文件夹
```
config	data
```
data用于存放区块链数据
```
blockstore.db  cs.wal  evidence.db  gaia.db  mempool.wal  state.db  tx_index.db
```
config用于存放有关配置文件
```
addrbook.json  config.toml  genesis.json  node_key.json  priv_validator.json
```
各个文件的作用：

addrbook.json ：本节点已知的节点IP信息，

genesis.json：区块链网络创世文件，[链接](https://github.com/cosmos/cosmos-sdk/blob/master/cmd/gaia/testnets/gaia-6002/genesis.json)

config.toml：各个节点自定义的配置信息，[链接](https://docs.google.com/document/d/1lZF2ZTY9HThh_Ra373yTPRj5os813ScQgJwExBtC6uk/edit) 

node_key.json：用于p2p网络层的验证节点身份的id文件
```json
{"priv_key":{"type":"954568A3288910","value":"a5GFJeejZawp4Ulq9kJwuTTsRQeTg5P0f5ZEqs5YosYW+X9t8roumWGcWDhg4ztRoqbKP4Ew8dNJ+yHW9F1qNQ=="}}
```

priv_validator.json：用于PoS中，验证人节点辨识身份的文件


```json
{
  "address": "295C0821D6D2EC71772E86773CD7F46F072CB764",
  "pub_key": {
    "type": "AC26791624DE60",
    "value": "7SaH/LyM+qdz9ovD/pvqIf2q7LC7tc5v0ZJxsA2CGTw="
  },
  "last_height": 0,
  "last_round": 0,
  "last_step": 0,
  "priv_key": {
    "type": "954568A3288910",
    "value": "DOND5bHvsB7KF2SUdS6cN4FiZEVTXwkkprVppYYIeN7tJof8vIz6p3P2i8P+m+oh/arssLu1zm/RknGwDYIZPA=="
  }
}
```


1.2 重置

作用：若需要重启，或者hard fork升级到新的测试网后，需要重置来保证可以正常启动：

```
gaiad unsafe_reset_all --home=<path-to-dir>
```
输出：
```
I[06-19|14:12:47.993] Reset PrivValidator to genesis state         module=main file=/Users/suyu/.gaiad/config/priv_validator.json
I[06-19|14:12:48.056] Removed all blockchain history               module=main dir=/Users/suyu/.gaiad/data
```
将验证人集重置为genesis文件中的集合&清空区块数据



1.3 获得与Tendermint有关信息

* 获得当前节点的公钥
```
gaiad tendermint show_validator
```
范例输出：
```
cosmosvalpub1zcjduc3qa5ng0l9u3na2wulk30plaxl2y8764m9shw6uum73jfcmqrvzry7qw82ez4
```
实现原理：
https://github.com/cosmos/cosmos-sdk/blob/55708dadbf018ad853b7191d007579aa485675f8/server/tm_cmds.go#L34

加载priv_validator.json文件,若此文件不存在则自动生成，从私钥推导出公钥，最终显示bech32编码后的公钥,

，前缀为:

```
Bech32PrefixValPub  = "cosmosvalpub"
```


* 获得当前节点的ID
```
gaiad tendermint show_node_id
```
范例输出：
```
aabf05a67b2f399807dc602d05bf97b0ed283ac2
```
实现原理：
https://github.com/cosmos/cosmos-sdk/blob/55708dadbf018ad853b7191d007579aa485675f8/server/tm_cmds.go#L17

加载node_key.json文件，若此文件不存在则自动生成，从私钥推导出公钥，公钥推导出地址，最终显示编码后的地址

2. 启动节点

```
gaiad start --home=<path-to-dir> > <path-to-log-file>&
```
TODO:
适用logrotate定时清理日志

参考资料：http://blog.jobbole.com/111385/ 