# 如何加入Cosmos测试网络

## 安装程序

Requirement :

 [Go 1.10](https://golang.org/dl/)

 [dep](https://github.com/golang/dep)

### 步骤

**下载源码**

```
go get github.com/cosmos/cosmos-sdk
```

如果遇到一下问题请忽略：
```
package github.com/cosmos/gaia: no Go files in /go/src/github.com/cosmos/sdk
```

然后安装相关依赖，请保证机器可以科学上网：

```
cd $GOPATH/src/github.com/cosmos/cosmos-sdk
git fetch --all
git checkout 0f2aa6b
make get_tools
make get_vendor_deps
make install
make install_examples
```

执行完以上步骤后，应该安装。通过执行一下命令验证安装了正确的版本：

```
gaiad version
```

应该返回:

```
0.15.0-rc0-0f2aa6b
```

同样的:

```
gaiacli version
```

应该返回:

```
0.15.0-rc0-0f2aa6b
```

### 获取Genesis文件

初始化Gaiad:
```
gaiad init
```
替换genesis.json 和 config.toml 文件:
```
rm $HOME/.gaiad/config/genesis.json $HOME/.gaiad/config/config.toml $HOME/.gaiad/config/addrbook.json

wget -O $HOME/.gaiad/config/genesis.json https://raw.githubusercontent.com/tendermint/testnets/master/gaia-4000/genesis.json

wget -O $HOME/.gaiad/config/config.toml https://raw.githubusercontent.com/tendermint/testnets/master/gaia-4000/config.toml
```
然后可以通过修改config.toml文件中的` moniker `字段来指定自己的名称。

### 启动Gaiad
```
gaiad start
```

### 领取代币

通过执行以下命令创建账户:

```
gaiacli keys add default
```
在以下网站 https://faucet.adrianbrink.com 输入地址来领取代币。

### 成为一个验证人Validator

一旦完成了以上步骤，你就可以通过以下命令获得节点的公钥：

```
gaiad show_validator
```
请将以上命令输出在这个网站https://cryptii.com/base64-to-hex 完成Base64到hex的转换。将Group by 设置为None.

发送Bond交易：
（请确认validator的pubkey是正确的）
通过执行以下命令绑定`steak`成为一个验证人。
```
gaiacli bond --stake=6steak --validator=45798afe9b0cd7a05b765107b744478f91848d18a54ce7d06daace1c71a56913 --sequence=0 --chain-id=gaia-4000 --name=default
```


遇到问题可以到Riot chat: https://riot.im/app/#/room/#cosmos:matrix.org上与开发人员交流。