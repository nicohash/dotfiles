# Import helpers
source "$HOME/dotfiles/scripts/helpers/style.sh"

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
ln -sf ~/dotfiles/vim/vimrc ~/.vimrc
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
# Set zsh as the default shell (for pre MacOS Catalina when bash was default)
#==============
chsh -s /bin/zsh


#==============
# Ask to configure Dock 
#==============
while true; do
    read -p "Do you wish to configure the Dock? (y/n) " yn
    case $yn in
        [Yy]* ) source "$HOME/dotfiles/scripts/Mac/dock/configure-dock.sh"; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

#==============
# Ask to configure Touchbar 
#==============
while true; do
    read -p "Do you wish to configure the Touchbar? (y/n) " yn
    case $yn in
        [Yy]* ) source "$HOME/dotfiles/scripts/Mac/touchbar/configure-touchbar.sh"; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

#==============
# And we are done
#==============
echo -e "\n${bold}====== All Done! ======${normal}\n"
echo "Enjoy"
