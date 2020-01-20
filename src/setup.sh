#!/bin/bash

echo ""
echo "===================[ Nebulas Nova autoinstaller v0.1 ]=================="
echo ""
echo "Initializing the setup. Please wait..."
echo ""

SOURCE_URL="http://develop-center.oss-cn-zhangjiakou.aliyuncs.com"
CURRENTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
#CURRENTDIR=$(pwd)
OS="$(uname -s)"

rm -rf "$CURRENTDIR/native-lib"
mkdir -p "$CURRENTDIR/native-lib"

install_rocksdb() {
	echo ""
	echo "-----------------------------[ Installing rocksdb ]-----------------------------"
	echo ""
	echo "ATTENTION: THIS PROCESS CAN TAKE UP SEVERAL MINUTES TO COMPLETE."
	echo "Also, it will require to enter your administrative password to install the required libraries."
	echo ""
	read -rsp $'Press any key to continue...\n' -n1 key
	if [ "$OS" = "Darwin" ]; then
		if ! hash brew 2>/dev/null; then
			/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		fi
	fi

	if ! hash git 2>/dev/null; then
		case $OS in
			'Linux')
				sudo apt-get update
				sudo apt install -y git
				;;
			'Darwin')
				brew install git
				;;
			*) ;;
		esac
	fi

	case $OS in
		'Linux')
			sudo apt-get install -y libsnappy-dev
			sudo apt-get install -y zlib1g-dev
			sudo apt-get install -y libbz2-dev
			sudo apt-get install -y liblz4-dev
			sudo apt-get install -y libzstd-dev

			rm -rf rocksdb
			git clone https://github.com/facebook/rocksdb.git rocksdb

			cd rocksdb
				git checkout v5.17.2
				sudo make install-shared
			cd ..
			sudo ldconfig
			sudo rm -rf rocksdb
			;;
		'Darwin')
			xcode-select --install 2>/dev/null
			brew install rocksdb
			;;
		*) ;;
	esac

	echo ""
	echo "Done."
	echo "******************************************************************************"
}

install_nvm() {
	nvm_lib="$CURRENTDIR/nf/nvm/native-lib"
	if [ ! -d "$nvm_lib" ]; then
		echo ""
		echo "------------------------------[ Installing NVM ]------------------------------"
		echo ""
		mkdir -p "$nvm_lib"
		pushd "$nvm_lib"
		wget $SOURCE_URL/setup/nvm/lib_nvm_$OS.tar.gz -O lib_nvm_$OS.tar.gz
		tar -zxf lib_nvm_$OS.tar.gz
		echo ""
		echo "Installing nvm libs..."
		cp -R lib_nvm_$OS/* "$nvm_lib/"
		rm -rf lib_nvm_$OS
		rm -rf lib_nvm_$OS.tar.gz
		popd

	fi
	libs=`ls "$nvm_lib" |grep .$DYLIB`
	for lib in $libs; do
		ln -s "$nvm_lib/$lib"	"$CURRENTDIR/native-lib/$lib"
	done
	echo ""
	echo "Done."
	echo "******************************************************************************"
}

export_libs() {
	echo ""
	echo "------------------------------[ Exporting libs ]------------------------------"
	echo ""
	case $OS in
		'Linux')
			export LD_LIBRARY_PATH="$CURRENTDIR/native-lib":$LD_LIBRARY_PATH
			;;
		'Darwin')
			if [ ! -d ~/lib ]; then
				ln -s "$CURRENTDIR/native-lib" ~/lib
			fi
			;;
		*) ;;
	esac
	echo ""
	echo "Done."
	echo "******************************************************************************"
}

install_web_wallet() {
	echo ""
	echo "--------------------------[ Installing html wallet ]--------------------------"
	echo ""
	if [ ! -d "$CURRENTDIR/HTMLWallet" ]; then
		pushd "$CURRENTDIR"
		unzip HTMLWallet.zip
		rm -rf HTMLWallet.zip
		popd
	fi
	echo ""
	echo "Done."
	echo "******************************************************************************"
}

	case "$CURRENTDIR" in
		*\ * )
			echo ""
			echo "===================[ Nebulas Nova autoinstaller v0.1 ]=================="
			echo ""
			echo "Setup has determined that your current path contains spaces. This will"
			echo "break the rocksdb installation script. As it is a third party install,"
			echo "there is nothing this setup can do."
			echo ""
			echo "Please, move this folder to a path without spaces, then try again."
			;;
		*)
			if [ "$OS" = "Linux" ]; then
				hasrocks=`ldconfig -p | grep -c rocksdb`
				hasrightrocks=`ldconfig -p | grep -c librocksdb.so.5.17`
			else
				hasrocks=`brew list | grep -c rocksdb`
				hasrightrocks=`brew list | grep -c librocksdb.so.5.17`
			fi

			if [ "$hasrightrocks" -eq 0 ]; then
				if [ "$hasrocks" -eq 0 ]; then
					install_rocksdb
					rocksdb=1
				else
					rocksdb=0
				fi
			else
				rocksdb=1
			fi

			if [ "$rocksdb" -eq 1 ]; then

				install_nvm
				export_libs
				install_web_wallet

				echo ""
				echo "===================[ Nebulas Nova autoinstaller v0.1 ]=================="
				echo ""
				echo "Setup is now complete. You can start your node by typing:"
				echo ""
				echo "./run.sh"
				echo ""
				echo "in the console."
			else
				echo ""
				echo "===================[ Nebulas Nova autoinstaller v0.1 ]=================="
				echo ""
				echo "Setup has determined you have rocksdb, but not version 5.17, required to"
				echo "run this program."
				echo ""
				echo "You can remove the current version of rocksdb and run this script again."
			fi
			;;
	esac
