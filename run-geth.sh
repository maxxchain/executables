#!/bin/bash

DELAY_SEC=15
MINNER_ADDR=0xC446Fb0A23115f178B48498DB622ab606Fb0DC55
SERVER_IP=203.161.32.22
CHAIN_ID=1023
DATA_DIR=/data/geth-data
IS_ARCHIVE_NODE=true
IS_LIGHT_NODE=false
IS_FULL_NODE=false

runWithDelay $DELAY_SEC geth attach --exec admin.nodeInfo.enode $DATA_DIR/geth.ipc &

if $IS_ARCHIVE_NODE
then
    nohup geth --datadir $DATA_DIR --networkid $CHAIN_ID --http --http.addr 0.0.0.0 --port 30303 --http.port 8545 --http.api personal,eth,net,debug,txpool,web3,admin --http.corsdomain '*' --ws --ws.addr 0.0.0.0 --ws.port 8546 --ws.api personal,eth,net,debug,txpool --http.vhosts '*' --syncmode full --gcmode archive --nat extip:$SERVER_IP --mine --miner.threads=1 --miner.etherbase=$MINNER_ADDR &
elif $IS_LIGHT_NODE
then
    nohup geth --datadir $DATA_DIR --networkid $CHAIN_ID --http --http.addr 0.0.0.0 --port 30303 --http.port 8545 --http.api personal,eth,net,debug,txpool,web3,admin --http.corsdomain '*' --ws --ws.addr 0.0.0.0 --ws.port 8546 --ws.api personal,eth,net,debug,txpool --http.vhosts '*' --syncmode snap --nat extip:$SERVER_IP --mine --miner.threads=1 --miner.etherbase=$MINNER_ADDR &
elif $IS_FULL_NODE
then
    nohup geth --datadir $DATA_DIR --networkid $CHAIN_ID --http --http.addr 0.0.0.0 --port 30303 --http.port 8545 --http.api personal,eth,net,debug,txpool,web3,admin --http.corsdomain '*' --ws --ws.addr 0.0.0.0 --ws.port 8546 --ws.api personal,eth,net,debug,txpool --http.vhosts '*' --syncmode full --nat extip:$SERVER_IP --mine --miner.threads=1 --miner.etherbase=$MINNER_ADDR &
else
    echo "Nothing...";
fi