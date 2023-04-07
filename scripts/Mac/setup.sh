# Import helpers
source "$HOME/dotfiles/scripts/Mac/helpers/style.sh"

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
sudo rm -rf ~/.vim > /dev/null 2>&1
sudo rm -rf ~/.vimrc > /dev/null 2>&1
sudo rm -rf ~/.gitconfig > /dev/null 2>&1
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.p10k.zsh > /dev/null 2>&1
sudo rm -rf ~/Brewfile > /dev/null 2>&1

#==============
# Create symlinks in the home folder
#==============
SYMLINKS=()
ln -sf ~/dotfiles/vim ~/.vim
SYMLINKS+=('.vim')
ln -sf ~/dotfiles/vimrc ~/.vimrc
SYMLINKS+=('.vimrc')
ln -s ~/dotfiles/gitconfig ~/.gitconfig
SYMLINKS+=('.gitconfig')
ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
SYMLINKS+=('.zshrc')
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
# And we are done
#==============
echo -e "\n$(tput bold)====== All Done! ======$(tput sgr0)\n"
echo
echo "Enjoy"
