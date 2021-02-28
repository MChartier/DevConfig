#
# setup-linux.sh
# Set up new Linux environment.
#

# Upgrade system packages
apt update && apt upgrade;

#
# Install 'Oh my Posh'
# https://ohmyposh.dev/docs/installation
#

# Install dependencies
apt install unzip;

# Installation
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh;
chmod +x /usr/local/bin/oh-my-posh;

# Download the themes
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
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