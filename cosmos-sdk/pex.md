# Tendermint网络Peer连接策略

这里将概述AddressBook的设计以及Peer Exchange Reactor（PEX）如何使用它来确保我们与诚实的节点连接，并与其他人广播信息。

## 节点类型

某些节点将被用户指定为永久连接的，这意味着如果连接失败，我们会自动重新连接它们。一些节点可以被标记为私密连接，这意味着我们不会将私密节点放在AddressBook中或将地址广播给其他人。

除私密节点以外的所有节点均使用AddressBook进行跟踪。

## 节点发现

节点发现从seed列表开始。当我们没有连接到节点时，或者无法从已连接的节点中找到足够的节点时，我们拨打随机选择的种子以获得要拨打的同龄人列表。

只要连接数少于`MaxPeers`，我们会定期向邻居请求额外的节点。如果足够的时间过去了，我们仍然找不到足够的节点，我们再次尝试seed。

## Address Book

节点通过他们的ID（即他们的PubKey.Address）被发现。对于每个ID，AddressBook保留最近的IP：PORT。当他们第一次连接到我们或当我们从其他同事那里听到他们时，PEX的地址簿中会添加同行。

AddressBook被安排在一组桶中，并区分审查（旧）和未审查（新）的节点。它为经过审查和未经审查的节点保留不同的成组桶。存储桶提供随机选择。

审查对象只能在一个桶中。一个未审查的节点可以在多个桶中。


## Vetting 审查

首次添加Peer时，它是未审查的。将节点标记为已审核不在p2p软件包的范围内。对于Tendermint，一旦Peer在共识层面作出充分贡献，它就会被认为是经过审查的。即，一旦它向我们发送了`NumBlocksForVetted`块的有效和未知的投票和/或块的一部分。 p2p包的其他用户可以制定相应的条件，以便对Peer进行标记审查。

如果一个Peer通过了审查，但已经有太多的审查Peer，随机选择的一个变得不可信。

如果一个Peer方变得不可信（或者是一个新的Peer，或者之前已经过审查的Peer），则从通讯簿中删除一个随机选择的一个不可信的Peer。

使用信任度量（见下文）可以更细粒度地跟踪对等行为，但最好从简单的事情开始。

## 选择接通Peer

当我们需要更多的Peer时，我们从addrbook中随机挑选，并为Peer设置一些可配置的参数。当我们拥有较少的Peer时，参数应该较低，并且可以随着我们获得更多信息而增加，确保我们的第一批Peer更值得信赖，但总是让我们有机会发现新的好同伴。

我们跟踪我们最后一次Dial Peer的次数以及我们失败次数。如果尝试过多，我们会将Peer标记为坏。

尝试使用指数回退（加上抖动）进行连接尝试。由于选择过程发生在每个`ensurePeersPeriod`，所以我们可能不会最终拨出对等的时间长于回退持续时间。

## 选择Peer连接

当我们被查询Peer时，我们选择他们如下：

- 最多连接`maxGetSelection`个Peer
- 尝试至少选择`minGetSelection`个Peer - 如果少于`minGetSelection`，请全部选中它们。
- 选择一个随机的的`getSelectionPercent`Peer

发送选定的Peer。请注意，我们选择同行发送没有偏见的审查/ 未审查。


## 防止垃圾信息

有很多情况下，我们认为Peer行为不当，我们与他断开关系。发生这种情况时，同伴将从地址簿中删除，并将黑名单列出一段时间。我们称之为“断开并标记”。请注意，可能在PEX Reactor本身之外（例如，在mconnection或其他Reactor中）检测到不良行为，但它必须传送到PEX反应器，以便它可以移除并标记Peer。

在PEX中，如果Peer向我们发送未经请求的对等列表，或者Peer在给定的时间内发送了更多对等点的请求，我们会断开并标记。

## 信任参数

使用比例 - 积分 - 微分（PID）控制器可以更精细地跟踪对等点的质量，该控制器结合当前，过去和变化率数据来检测Peer质量。

虽然PID信任度量已经实现，但仍然需要等到之后的PEX中实现它。

See the [trustmetric](https://github.com/tendermint/tendermint/blob/develop/docs/specification/architecture/adr-006-trust-metric.md) and [trustmetric useage](https://github.com/tendermint/tendermint/blob/develop/docs/specification/architecture/adr-007-trust-metric-usage.md) architecture docs for more details.

https://github.com/tendermint/tendermint/blob/develop/docs/architecture/adr-006-trust-metric.md