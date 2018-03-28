# Tendermint Peers节点

本文档介绍了Tendermint Peers如何识别以及它们如何相互连接。

## Peer身份

Tendermint Peer将以公钥的形式保持其身份。每个对等体都有一个ID定义为`peer.ID == peer.PubKey.Address（）`，其中`Address`使用Go-crypto中定义的方案。

单个Peer ID可以有多个与之关联的IP地址。 

当试图连接到Peer时，我们使用PeerURL：`<ID> @ <IP>：<PORT>`。我们将试图通过IP：PORT连接到Peer，并通过认证加密验证它是否拥有对应于<ID>的私钥。这可以防止中间人攻击。

Peer也可以连接到没有指定ID，即。只是`<IP>：<PORT>`。在这种情况下，对等方必须通过Tendermint带外验证，例如通过VPN。

## 连接

所有的p2p连接都使用TCP。在与Peer建立成功的TCP连接后，将执行两个握手：一个用于验证加密，另一个用于Tendermint版本控制。两次握手都有可配置的超时时间（应尽快完成）。

### 认证加密握手

Tendermint implements the Station-to-Station protocol using ED25519 keys for Diffie-Helman key-exchange and NACL SecretBox for encryption. It goes as follows:
Tendermint使用ED25519密钥实现Station-to-Station协议，使用Diffie-Helman密钥交换和NACL SecretBox加密。如下所示：


- 生成一个 ED25519 密钥对
- 将临时公钥发送给 peer
- 等待收到同伴的临时公钥
- 使用同伴临时公钥和我们的临时私钥来计算Diffie-Hellman共享密钥
- 生成两个用于加密（发送和接收）的随机数，如下所示：
  - 按升序对临时公钥进行排序并连接它们
  - 对结果进行RIPEMD160计算
  - 追加4个空字节（将散列扩展为24字节）
  - 结果是nonce1
  - 翻转nonce1的最后一位以获得nonce2
  - 如果我们有更小的临时pubkey，使用nonce1接收，nonce2发送;否则相反
- 从现在开始的所有通信都使用共享密钥和随机数进行加密，每次使用时每次随机数加2
- 我们现在有一个加密channel，但仍需要进行身份验证
- 生成一个需要签署的共同问题
  - 排序串联的临时公钥的SHA256的结果（最低的第一个）
- 用我们持久的私钥签署共同的问题
- 发送go-wire编码的永久性pubkey和签名给对等体
- 等待接收来自Peer的持久公钥和签名
- 使用对等方的永久公钥验证问题签名

如果这是一个传出连接（我们拨打对方）并且我们使用了一个对等ID，那么最后验证对方的永久公钥对应于我们所拨打的对等ID，即。 `peer.PubKey.Address（）== <ID>`。

该连接现在已通过身份验证。所有流量都被加密。

注意：只有Dailer可以验证对等者的身份，但这是我们关心的，因为当我们加入网络时，我们希望确保我们已经连接到了预期的Peer，并且不会被中间人攻击。

### Peer 过滤器

在继续之前，我们检查新Peer是否具有与我们自己或现有Peer相同的ID。如果是这样，我们断开。

我们还检查Peer的地址和公钥，并将其与可通过ABCI应用管理的可选白名单进行对比 - 如果白名单已启用且对等方不符合条件，则连接将终止。


### Tendermint 版本握手

Tendermint版本握手允许Peer交换他们的NodeInfo：

```
type NodeInfo struct {
  PubKey     crypto.PubKey
  Moniker    string
  Network    string
  RemoteAddr string
  ListenAddr string
  Version    string
  Channels   []int8
  Other      []string
}
```

在下列情况下，连接断开：

- `peer.NodeInfo.PubKey！= peer.PubKey`
- `peer.NodeInfo.Version`没有被格式化为`X.X.X`，其中X是被称为Major，Minor和Revision的整数
- `peer.NodeInfo.Version` Major与我们不一样
- `peer.NodeInfo.Version`小调和我们的不一样
- peer.NodeInfo.Network与我们的不一样
- “peer.Channels”不与我们已知的频道相交。

此时，如果我们没有断开连接，对方是有效的。它通过`AddPeer`方法添加到开关，因此所有的Reactor。请注意，每个Reactor可能处理多个通道。

## 连接活动

一旦添加了一个Peer，给定反应堆的传入消息就通过该Reactor的`Receive`方法处理，并且输出消息由每个Peer的Reactors直接发送。一个典型的Reactor维护处理这个问题的处理程序。