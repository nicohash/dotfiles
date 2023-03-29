log_file=~/install_progress_log.txt

sudo apt-get -y install zsh
if type -p zsh > /dev/null; then
    echo "zsh Installed" >> $log_file
else
    echo "zsh FAILED TO INSTALL!!!" >> $log_file
fi

sudo apt-get install zsh-syntax-highlighting

sudo apt-get install zsh-autosuggestions

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
# not sure if this is necessary:
# echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

#==============
# Give the user a summary of what has been installed
#==============
echo -e "\n====== Summary ======\n"
cat $log_file
echo
echo "Enjoy"
rm $log_file
