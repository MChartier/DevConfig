#!/bin/bash

#
# setup-linux.sh
# Set up new Linux environment.
#

readonly DOTNET_SDK_VERSIONS=(3.1 5.0)

if (( EUID != 0 )); then
    echo "This script must be run as root." 1>&2
    exit 1
fi

# Upgrade system packages
apt update && apt upgrade

# Install common tools
apt install make

#
# Install 'Oh my Posh'
# https://ohmyposh.dev/docs/installation
#

# Install dependencies
apt install unzip

# Installation
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
chmod +x /usr/local/bin/oh-my-posh

# Download the themes
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip -o ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.json
rm ~/.poshthemes/themes.zip

# Update bash.rc and reload
echo 'eval "$(oh-my-posh --init --shell bash --config ~/.poshthemes/powerline.omp.json)"' >> ~/.bashrc
. ~/.bashrc

#
# Install emacs
#
add-apt-repository ppa:kelleyk/emacs -y
apt update
apt install emacs -y
cp ./emacs/.emacs ~/.emacs

#
# Configure git
#
cp ./git/.gitconfig ~/.gitconfig

#
# Install dotnet SDKs
#
wget https://packages.microsoft.com/config/ubuntu/20.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb && apt update
rm ./packages-microsoft-prod.deb
apt install -y apt-transport-https && apt update
for v in ${DOTNET_SDK_VERSIONS[@]}; do
    apt install -y dotnet-sdk-$v
done

#
# Install NVM and latest LTS Node.js SDK
# https://github.com/nvm-sh/nvm#install--update-script
#

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
export NVM_DIR="$HOME/.nvm"

# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  

# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

nvm install --lts