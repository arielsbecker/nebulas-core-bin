#!/bin/bash
CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" >/dev/null && pwd  )"
export LD_LIBRARY_PATH=$CUR_DIR/native-lib:$LD_LIBRARY_PATH

install_rocksdb() {
  $CUR_DIR/install-rocksdb.sh
}

echo ""
echo "------------------------------------------------------------------------"
echo "                      Nebulas Nova - launcher v0.1                      "
echo "------------------------------------------------------------------------"
echo ""

install_rocksdb

echo "Launching neb with default.conf"
./neb
