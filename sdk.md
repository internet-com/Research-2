# Cosmos-SDK app 数据流程

app中将checkTX和deliverTX分别存储到不同的multistore中

* checkTX：调用`runTx()`,通过`ValidateBasic`和`defaultAnteHandler`过滤无效的交易

* BeginBlock: 将checkTX获得的数据赋值给deliverTX的存储空间。`msDeliver = app.cms.CacheMultiStore()`

* deliverTX：调用`runTx()`,通过`ValidateBasic`和`defaultAnteHandler`再次过滤无效的交易，然后再查找制定`Route`得到Handler将消息执行，写入键值store后结果返回。

* EndBlock:返回更新过的新app实例：为什么msDeliver会变为nil？

* Commit：cache的数据持久化
    ```golang
    app.msDeliver.Write()
	commitID := app.cms.Commit()
	```


