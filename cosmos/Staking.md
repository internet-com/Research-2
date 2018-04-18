# Staking

在本文中，我们将具体介绍Cosmos枢纽中权益抵押，委托和治理的流程

# Cosmos

Cosmos并不是一个区块链，而是区块链互联网。在这个网络中，区块链间可以实现价值转移。Cosmos网络中有两种类型的区块链：

* 枢纽：Hub
* 分区：Zone，一般指建立在Tendermint之上的公有的或私有区块链

分区间通过向枢纽发送交易实现相互沟通。也就是说，枢纽实现了分区之间的隔离。分区只需要实现和Hub的单向联通。 

# Cosmos 枢纽

Cosmos 没有准入门槛，任何人都可以参与到枢纽和分区的建立。我们把Cosmos生态中的第一个枢纽称为Cosmos Hub。通过连接到Cosmos Hub，分区可以讲代币转移到任意其他分区。但是每笔交易都要支付给验证人[validators](https://cosmos.network/staking/validators) 和委托人 [delegators](https://cosmos.network/staking/delegators)手续费。 Cosmos Hub 会维护一个手续费白名单（最初将只有Atom和Photon）。但是在将来可以通过治理投票进行修改。

## Proof-of-Stake

区块链网络需要由一组验证人来维护。验证人负责新的区块上链。在PoW的网络中，验证人被成为矿工。矿工获得下一个区块的权利与其算力成正比。Cosmos枢纽是一个基于权益证明的区块链，即区块链的共识获得与验证人的经济利益直接相关。

## Atoms

在Cosmos枢纽中，验证人被选中的频率与其持有的Atom比例成正比。持有的Atom包括绑定和被委托的总和。也就是说，验证人可以绑定自己本身持有的Atom，其他不愿意成为验证人的Atom持有人可以将自身持有的Atom委托给验证人，这些人被称为委托人。抵押和委托的Atom数量总和成为权益总量。 在Cosmos枢纽中，只有Atom可以作为权益代币。为了激励大家将Atom都用于抵押，验证人和委托人将获得抵押利得（以Atom的形式）、区块奖励（以Photon的形式）和交易手续费。若验证人想要收回Atom，则必须要等待三周的时间。 

## Photons

Atoms被设计成用于维护枢纽安全的权益抵押的代币。也就是说，在Cosmos生态中将Atom用于支付手续费或者在分区之间流转是不被鼓励的行为。 为了便于手续费的支付，Comsos提出了 [Photons](https://blog.cosmos.network/cosmos-fee-token-introducing-the-photon-8a62b2f51aa) 代币，它可以用于支付手续费和在分区间流转。我们希望Photon有更强大的流动性和流转速度。Photon和Atom是目前唯一在白名单上的两种代币。

## Hard spoon

Hard spoon可以被看作是映射现有的加密货币状态的方式。我们希望首先实现以太坊到Cosmos的hard spoon映射，也就是说我们希望实现以复制太坊账户余额 ，然后以Photon的形式在 [Ethermint](https://ethermint.zone/)之上使用。在Cosmos 枢纽上线后，Atom的持有者将会对是否激活Hard Spoon进行投票。通过投票，我们可以确

* Hard Spoon是否应该执行
* Hard Spoon预计发生的时间
* Photon在以太币持有人、Atom持有人之间如何分配

## 验证人 Validators

在Cosmos枢纽中，验证人负责将交易打包并提交区块。成为一个验证人需要满足很多条件，不仅仅是技术和硬件上的投资。同时，因为只有在有限验证人的条件下，Tendermint才能发挥最大的作用。目前，我们将Cosmos枢纽的验证人上限定为100。也就是说只有前100个验证人能够获得奖励，而大部分Atom持有者不会成为验证人而是通过委托的方式决定谁会成为验证人。