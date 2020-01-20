#!/bin/bash

OS="$(uname -s)"
FIRST_RUN=1
# Comment this next line when you are ready to create the appimage
export APPDIR=$(pwd)
CURRENTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}"	)" >/dev/null && pwd	)"
OS="$(uname -s)"
export LD_LIBRARY_PATH=$CURRENTDIR/native-lib:$LD_LIBRARY_PATH

echo ""
echo "------------------------------------------------------------------------"
echo "                      Nebulas Nova - launcher v0.1                      "
echo "------------------------------------------------------------------------"
echo ""
echo "Checking if this is the first run..."
echo ""

if [ -e $HOME/.config/Nebulas/INSTALLED ]
then
	# This app already has its configuration settled.
	FIRST_RUN=0
	echo "If you want to reset your configuration, remove the INSTALLED file"
	echo "located in the $HOME/.config/Nebulas folder."
else
	# We need to config the app first.

	echo "Creating data folders..."
	echo ""
	mkdir -p $HOME/.config/Nebulas/data.db
	mkdir -p $HOME/.config/Nebulas/miner.db
	mkdir -p $HOME/.config/Nebulas/logs
	mkdir -p $HOME/.config/Nebulas/nbre-logs
	mkdir -p $HOME/.config/Nebulas/nbre.db
	mkdir -p $HOME/.config/Nebulas/config
	mkdir -p $HOME/.config/Nebulas/keypath

	cp $APPDIR/opt/Nebulas/config/ed25519key $HOME/.config/Nebulas/keypath/ed25519key
	cp $APPDIR/opt/Nebulas/config/default.conf $HOME/.config/Nebulas/config/default.conf
	cp $APPDIR/opt/Nebulas/config/miner.conf $HOME/.config/Nebulas/config/miner.conf
	cp $APPDIR/opt/Nebulas/config/custom.conf $HOME/.config/Nebulas/config/custom.conf
	cp $APPDIR/opt/Nebulas/config/access.conf $HOME/.config/Nebulas/config/access.conf
	cp $APPDIR/opt/Nebulas/config/dynasty.conf $HOME/.config/Nebulas/config/dynasty.conf
	cp $APPDIR/opt/Nebulas/config/genesis.conf $HOME/.config/Nebulas/config/genesis.conf

	echo "Configuring the app..."
	echo ""
	oldvalue="PRIVATEKEYPATH"
	newvalue=$(printf '%s\n' "$HOME/.config/Nebulas/keypath/ed25519key" | sed 's:[\/&]:\\&:g;$!s/$/\\/')
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/default.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/miner.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/custom.conf

	oldvalue="KEYDIRPATH"
	newvalue=$(printf '%s\n' "$HOME/.config/Nebulas/keypath/" | sed 's:[\/&]:\\&:g;$!s/$/\\/')
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/default.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/miner.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/custom.conf

	oldvalue="DATADBPATH"
	newvalue=$(printf '%s\n' "$HOME/.config/Nebulas/data.db/" | sed 's:[\/&]:\\&:g;$!s/$/\\/')
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/default.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/miner.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/custom.conf

	oldvalue="MINERDBPATH"
	newvalue=$(printf '%s\n' "$HOME/.config/Nebulas/miner.db/" | sed 's:[\/&]:\\&:g;$!s/$/\\/')
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/default.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/miner.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/custom.conf

	oldvalue="GENESISCONFPATH"
	newvalue=$(printf '%s\n' "$HOME/.config/Nebulas/config/genesis.conf" | sed 's:[\/&]:\\&:g;$!s/$/\\/')
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/default.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/miner.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/custom.conf

	oldvalue="DYNASTYCONFPATH"
	newvalue=$(printf '%s\n' "$HOME/.config/Nebulas/config/dynasty.conf" | sed 's:[\/&]:\\&:g;$!s/$/\\/')
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/default.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/miner.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/custom.conf

	oldvalue="ACCESSCONFPATH"
	newvalue=$(printf '%s\n' "$HOME/.config/Nebulas/config/access.conf" | sed 's:[\/&]:\\&:g;$!s/$/\\/')
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/default.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/miner.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/custom.conf

	oldvalue="DEBUGFILEPATH"
	newvalue=$(printf '%s\n' "$HOME/.config/Nebulas/logs/default.txt" | sed 's:[\/&]:\\&:g;$!s/$/\\/')
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/default.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/miner.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/custom.conf

	oldvalue="MINERDEBUGFILEPATH"
	newvalue=$(printf '%s\n' "$HOME/.config/Nebulas/logs/miner.txt" | sed 's:[\/&]:\\&:g;$!s/$/\\/')
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/default.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/miner.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/custom.conf

	oldvalue="NBREROOTPATH"
	newvalue=$(printf '%s\n' "$APPDIR/nbre" | sed 's:[\/&]:\\&:g;$!s/$/\\/')
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/default.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/miner.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/custom.conf

	oldvalue="NBRELOGFILEPATH"
	newvalue=$(printf '%s\n' "$HOME/.config/Nebulas/logs/nbrelob.txt" | sed 's:[\/&]:\\&:g;$!s/$/\\/')
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/default.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/miner.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/custom.conf

	oldvalue="NBREDATAPATH"
	newvalue=$(printf '%s\n' "$HOME/.config/Nebulas/nbre.db/" | sed 's:[\/&]:\\&:g;$!s/$/\\/')
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/default.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/miner.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/custom.conf

	oldvalue="NBREBINARYFILEPATH"
	newvalue=$(printf '%s\n' "$APPDIR/nbre/bin/nbre" | sed 's:[\/&]:\\&:g;$!s/$/\\/')
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/default.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/miner.conf
	sed -i "s/$oldvalue/$newvalue/" $HOME/.config/Nebulas/config/custom.conf

	cp $APPDIR/opt/Nebulas/config/.installed $HOME/.config/Nebulas/INSTALLED

fi

if [ $FIRST_RUN -eq 0 ]
then

	echo "Please, select which script do you want to execute"
	echo ""
	echo "Keep in mind that, at any time, you can abort the process by"
	echo "hitting CTRL and C in your keyboard."
	echo ""
	echo "1. Launch neb with default.conf (predefined)"
	echo "2. Launch neb with miner.conf (predefined)"
	echo "3. Launch neb with custom.conf (custom, you can edit this one)"
	echo "4. Launch neb with custom parameters, using default.conf"
	echo "5. Launch neb with custom parameters, using miner.conf"
	echo "6. Launch neb with custom parameters, using custom.conf"
	echo "7. Debug with strace at option 1"
	echo "8. Debug with ltrace at option 1"
	echo "0. Exit the app"
	echo ""
	echo -n "Your choice: > "
	read text

	echo "Your choice: $text"
	echo ""

	cd $APPDIR/opt/Nebulas

	case $text in
		0) echo "Goodbye!" ;;
		1) echo "Launching Neb with default.conf"
			./neb -c $HOME/.config/Nebulas/config/default.conf ;;
		2) echo "Launching Neb with miner.conf"
			./neb -c $HOME/.config/Nebulas/config/miner.conf ;;
		3) echo "Launching Neb with custom.conf"
			./neb -c $HOME/.config/Nebulas/config/custom.conf ;;
		4) echo -n "Write the parameters you want to pass to neb:"
			read parameters
			echo "Launching Neb with your custom parameters"
			./neb -c $HOME/.config/Nebulas/config/default.conf $parameters ;;
		5) echo -n "Write the parameters you want to pass to neb:"
			read parameters
			echo "Launching Neb with your custom parameters"
			./neb -c $HOME/.config/Nebulas/config/miner.conf $parameters ;;
		6) echo -n "Write the parameters you want to pass to neb:"
			read parameters
			echo "Launching Neb with your custom parameters"
			./neb -c $HOME/.config/Nebulas/config/custom.conf $parameters ;;
		7) echo "Launching Neb with default.conf in debug mode"
			strace -o $APPDIR/tracefiles.txt ./neb -c $HOME/.config/Nebulas/config/default.conf ;;
		8) echo "Launching Neb with default.conf in debug mode"
			ltrace -o $APPDIR/tracelibs.txt ./neb -c $HOME/.config/Nebulas/config/default.conf ;;
		*) echo "Invalid choice!" ;;
	esac

else
	echo "Nebulas Nova is now configured! You can execute this package again to launch Nebulas Nova."
	echo ""
	echo "Remember! You can edit the custom settings by editing this file:"
	echo "$HOME/.config/Nebulas/config/custom.conf"
fi