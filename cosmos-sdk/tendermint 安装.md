采用了Gopkg依赖
https://supereagle.github.io/2017/10/05/golang-dep/
go get -u github.com/golang/dep/cmd/dep
dep ensure
dep status
go install ./cmd/tendermint