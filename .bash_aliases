# Symfony Console
alias c="php bin/console"

# Laravel Artisan
alias a="php artisan"

# Use NeoVim if it exists instead of Vim
if type nvim > /dev/null 2>&1; then
  alias vim="nvim"
fi

# Highlighted cat
alias ccat='pygmentize -g -O style=colorful,linenos=1'

alias tree='tree -I "node_modules|vendor"'

# Because ll is not a default on Ubuntu
alias ll='ls -l'
