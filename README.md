# Nebulas Core Binary Packages

This repository contains a tarball containing the pre-compiled neb binary, along with the scripts needed to run your node, and a copy of the web wallet.

Also, there's a magnet link to download a .ova (virtual machine appliance), in case you want to run it _sandboxed_ or in other environments such as Windows, and a new tarball containing [just the precompiled neb binary](dist/neb.tar.gz).

## Tarball

### Installation

Download the tarball directly from [here](dist/nova.tar.gz). Untar it.

Run `setup.sh`; it's a semi-automated process that will download and install all the required libraries and packages. You only need to provide your administrative password.

Keep in mind that this process can take several minutes to complete, and it's likely that it will ask for your sudo password more than once.

### Running the node

Once this process ends, you need to run `run.sh`; the first time you run it, it will copy several files to your user folders, then it will show a menu with different options. Choose the option that best fits your needs.

## OVA - Virtual Machine Appliance

This option is intended for Windows users, or users of any non-linux platform.

You will need a torrent app that supports magnet links.

Open this link:

`magnet:?xt=urn:btih:cf5a451923b9620a001866edff4bacfb55a69956&dn=NebulasNova.ova&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Ftracker.publicbt.com%3A80&tr=udp%3A%2F%2Ftracker.ccc.de%3A80`

and wait for it to download. Once you have the file, open it with your Virtual Machine app. It's strongly suggested to use VirtualBox, as it is cross-platform and 100% compatible with this appliance.

Once the virtual machine is running, follow the instructions on the README file that is located on the desktop.

The administrative password for this machine is `1234`.