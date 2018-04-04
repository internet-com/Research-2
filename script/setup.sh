#!/bin/sh

rm -rf ~/.iris1
rm -rf ~/.iris2
rm -rf ~/.iris-cli

MYNAME=abc
password=1234567890
#echo $password|echo $password|iris client keys new $MYNAME
SEED=`echo $password|echo $password|iris client keys new $MYNAME | tail -1`
MYADDR=`iris client keys get $MYNAME | cut -f3`

echo "get address of $MYNAME: $MYADDR"
echo "get seed: $SEED"

echo "init iris node"
iris node  init $MYADDR --home=$HOME/.iris1 --chain-id=test
iris node  init $MYADDR --home=$HOME/.iris2 --chain-id=test
ID=`tendermint show_node_id --home=$HOME/.iris1| tail -1`
echo "node id is : $ID"




