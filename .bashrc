########
#
# MyBash .bashrc file
#
# written by Marcus Grant (2016) of thepatternbuffer.com
#
########

########
#
# Table of Contents
# 1. Prompt Configuration
# 2. Environmental Variables & Paths
# 3. Helper Functions
# 4. Aliases
# 5. Final Configurations & Plugins
#
########

########
#
# 1. Prompt Configuration
#
########

# get absolute path to bash dotfiles root
# foolproof way to figure out where this script is placed
# TMP_SRC="${BASH_SOURCE[0]}"
# while [ -h "$TMP_SRC" ]; do # resolve $TMP_SRC until the file is no longer a symlink
#   TMP_ROOT_DIR="$( cd -P "$( dirname "$TMP_SRC" )" && pwd )"
#   TMP_SRC="$(readlink "$TMP_SRC")"
#   # if $TMP_SRC was a relative symlink, we need to resolve it relative
#   # to the path where the symlink file was located
#   [[ $TMP_SRC != /* ]] && TMP_SRC="$TMP_ROOT_DIR/$TMP_SRC"
# done
# TMP_ROOT_DIR="$( cd -P "$( dirname "$TMP_SRC" )" && pwd )"
# BASH_DOTS_ROOT="$TMp_DOTS_ROOT"
# echo "BASH DOT ROOT: $BASH_DOTS_ROOT"
# TODO: make sure this works with my setup
# BASH_DOTS_ROOT=$(pwd -P "$HOME/.bash_profile")
BASH_DOTS_ROOT=$(dirname "$(readlink ~/.bash_profile)")
# echo "BASH_DOTS_ROOT: $BASH_DOTS_ROOT"


# get absolute path to prompt link
source "$BASH_DOTS_ROOT/prompt-link"
# source-prompt-link(){
#   # foolproof way to figure out where this script is placed
#   local source="${BASH_SOURCE[0]}"
#   while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
#     local dir="$( cd -P "$( dirname "$source" )" && pwd )"
#     local source="$(readlink "$source")"
#     # if $source was a relative symlink, we need to resolve it relative
#     # to the path where the symlink file was located
#     [[ $source != /* ]] && local source="$dir/$source"
#   done
#   local dir="$( cd -P "$( dirname "$source" )" && pwd )" #dir now has the script locat'n
#   source "$dir/prompt-link"
# }
# source-prompt-link


########
#
# 2. Environmental Variables & Paths
#
########

# Terminal environment: Termite invokes its own, use xterm-256color instead
export TERM=xterm-256color

# Editors
# Here you define default editors to be used by the OS whenever you ask to open a file
# The -w flag tells your shell to wait until sublime exits
export VISUAL="gedit"
#export SVN_EDITOR="subl -w"
export GIT_EDITOR="vim"
export EDITOR="vim"

# Switch to determine what type of OS this is running on, 'machine' stores the string
  # eval keychain to update ssh-agent with private keys
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     
        machine=linux
        if [ -f $HOME/.ssh/git.key ]; then
            eval $(keychain --eval --quiet $HOME/.ssh/git.key )
        else
            echo "Attempted to add git keychain, but no keyfile exists, ignoring..."
        fi
    ;;
    Darwin*)    machine=mac;;
    CYGWIN*)    machine=cygwin;;
    MINGW*)     machine=minGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
# Paths

    # The USR_PATHS variable will just store all relevant /usr paths for easier usage
    # Each path is seperate via a : and we always use absolute paths.

    # TODO: This needs to be checked for compatibility with linux, this came originally from my macOS bash
    # A bit about the /usr directory
    # The /usr directory is a convention from linux that creates a common place to put
    # files and executables that the entire system needs access too. It tries to be user
    # independent, so whichever user is logged in should have permissions to the /usr directory.
    # We call that /usr/local. Within /usr/local, there is a bin directory for actually
    # storing the binaries (programs) that our system would want.
    # Also, Homebrew adopts this convetion so things installed via Homebrew
    # get symlinked into /usr/local
    #export USR_PATHS="/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin"

    # Hint: You can interpolate a variable into a string by using the $VARIABLE notation as below.

    # We build our final PATH by combining the variables defined above
    # along with any previous values in the PATH variable.

    # Our PATH variable is special and very important. Whenever we type a command into our shell,
    # it will try to find that command within a directory that is defined in our PATH.
    # Read http://blog.seldomatt.com/blog/2012/10/08/bash-and-the-one-true-path/ for more on that.
    #export PATH="$USR_PATHS:$PATH"

    # If you go into your shell and type: echo $PATH you will see the output of your current path.
    # For example, mine is:
    # /Users/avi/.rvm/gems/ruby-1.9.3-p392/bin:/Users/avi/.rvm/gems/ruby-1.9.3-p392@global/bin:/Users/avi/.rvm/rubies/ruby-1.9.3-p392/bin:/Users/avi/.rvm/bin:/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/local/mysql/bin:/usr/local/share/python:/bin:/usr/sbin:/sbin:
   # home bin path
   #TODO: Remove these entries if keeping them in profile is satisfactory
   #export PATH="$HOME/bin:$PATH"

   #TODO: Validate this for functionality and remove if needed
   # add Soundcloud2000 variable for API Key

    # Anaconda (change for OS)
    # TODO: Moving to profile, remove if satisfactory
    #export PATH="$HOME/.local/share/anaconda3/bin:$PATH"



    # Add $HOME/.dotfiles/sysadmin-scripts to PATH for helper scripts
    # Only do it if that directory is present
    if [ -d $HOME/.dotfiles/sysadmin-scripts ]; then
        PATH=$PATH:$HOME/.dotfiles/sysadmin-scripts
    fi



########
#
# 3. Helper Functions
#
########

source "$BASH_DOTS_ROOT/functions.sh" $machine

########
#
# 4. Alias Sourcing
#
########

source "$BASH_DOTS_ROOT/aliases.sh" $machine

########
#
# 5. Final Configurations & Plugins
#
########
  # Git Bash Completion
  # Will activate bash git completion if installed
  # via homebrew on macOS, or whatever linux package manager you use
  # NEEDS UPDATING TO WORK ON BOTH macOS & various Linux carnations
  #if [ -f `brew --prefix`/etc/bash_completion ]; then
  #  . `brew --prefix`/etc/bash_completion
  #fi

  # RVM - NEEDS AUDITING
  # Mandatory loading of RVM into the shell
  # This must be the last line of your bash_profile always
  #[[ -s "/Users/$USER/.rvm/scripts/rvm" ]] && source "/Users/$USER/.rvm/scripts/rvm"  # This loads RVM into a shell session.

  # Setup paths for virtualenv
  if [ -d $HOME/.virtualenvs ]; then
	  export WORKON_HOME=$HOME/.virtualenvs
	  source /usr/local/bin/virtualenvwrapper.sh
	  export PIP_VIRTUALENV_BASE=$WORKON_HOME
  fi

