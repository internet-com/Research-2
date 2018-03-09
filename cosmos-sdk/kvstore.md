1.将tx.go和main.go合并为一个文件
2. go run main.go
3.测试
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