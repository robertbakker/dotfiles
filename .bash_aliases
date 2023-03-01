hh_ssh_keygen() {
  if [ -z $1 ]; then
    echo "Must give a name (alphanumeric, lowercase and dashes/underscores allowed) for first argument"
    return 1
  fi

  if [[ "$1" =~ [^-_a-z0-9] ]]; then
    echo "Name argument is not only alphanumeric, lowercase or dashes/underscores"
    return 1
  fi

  name=happyhorizon_$1

  FILE=~/.ssh/$name

  if test -f "$FILE"; then
    echo "A prefix key with name $name already exists. ($FILE)"
    return 1
  fi

  echo "ssh-keygen -C \"robertbakker@happyhorizon.com\" -t ed25519-sk -f $FILE"
  ssh-keygen -C "robertbakker@happyhorizon.com"  -t ed25519-sk -f $FILE
}

is_docker_compose() {
  if docker-compose ps -q >/dev/null 2>&1
  then
      return 0
  else
      return 1
  fi
}

has_docker_compose_service() {
  services=$(docker-compose ps --services)
  if printf "$services" | grep -Fxq "$1"
  then
    return 0
  else
    return 1
  fi
}

php_command() {
  if has_docker_compose_service "php"
  then
    echo "Found a 'php' service defined in Docker Compose environment (docker-compose.yml), running..."
    docker-compose exec php php $@
  else
    command php $@
  fi
}
alias php=php_command

composer_command() {
  if has_docker_compose_service "composer"
  then
    echo "Found a 'composer' service defined in Docker Compose environment (docker-compose.yml), running..."
    docker-compose run --rm composer $@
  elif has_docker_compose_service "php" && docker-compose exec php which composer
  then
    echo "Found a 'composer' command inside 'php' service defined in Docker Compose environment (docker-compose.yml), running..."
    docker-compose exec php composer $@
  else
    command composer $@
  fi
}
alias composer=composer_command

# Node
node_command() {
  if has_docker_compose_service "node"
  then
    echo "Found a 'node' service defined in Docker Compose environment (docker-compose.yml), running..."
    docker-compose exec node $@
  else
    command node $@
  fi
}
alias node=node_command

# Yarn
yarn_command() {
  if has_docker_compose_service "node" && docker-compose exec node which yarn 
  then
    echo "Found a 'yarn' command inside a 'node' service defined in Docker Compose environment (docker-compose.yml), running..."
    docker-compose exec node yarn $@
  else
    command yarn $@
  fi
}
alias yarn=yarn_command

# Symfony Console
symfony_console() {
  if has_docker_compose_service "php" && docker-compose exec php test -f "bin/console" 
  then
    echo "Found a 'bin/console' inside 'php' service defined in Docker Compose environment (docker-compose.yml), running..."
    docker-compose exec php php bin/console -vv --no-debug $@
  else
    command php bin/console -vv --no-debug $@
  fi
}
alias c=symfony_console

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

function pip-install-save {
    pip3 install --force-reinstall $1 && pip3 freeze | grep $1 >> requirements.txt
}

