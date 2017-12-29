#!/bin/sh

forever start -c "npm start" --workingDir="/explorer" .

geth --mine --minerthreads=1 --networkid=1999 --rpc --rpcapi="db,eth,net,personal,web3,admin" --rpccorsdomain="*" --rpcaddr="0.0.0.0"
