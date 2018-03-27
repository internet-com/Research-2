# P2P 多路连接

## MConnection 多路连接

`MConnection` is a multiplex connection that supports multiple independent streams with distinct quality of service guarantees atop a single TCP connection. Each stream is known as a `Channel` and each `Channel` has a globally unique *byte id*. Each `Channel` also has a relative priority that determines the quality of service of the `Channel` compared to other `Channel`s. The *byte id* and the relative priorities of each `Channel` are configured upon initialization of the connection.

`MConnection`是一种多路连接，支持多个独立的数据流，并在单个TCP连接上提供不同的服务质量保证。 每个流被称为“Channel”，每个Channel都有一个全局唯一的*字节id *。 每个“频道”也有一个相对优先权，决定了与其他频道相比，频道的服务质量。 *字节id *和每个`Channel`的相对优先级在连接初始化时配置。

`MConnection`支持一下数据类型:

- Ping
- Pong
- Msg

### Ping & Pong

ping和pong消息由向连接写入单个字节组成; 分别为0x1和0x2。

当我们在'pingTimeout`的时间内没有收到'MConnection`的任何消息时，我们发送一条ping消息。 当在'MConnection'上接收到一个ping命令时，只有在没有其他消息要发送并且对方没有给我们发送太多ping的情况下才会发送乒乓响应。

如果pong或消息在Ping后没有在足够的时间内收到，则节点将断开连接。

### Msg 消息

通道中的消息被分成更小的`msgPacket`s进行多路复用。

```
type msgPacket struct {
	ChannelID byte
	EOF       byte // 1 means message ends here.
	Bytes     []byte
}

```

`msgPacket`使用[go-wire](https://github.com/tendermint/go-wire)进行序列化，并以0x3作为前缀。 接收到的连续数据包集的`Bytes`被附加在一起，直到收到一个`EOF = 1`的数据包为止，然后完整的串行化消息被返回给相应通道的`onReceive`函数进行处理。

### Multiplexing 多路复用


消息从一个单一的`sendRoutine`发送，它通过选择语句循环并导致发送ping，pong或一批数据消息。 该批数据消息可以包括来自多个通道的消息。 消息字节在其各自的信道中排队等待发送，每个信道一次保持一个未发送消息。 从最近发送字节与信道优先级之比最低的信道中一次一批地选择消息。

## 发送消息

发送消息可以采用以下两种方法：

```
func (m MConnection) Send(chID byte, msg interface{}) bool {}
func (m MConnection) TrySend(chID byte, msg interface{}) bool {}
```

`Send（chid，msg）`是一个阻塞调用，等待`msg`成功排队等待给定的id字节`chID`的通道。 `msg`消息使用`tendermint / wire`子模块的`WriteBinary（）`反射例程序列化。

`TrySend（chid，msg）`是一个非阻塞调用，如果队列未满，则将带有给定id字节chID的消息msg排队在队列中; 否则立即返回false。

`Send（）`和`TrySend（）`会暴露给每个`Peer`。

## 节点

每个节点都有一个`MConnection`实例，并包含其他信息，如连接是否断开，连接是否应该在关闭时重新创建，有关节点的各种身份信息以及反应堆使用的其他更高级别线程安全数据。


## Switch/Reactor


`Switch`处理节点连接并公开一个API来接收`Reactors`上的传入消息。 每个`Reactor`负责处理一个或多个`Channels`的传入消息。 因此，在发送传出消息时通常在对等体上执行，传入消息在反应堆上接收。


```
// Declare a MyReactor reactor that handles messages on MyChannelID.
type MyReactor struct{}

func (reactor MyReactor) GetChannels() []*ChannelDescriptor {
    return []*ChannelDescriptor{ChannelDescriptor{ID:MyChannelID, Priority: 1}}
}

func (reactor MyReactor) Receive(chID byte, peer *Peer, msgBytes []byte) {
    r, n, err := bytes.NewBuffer(msgBytes), new(int64), new(error)
    msgString := ReadString(r, n, err)
    fmt.Println(msgString)
}

// Other Reactor methods omitted for brevity
...

switch := NewSwitch([]Reactor{MyReactor{}})

...

// Send a random message to all outbound connections
for _, peer := range switch.Peers().List() {
    if peer.IsOutbound() {
        peer.Send(MyChannelID, "Here's a random message")
    }
}
```