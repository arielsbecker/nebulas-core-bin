#!/bin/bash
CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" >/dev/null && pwd  )"
export LD_LIBRARY_PATH=$CUR_DIR/native-lib:$LD_LIBRARY_PATH

install_rocksdb() {
  $CUR_DIR/install-rocksdb.sh
}

echo ""
echo "------------------------------------------------------------------------"
echo "                      Nebulas Nova - launcher v0.1                      "
echo "                                TESTNET                                 "
echo "------------------------------------------------------------------------"
echo ""

install_rocksdb

echo "Launching neb in testnet mode..."
./neb -c ./testnet/conf/config.conf
