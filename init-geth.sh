#!/bin/bash

DATA_DIR=./data
MAINNET=true

wget https://storage.googleapis.com/golang/go1.19.linux-amd64.tar.gz
tar -xvf go1.19.linux-amd64.tar.gz
sudo rm -fr /usr/local/go
sudo mv go /usr/local
export GOROOT=/usr/local/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

cd ~
git clone https://github.com/maxxchain/go-ethereum
cd go-ethereum/
sudo apt-get update && sudo apt-get dist-upgrade -y
sudo apt-get install build-essential make git screen unzip curl nginx pkg-config nmap xterm screen tcl -y
make geth

git clone https://github.com/maxxchain/genesis-block
mkdir $DATA_DIR

if $MAINNET
then
    ./build/bin/geth --datadir $DATA_DIR init ./genesis-block/testnet.json
else 
    ./build/bin/geth --datadir $DATA_DIR init ./genesis-block/mainnet.json
fi
