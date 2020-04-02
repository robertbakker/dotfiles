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

# Ensure unicode
alias tmux='tmux -u'

# PHP versions

UNAME=$( command -v uname)

case $( "${UNAME}" | tr '[:upper:]' '[:lower:]') in
  linux*)
  alias php-versions='sudo update-alternatives --list php'

  php-switch() {
    sudo update-alternatives --set php /usr/bin/php"$1"
  }

    ;;
  darwin*)
    printf 'darwin\n'
    ;;
  msys*|cygwin*|mingw*)
    # or possible 'bash on windows'
    printf 'windows\n'
    ;;
  nt|win*)
    printf 'windows\n'
    ;;
  *)
    printf 'unknown\n'
    ;;
esac
