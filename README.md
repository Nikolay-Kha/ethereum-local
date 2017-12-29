# Simple private Ethereum docker image
This is a simple private Ethereum node running in Docker image. It's totally
unsecure, but simple for development and tests.

Running:
```bash
docker build .
docker run -p 8545:8545 -p 8000:8000 -d <image id from docker build>
```

Stopping:
```bash
docker stop <container id from docker run>
```

# Services in image
- http://127.0.0.1:8545 - Ethereum rpcapi.
- http://127.0.0.1:8000 - Simple web interface for Ethereum network. Ethereum
Block Explorer - https://github.com/Capgemini-AIE/ethereum-docker

# Attaching Ethereum Wallet(or Mist)
```bash
/Applications/Ethereum\ Wallet.app/Contents/MacOS/Ethereum\ Wallet --rpc http://127.0.0.1:8545
/Applications/Mist.app/Contents/MacOS/Mist --rpc http://127.0.0.1:8545
```

# Links to solidity editor
https://remix.ethereum.org  
https://ethereum.github.io/browser-solidity/

# Simple script
```bash
npm install web3@0.19.0
```
Script connects to rpc api, prints balance, writes and reads from contract.
```node
var Web3 = require('web3');
var web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:8545"));

var abi = [ { "constant": true, "inputs": [], "name": "getValue", "outputs": [ { "name": "", "type": "int256", "value": "1" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "newValue", "type": "int256" } ], "name": "setValue", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "value", "type": "int256" } ], "name": "subValue", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "value", "type": "int256" } ], "name": "addValue", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" } ];

var coinbase = web3.eth.coinbase;
var balance = web3.eth.getBalance(coinbase);
console.log(balance)

var MyContract = web3.eth.contract(abi);
var myContractInstance = MyContract.at("0x95345baC7b280c406CC5D83a71a77014689718ED");
web3.personal.unlockAccount(web3.eth.accounts[0], "password", 500);
myContractInstance.addValue(10000000000, {from: web3.eth.accounts[0], gas:3000000});
var result = myContractInstance.getValue();
console.log(result);
```
