#==============
# Install developer tools
#==============

xcode-select --install

#==============
# Install all the packages
#==============
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor
brew update

# So we use all of the packages we are about to install
echo "export PATH='/usr/local/bin:$PATH'\n" >> ~/.bashrc
source ~/.bashrc

#==============
# Remove old dot flies
#==============
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.gitconfig > /dev/null 2>&1
sudo rm -rf ~/.p10k.zsh > /dev/null 2>&1
sudo rm -rf ~/Brewfile > /dev/null 2>&1

#==============
# Create symlinks in the home folder
#==============
SYMLINKS=()
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
SYMLINKS+=('.zshrc')
ln -s ~/dotfiles/gitconfig ~/.gitconfig
SYMLINKS+=('.gitconfig')
ln -s ~/dotfiles/zsh/p10k.zsh ~/.p10k.zsh
SYMLINKS+=('.p10k.zsh')
ln -sf ~/dotfiles/homebrew/Brewfile ~/Brewfile
SYMLINKS+=('Brewfile')

echo ${SYMLINKS[@]}

cd ~
brew bundle
cd -

#==============
# Set zsh as the default shell
#==============
chsh -s /bin/zsh

#==============
# Configure Dock
#==============
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0.2; defaults write com.apple.dock autohide-time-modifier -int 0.2

# add dock spacers
read -p "Dock spacers [3]: " spacers
spacers=${spacers:-3}

for spacer in spacers
do
	defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'
done
# restarting Dock
killall Dock

echo "Dock configured"

#==============
# And we are done
#==============
echo -e "\n====== All Done!! ======\n"
echo
echo "Enjoy"
