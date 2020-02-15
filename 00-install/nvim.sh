# Install Vim Plug for NeoVim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Symlink init.vim to original .vimrc
ln -s ~/.vimrc ~/.config/nvim/init.vim
