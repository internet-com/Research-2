# 如何加入Cosmos测试网络

## 安装

要求 :

[Go 1.9+](https://golang.org/dl/)

[dep](https://github.com/golang/dep)

### 步骤

下载源码**

```
go get github.com/cosmos/cosmos-sdk
```

然后获得正确的版本

```
cd $GOPATH/src/github.com/cosmos/cosmos-sdk
git fetch --all
git checkout 9d90c6b
make get_tools
make get_vendor_deps
make install
make install_examples
```

检查是否安装正确：

```
gaiad version
```

你应该看到:

```
0.15.0-rc1-9d90c6b
```

同样的:

```
basecli version
```

你应该看到:

```
0.15.0-rc1-9d90c6b
```

## 配置Genesis 文件

初始化Gaiad:

```
gaiad init
```

替换genesis.json 和 config.toml 文件:

```
gaiad unsafe_reset_all

rm $HOME/.gaiad/config/genesis.json $HOME/.gaiad/config/config.toml

wget -O $HOME/.gaiad/config/genesis.json https://raw.githubusercontent.com/tendermint/testnets/master/gaia-3007/gaia/genesis.json

wget -O $HOME/.gaiad/config/config.toml https://raw.githubusercontent.com/tendermint/testnets/master/gaia-3007/gaia/config.toml
```

最好修改`config.toml` 文件中的moniker字段来识别自己。

## 启动主要进程

```
gaiad start
```

## 获得代币

生成账户：

```
basecli keys add default
```

在以下网站申请代币

## 成为验证人

一旦你的节点开始运行了，你就可以绑定成为验证人。

获得节点的公钥：

```
gaiad show_validator
```

请将以上命令的输出值在 [这个网站](http://tomeko.net/online_tools/base64.php?lang=en) 转化为16进制数（不要使用0x，并且输出是小写）

执行绑定交易：
**请注意不要绑定过多：

```
basecli bond --stake=6steak --validator=45798afe9b0cd7a05b765107b744478f91848d18a54ce7d06daace1c71a56913 --sequence=0 --chain-id=gaia-3006 --name=default
```
常见错误：

sequence