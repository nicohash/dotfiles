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
# Configure Dock
#==============
echo "$(tput bold)Configuring Dock$(tput sgr0)"

defaults write com.apple.dock autohide -bool true
echo "Autohide active"
defaults write com.apple.dock autohide-delay -float 0.2
echo "Autohide delay: 0.2 seconds"
defaults write com.apple.dock autohide-time-modifier -float 0.2
echo "Autohide time modifier: 0.2 seconds"
defaults write com.apple.dock mineffect -string "scale"
echo "Minimize effect: scale"
defaults write com.apple.dock show-recents -bool false
echo "Recent applications hidden"

read -p "Dock spacers (press $(tput bold)ENTER$(tput sgr0) to skip): " spacers
spacers=${spacers:-0}

if [[ $spacers =~ ^[0-9]+$ ]]; then
        addedSpacers=0

        while [[ $spacers > 0 ]]
        do
                defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'
                ((spacers--))
                ((addedSpacers++))        
        done

        echo "Spacers added: $addedSpacers"
else
        echo "Input not allowed"
        echo "Add small spacers manually: defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}' && killall Dock"
fi


# restarting Dock
killall Dock

echo "$(tput bold)Dock configured$(tput sgr0)"

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
