%Cosmos SDK内部分享

### SDK的设计理念&目标：模块化&权限控制
- Object Capability Security Model 
	- 一维的区块链 VS 多维的区块链
	- Golang的缺点
- Multistore: 多重存储格式 
	- Patricia Trie & IVAL Tree

### object capability system
- object capability system允许节点部署由可信第三方调停的智能合同。 在另一方面，区块链可以称为这个第三方，因为它们已被验证并被信任。

### SDK核心组件
- Transactions & messages 
- Context & Handlers
	- baseapp/baseapp.go:ABCI(CheckTx,DeliverTx...ValidateTx)
	- addRoute=>AnteHandler=>Handler=>Mapper=>Account(键值修改)
	- NewAnteHandler：在交易执行前扣除手续费&检查合法性x/auth/ante.go
	- NewHandler: x/auth: 

### 可扩展部分
- Stores & Mappers
	- app/app.go 
	- capKeyMainStore\*sdk.KVStoreKey
    - capKeyIBCStore\*sdk.KVStoreKey

### 已有库：区块链的基本功能

- bank
- auth:sdk.Account:定义了基本接口函数Get,Set,GetAddress,Getcoin,SetCoin

### Go-wire

- 全新的编码方式
- 优于 JSON









