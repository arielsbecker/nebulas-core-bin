#!/bin/bash
CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" >/dev/null && pwd  )"
export LD_LIBRARY_PATH=$CUR_DIR/native-lib:$LD_LIBRARY_PATH

install_rocksdb() {
  $CUR_DIR/install-rocksdb.sh
}

echo ""
echo "------------------------------------------------------------------------"
echo "                      Nebulas Nova - launcher v0.1                      "
echo "                                MAINNET                                 "
echo "------------------------------------------------------------------------"
echo ""

install_rocksdb

echo "Launching neb in mainnet mode..."
./neb -c ./mainnet/conf/config.conf
