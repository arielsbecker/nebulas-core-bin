# nebulas-core-bin

## Instructions

To run a node, you can choose from either a default or a custom config file.

To run a default node (with default parameters), open a terminal and type

`./default.sh`

To run a custom node (with a custom config file), open a terminal and type

`./custom.sh PATH_TO_YOUR_CONFIG_FILE/CONFIG_FILE.conf`

replacing the parameter with the path and filename of your config file.

If you do not have rocksdb installed, the script will install it for you. Keep in mind that this process can take up to several minutes, so be patient. Also, be sure you are running rocksdb version 5.18.3.
