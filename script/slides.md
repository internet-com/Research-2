%Cosmos SDK内部分享

### SDK的设计理念&目标：模块化&权限控制
- Object Capability Security Model 
	- 一维的区块链 VS 多维的区块链
	- Golang的缺点
- Multistore: 多重存储格式 
	- Patricia Trie & IVAL Tree

### SDK核心组件
- Transactions & messages 
- Context & Handlers
	- NewAnteHandler：在交易执行前扣除手续费&检查合法性x/auth/ante.go
	- NewHandler: x/auth: 
	- addRoute->AnteHandler->Handler->Mapper->Account(键值修改)

### 可扩展部分
- Stores & Mappers
	- app/app.go 
	- capKeyMainStore\*sdk.KVStoreKey
    - capKeyIBCStore\*sdk.KVStoreKey
    - baseapp/baseapp.go: ABCI(CheckTx,DeliverTx...ValidateTx)

### 已有库

- bank
- auth:sdk.Account:定义了基本接口函数Get,Set,GetAddress,Getcoin,SetCoin

### Go-wire

全新的编码方式










