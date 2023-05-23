#!/bin/zsh
#===============================================================================
#
#             NOTES: For this to work you must have cloned the github
#                    repo to your home folder as ~/dotfiles/
#
#===============================================================================

#==============
# Import helpers
#==============
source "$HOME/dotfiles/scripts/helpers/style.sh"

#==============
# Variables
#==============
dotfiles_dir=~/dotfiles
log_file=~/install_progress_log.txt

#==============
# Install Packages
#==============
sudo apt-get -y install zsh
if type -p zsh > /dev/null; then                                                                                                                                                          
    echo "$(bold "zsh") installed" >> $log_file
else
    echo "$(bold "zsh") FAILED to install!" >> $log_file
fi

sudo apt-get install zsh-syntax-highlighting
sudo apt-get install zsh-autosuggestions

sudo apt-get -y install vim
if type -p vim > /dev/null; then
    echo "$(bold "Vim") installed" >> $log_file
else
    echo "$(bold "Vim") FAILED to install!" >> $log_file
fi

#==============
# Delete existing dot files and folders
#==============
sudo rm -rf ~/.vim> /dev/null 2>&1
sudo rm -rf ~/.vimrc> /dev/null 2>&1
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.p10k.zsh > /dev/null 2>&1
sudo rm -rf ~/.gitconfig > /dev/null 2>&1

#==============
# Create symlinks in the home folder
#==============
ln -s $dotfiles_dir/vim ~/.vim
ln -s $dotfiles_dir/vim/vimrc ~/.vimrc
ln -sf $dotfiles_dir/zsh/zshrc ~/.zshrc
ln -sf $dotfiles_dir/zsh/p10k.zsh ~/.p10k.zsh
ln -sf $dotfiles_dir/gitconfig ~/.gitconfig

#==============
# Set zsh as the default shell
#==============
sudo chsh -s /bin/zsh

#==============
# Give the user a summary of what has been installed
#==============
echo -e "\n$(bold "====== Summary ======")\n"
cat $log_file
echo
echo "Enjoy"
rm $log_file
