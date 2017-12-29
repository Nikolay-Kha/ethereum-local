#!/bin/sh

PASSWORD="password"

ACCOUNT=$(geth account new --password <(echo $PASSWORD) | sed 's/Address: {\(.*\)}/\1/')

echo '{"config": {"chainId": 15,"homesteadBlock": 0,"eip155Block": 0,"eip158Block": 0},"difficulty": "0x400","gasLimit": "0x2500000","alloc": {"'$ACCOUNT'":{ "balance": "0x3333000000000000000000" }}}' > /genesis.json

geth init /genesis.json
