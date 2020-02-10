#!/bin/bash
CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" >/dev/null && pwd  )"
export LD_LIBRARY_PATH=$CUR_DIR/native-lib:$LD_LIBRARY_PATH

install_rocksdb() {
  $CUR_DIR/install-rocksdb.sh
}

echo ""
echo "------------------------------------------------------------------------"
echo "                      Nebulas Nova - launcher v0.1                      "
echo "                                 MINING                                 "
echo "------------------------------------------------------------------------"
echo ""

install_rocksdb

echo "Launching neb in mining mode..."
echo "Please, keep in mind that this config file is for demonstration purposes only."
echo "You'll need to run a node first in order for it to work properly, as it is explained"
echo "here: https://wiki.nebulas.io/en/latest/go-nebulas/tutorials/01-installation.html"
echo ""
echo "Learn more at https://wiki.nebulas.io/en/latest/go-nebulas/config.html"
./neb -c ./conf/example/miner.conf
