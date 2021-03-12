# Symfony Console
symfony_console() {
  if docker-compose exec php true;then
    echo "Running inside Docker Compose PHP service"
    docker-compose exec php php bin/console -vv --no-debug $@
  else
    echo "Running locally"
    command php bin/console -vv --no-debug $@
  fi
}
alias c=symfony_console

# Composer
php_composer() {
  if docker-compose run --rm composer true;then
    echo "Running through Docker Compose: composer service"
    docker-compose run --rm composer $@
  elif docker-compose exec php true;then
    echo "Running through Docker Compose: php service"
    docker-compose exec php composer $@
  else
    echo "Running locally"
    command composer $@
  fi
}
alias composer=php_composer

# Run Psalm
psalm_run() {
  if docker-compose exec php true;then
    echo "Running inside Docker Compose PHP service"
    docker-compose exec php php ./vendor/bin/psalm $@
  else
    echo "Running locally"
    command php ./vendor/bin/psalm $@
  fi
}
alias psalm=psalm_run

# Laravel Artisan
alias a="php artisan"

# Use NeoVim if it exists instead of Vim
if type nvim > /dev/null 2>&1; then
  alias vim="nvim"
fi

# Highlighted cat
alias ccat='pygmentize -g -O style=colorful,linenos=1'

alias tree='tree -I "node_modules|vendor|var"'

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
#    printf 'darwin\n'
    ;;
  msys*|cygwin*|mingw*)
    # or possible 'bash on windows'
#    printf 'windows\n'
    ;;
  nt|win*)
#    printf 'windows\n'
    ;;
  *)
#    printf 'unknown\n'
    ;;
esac
