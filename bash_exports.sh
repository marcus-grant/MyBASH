########
#
# MyBash profile file
#
# Primarily used to setup environment variables
#
# written by Marcus Grant (2016) of thepatternbuffer.com
#
########

# Determine Host OS type & export to 'MACHINE'
# NOTE: this needs to happen first because various other variables &
# configs depend on what the host system is
machine=""
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     
        machine=linux
    ;;
    Darwin*)    machine=mac;;
    CYGWIN*)    machine=cygwin;;
    MINGW*)     machine=minGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
export MACHINE="$machine"

# Termite & iTerm with Tmux work best with xterm-256color
export TERM=xterm-256color

# Editor vars
export VISUAL="gedit"
# determine if nvim is installed and use instead of vim if so
if hash nvim 2>/dev/null; then
  export GIT_EDITOR="nvim"
  export EDITOR="nvim"
else
  export GIT_EDITOR="vim"
  export EDITOR="vim"
fi

# PATHs
# TODO !!!!!! Be sure to migrate the .bashrc ones over to here instead

# Home bin for my custom apps and scripts
export PATH="$HOME/bin:$PATH"
# Rust's cargo package manager needs for there to be some kind of standard path
export PATH="$HOME/.cargo/bin:$PATH"
# Go's GOPATH
export PATH="$PATH:$HOME/bin/go/bin"
# Get and include anaconda's path based on "MACHINE" var
if [ $MACHINE == "mac" ]; then
  export PATH="$HOME/.anaconda3/bin:$PATH"
else
  export PATH="$HOME/.local/share/anaconda3/bin:$PATH"
fi
# Setup paths for virtualenv
if [ -d $HOME/.virtualenvs ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
fi


# TODO: Add an alternative profile for when intended to be installed on remote server, git ssh keys shouldn't be stored there, use HTTPS instead
# TODO: OR consider a better private key passwording method
# if a linux system, add all keychains in if statement below with paths
if [ $MACHINE == "linux" ]; then
  if [ -f $HOME/.ssh/git.key ]; then
      eval $(keychain --eval --quiet $HOME/.ssh/git.key )
  else
      echo "Attempted to add git keychain, but no keyfile exists, ignoring..."
  fi
fi

# set xdg's
# TODO: find better way to standardize this across systems particularly on arch
#export XDG_CONFIG_HOME="${XDG_CONFIG_HOME}:$HOME/.config"
