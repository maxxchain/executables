#!/bin/bash

DELAY_SEC=15
MINNER_ADDR=0x3b8a98990826Cf43c555014D7dE850cD98aC9bcF
SERVER_IP=
CHAIN_ID=10201
DATA_DIR=./data
IS_ARCHIVE_NODE=true
IS_LIGHT_NODE=false
IS_FULL_NODE=false

runWithDelay () {
    sleep $1;
    shift;
    "${@}";
}

runWithDelay $DELAY_SEC ./build/bin/geth attach --exec admin.nodeInfo.enode $DATA_DIR/geth.ipc &

if $IS_ARCHIVE_NODE
then
    nohup ./build/bin/geth --datadir $DATA_DIR --networkid $CHAIN_ID --http --http.addr 0.0.0.0 --port 30303 --http.port 8545 --http.api personal,eth,net,debug,txpool,web3,admin --http.corsdomain '*' --ws --ws.addr 0.0.0.0 --ws.port 8546 --ws.api personal,eth,net,debug,txpool --http.vhosts '*' --syncmode full --gcmode archive --nat extip:$SERVER_IP --mine --miner.threads=1 --miner.etherbase=$MINNER_ADDR &
elif $IS_LIGHT_NODE
then
    nohup ./build/bin/geth --datadir $DATA_DIR --networkid $CHAIN_ID --http --http.addr 0.0.0.0 --port 30303 --http.port 8545 --http.api personal,eth,net,debug,txpool,web3,admin --http.corsdomain '*' --ws --ws.addr 0.0.0.0 --ws.port 8546 --ws.api personal,eth,net,debug,txpool --http.vhosts '*' --syncmode snap --nat extip:$SERVER_IP --mine --miner.threads=1 --miner.etherbase=$MINNER_ADDR &
elif $IS_FULL_NODE
then
    nohup ./build/bin/geth --datadir $DATA_DIR --networkid $CHAIN_ID --http --http.addr 0.0.0.0 --port 30303 --http.port 8545 --http.api personal,eth,net,debug,txpool,web3,admin --http.corsdomain '*' --ws --ws.addr 0.0.0.0 --ws.port 8546 --ws.api personal,eth,net,debug,txpool --http.vhosts '*' --syncmode full --nat extip:$SERVER_IP --mine --miner.threads=1 --miner.etherbase=$MINNER_ADDR &
else
    echo "Nothing...";
fi
