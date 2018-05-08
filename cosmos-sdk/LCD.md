# Light Client Protocol 轻客户端协议

Tendermint为轻量级客户端应用程序提供独特的速度和安全属性。 轻客户端是大多数应用程序的完整区块链系统的重要组成部分。

具体 [lite package](https://godoc.org/github.com/tendermint/tendermint/lite).

## 概览

轻客户端协议的意图在于获得一个最近的 [block hash](https://github.com/tendermint/tendermint/blob/master/docs/specification/block-structure.html#block-hash) 对应的[commit](https://github.com/tendermint/tendermint/blob/master/docs/specification/validators.html#committing-a-block) ，它包含了大多数验证人的签名集。依据此，所有应用状态可以获得 [默克尔证明](https://github.com/tendermint/tendermint/blob/master/docs/specification/merkle.html#iavl-tree).

## 特性

- 用户获得Tendermint的验证人抵押担保; 无需等待确认。
- 用户借助Tendermint的验证速度; 交易立即提交。
- 用户可以非交互方式获得应用程序状态的最新版本（不向区块链提交任何内容）。 例如，这意味着您可以从名称注册中心获取名称的最新值，而无需担心分叉检查攻击，而无需发布提交和等待确认。 它快速，安全，免费！