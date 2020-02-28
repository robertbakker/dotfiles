SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Install Vim Plug for NeoVim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -s ${SCRIPTPATH}/../.vimrc ~/.vimrc

# Symlink init.vim to original .vimrc
ln -s ~/.vimrc ~/.config/nvim/init.vim
