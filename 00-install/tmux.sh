SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

ln -s ${SCRIPTPATH}/../.tmux.conf ~/.tmux.conf

