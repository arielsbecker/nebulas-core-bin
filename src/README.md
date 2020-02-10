# nebulas-core-bin

## Instructions

To run a node, you can choose from either a custom config file or the preinstalled ones, provided in this package.

If you do not have rocksdb installed, the script will install it for you. Keep in mind that this process can take up to several minutes, so be patient. Also, be sure you are running rocksdb version 5.18.3.

### Custom nodes
To run a custom node (with a [custom config file](https://wiki.nebulas.io/en/latest/go-nebulas/config.html)), open a terminal and type

`./custom.sh PATH_TO_YOUR_CONFIG_FILE/CONFIG_FILE.conf`

replacing the parameter with the path and filename of your config file.

### Preinstalled nodes

There are three configurations available:

* **testnet**: This script will connect to the testnet. You only need to run this in a terminal: `./testnet.sh`
* **mainnet**: This script will connect to the mainnet. You only need to run this in a terminal: `./mainnet.sh`
* **miner**: This script will launch a miner node. You need to run this in a terminal: `./miner.sh`, but before you need to run either a custom, testnet or mainnet node. Please, refer to [this guide](https://wiki.nebulas.io/en/latest/go-nebulas/tutorials/01-installation.html) before running it, or it will not run properly.

