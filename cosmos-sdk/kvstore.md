1. 将tx.go和main.go合并为一个文件

2. go run main.go

3. 测试

```
http://localhost:46657/broadcast_tx_commit?tx="hello"
{
  "jsonrpc": "2.0",
  "id": "",
  "result": {
    "check_tx": {
      "log": "set hello=hello",
      "fee": {}
    },
    "deliver_tx": {
      "log": "set hello=hello"
    },
    "hash": "995DE4D6FA43728945C235642E5DCCB64C08B4A2",
    "height": 73
  }
}
```

```

 ./basecoind init
I[03-06|09:30:20.031] Found private validator                      module=main path=/Users/b/.basecoind/config/priv_validator.json
I[03-06|09:30:20.031] Found genesis file                           module=main path=/Users/b/.basecoind/config/genesis.json
Secret phrase to access coins:
canvas blood spot goose victory crush question zone vintage whisper gentle prison defy frost artefact abandon
```