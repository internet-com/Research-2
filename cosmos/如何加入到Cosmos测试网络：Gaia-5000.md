# 如何加入到Cosmos测试网络：Gaia-5000 

## 安装步骤

环境要求 :

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
git checkout v0.16.0-rc0
make get_tools
make get_vendor_deps
make install
```

执行完以上步骤后，应该安装。通过执行一下命令验证安装了正确的版本：

```
gaiad version
```

应该返回:

```
0.16.0-dev-7ef5e90f
```

同样的:

```
gaiacli version
```

应该返回:

```
0.16.0-dev-7ef5e90f
```
## 获取Genesis文件

保证文件夹正确：

```
rm -rf $GOPATH/src/github.com/cosmos/testnets/
rm -rf $HOME/.gaiad/config/gentx
```

从网上下载配置文件:

```
mkdir $HOME/.gaiad/config/gentx
go get github.com/cosmos/testnets
```

将配置文件拷贝到默认路径下

```
cp -a $GOPATH/src/github.com/cosmos/testnets/gaia-5000/. $HOME/.gaiad/config/gentx
```

生成genesis.json 和 config.toml 文件:

```
gaiad init --gen-txs -o --chain-id=gaia-5000 --home=/mnt/gaia_node/gaia-5000
```

然后可以通过修改config.toml文件中的moniker字段来指定自己的名称。

## 启动Gaiad

```
gaiad start
```

通过[Cosmos Monotor](http://explorer.adrianbrink.com/)检查运行状况，需要把Node IP换成http://207.154.243.140:46657 

## 领取代币

通过执行以下命令创建账户:

    gaiacli keys add default

请保存好助记词。然后到Riot chat: <https://riot.im/app/#/room/#cosmos:matrix.org>

中询问@adrian:matrix.org 获得steak代币。

未来也在以下网站 https://faucet.adrianbrink.com 输入地址来领取代币。

## Bond成为验证人

查询账户余额：
```
gaiacli account $MYADDR
```
在查询到账户余额不为0后，通过执行以下命令，成为验证人之一：

```
gaiacli delegate --address-candidate=<your-address> --address-delegator=<your-address> --amount=10steak --name=<your-name> --chain-id=gaia-5000 
```

你可以在以下命令中看到自己的公钥：

```
gaiacli validatorset
```
## Delegate成为委托人

查询账户余额：
```
gaiacli account $MYADDR
```
在查询到账户余额不为0后，通过执行以下命令，成为验证人之一：

```
gaiacli delegate --address-candidate=<validator-address> --address-delegator=<your-address> --amount=10steak --name=<your-name> --chain-id=gaia-5000 
```

你可以在以下命令中查询委托记录：

```
gaiacli delegator-bond  --address-delegator=<your-address> --chain-id=gaia-5000  --address-candidate=<validator-address>
```