#!/bin/bash
clear
echo "Installing Termux Stylish Banner Tool by Arham Farooque..."
pkg update -y
pkg install -y git bash figlet toilet ruby
gem install lolcat --no-document || true
cd $HOME
git clone https://github.com/arhamfarooque/termux-banner-tool.git
cd termux-banner-tool
chmod +x termux-banner.sh
./termux-banner.sh --install
