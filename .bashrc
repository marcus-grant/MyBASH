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

  # if you install git via homebrew, or install the bash autocompletion via -
  # - homebrew, you get __git_ps1 which you can use in the PS1 to display the -
  # - git branch.  it's supposedly a bit faster and cleaner than manually -
  # - parsing through sed. i dont' know if you care enough to change it

  # This function is called in your prompt to output your active git branch.
  function parse_git_branch {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
  }

  # This function builds your prompt. It is called below
  function prompt {
    # Define some local colors
    # local   RED="\[\033[0;31m\]" # This syntax is some weird bash color stuff
    local COLOR_NC='\e[0m' # No Color
    local COLOR_WHITE='\e[1;37m' # Some color codes that make absolutely
    local COLOR_BLACK='\e[0;30m' # no sense to me, they're just googled snippets
    local COLOR_BLUE='\e[0;34m'
    local COLOR_LIGHT_BLUE='\e[1;34m'
    local COLOR_GREEN='\e[0;32m'
    local COLOR_LIGHT_GREEN='\e[1;32m'
    local COLOR_CYAN='\e[0;36m'
    local COLOR_LIGHT_CYAN='\e[1;36m'
    local COLOR_RED='\e[0;31m'
    local COLOR_LIGHT_RED='\e[1;31m'
    local COLOR_PURPLE='\e[0;35m'
    local COLOR_LIGHT_PURPLE='\e[1;35m'
    local COLOR_BROWN='\e[0;33m'
    local COLOR_YELLOW='\e[0;33m'
    local COLOR_LIGHT_YELLOW='\e[1;33m'
    local COLOR_GRAY='\e[0;30m'
    local COLOR_LIGHT_GRAY='\e[0;37m'
    local CHAR_HEART="♥"
    local CHAR_OPEN_SQUARE_BRACKET="["
    local CHAR_CLOSED_SQUARE_BRACKET="]"

    # ♥ ☆ - Keeping some cool ASCII Characters for reference

    # Here is where we actually export the PS1 Variable which stores the text for your prompt
    local TIMESTAMP='$COLOR_WHITE#'
    #Old Prompt
    #export PS1="$COLOR_NC[\[\e[37;44;1m\]\t\[\e[0m\]]$COLOR_RED\$(parse_git_branch) \[\e[32m\]\W\[\e[0m\]\n\[\e[0;31m\]$COLOR_BLUE//$COLOR_RED $CHAR_HEART \[\e[0m\]"
    local TOP_POINTER_LINE=$COLOR_WHITE'['
    local USER_PROMPT=$COLOR_LIGHT_GREEN"\u"$COLOR_WHITE"@"
    local HOST_PROMPT=$COLOR_LIGHT_GREEN"\h"$COLOR_WHITE':'
    local PWD_PROMPT=$COLOR_LIGHT_BLUE"\w"$COLOR_WHITE']'
    local GIT_PROMPT=$COLOR_RED$COLOR_WHITE
    local BOTTOM_PROMPT=":"
    PS1=$TOP_POINTER_LINE$USER_PROMPT$HOST_PROMPT$PWD_PROMPT$COLOR_LIGHT_YELLOW$(parse_git_branch)$COLOR_WHITE'\n'$BOTTOM_PROMPT
      PS2='> '
      PS4='+ '
    }

  # Finally call the function and our prompt is all pretty
  prompt

  # For more prompt coolness, check out Halloween Bash:
  # http://xta.github.io/HalloweenBash/

  # If you break your prompt, just delete the last thing you did.
  # And that's why it's good to keep your dotfiles in git too.



########
#
# 2. Environmental Variables & Paths
#
########
  # Library Paths
  # These variables tell your shell where they can find certain
  # required libraries so other programs can reliably call the variable name
  # instead of a hardcoded path.

    # NODE_PATH
    # Node Path from Homebrew, comment out if using OSX, not needed in Linux
    #export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"

    # Those NODE & Python Paths won't break anything even if you
    # don't have NODE or Python installed. Eventually you will and
    # then you don't have to update your bash_profile

  # Configurations

    # GIT_MERGE_AUTO_EDIT
    # This variable configures git to not require a message when you merge.
    # Comment out if you prefer git not to warn you whenever you merge
    # I prefer to always be warned when this occurs, because I often make stupid muscle memory mistakes
    #export GIT_MERGE_AUTOEDIT='no'

    # Editors
    # Here you define default editors to be used by the OS whenever you ask to open a file
    # The -w flag tells your shell to wait until sublime exits
    #export VISUAL="subl -w"
    #export SVN_EDITOR="subl -w"
    #export GIT_EDITOR="subl -w"
    #export EDITOR="subl -w"

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



########
#
# 3. Helper Functions
#
########

# A function to CD into the desktop from anywhere
# so you just type desktop.
# HINT: It uses the built in USER variable to know your OS X username

# USE: desktop
#      desktop subfolder
function desktop {
  cd /Users/$USER/Desktop/$@
}

# A function to easily grep for a matching process
# USE: psg postgres
function psg {
  FIRST=`echo $1 | sed -e 's/^\(.\).*/\1/'`
  REST=`echo $1 | sed -e 's/^.\(.*\)/\1/'`
  ps aux | grep "[$FIRST]$REST"
}

# A function to extract correctly any archive based on extension
# I ALWAYS forget how to properly extract all the different kinds of archives
# that exist from the command line, so this is a nice helper to have.
# USE: extract imazip.zip
#      extract imatar.tar
function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
	    *.7zip)	7z x $1		;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Because I always forget the address format for git clones using SSH -
# here is a function that takes a string USER/REPOSITORY as only argument
function gcs () {
	local argument=$1
	gitCommand="git clone git@github.com:"$argument".git"
	echo "Executing command: $gitCommand"
	$gitCommand
}

########
#
# 4. Aliases
#
########

  #CD - UPDATE THIS
  alias dev='cd ~/Dropbox/Dev'
  alias ios='cd ~/Dropbox/Dev/iOS'
  alias ..='cd ..'
  alias ...='cd ../..'
  alias ....='cd ../../..'

  #Application Starters
  alias oxw='open *.xcw*'
  alias oxp='open *.xcod*'

  # LS
  # Set all common options desired on ls first by replacing the default ls command, here, I want to force color always on ls
  alias ls='ls --color=always'
  alias l='ls -lahG'
  alias ll='ls -FGLAhp' # my preffered ls call, but I'm calling it ll instead of replacing
  alias lt='ls -laHGt'

  # Grep
  alias grep='grep --color=auto'

  # Xresources
  alias xup='xrdb ~/.Xresources'

  # Git
  alias gcl="git clone"
  alias gst="git status"
  alias gl="git pull"
  alias gp="git push"
  alias gd="git diff | mate"
  alias gc="git commit -v"
  alias gca="git commit -v -a"
  alias gb="git branch"
  alias gba="git branch -a"
  alias gcam="git commit -am"
  alias gbb="git branch -b"

  # QEMU-KVM virtual machine launch aliases
  alias loki="sudo /home/marcus/VMs/Loki/loki-start"
  alias loki-headless="sudo /home/marcus/VMs/Loki/loki-start-headless"

  # tmux
  function tma()    { tmux attach -t $1; }
  function tml()    { tmux list-sessions; }
  function tmn()    { tmux new -s $1; }
  function tms()    { tmux switch -t $1; }
  function tmk()    { tmux kill-session -t $1; }
  function tmr()    { tmux rename-session -t $1 $2; }
  function tmlk()   { tmux list-keys; }

  # system sysctl service etc.
  alias sctl="systemctl"

  # launch steam on arch

function steam-arch {
	LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so' steam
}
# Case-Insensitive Auto Completion
  bind "set completion-ignore-case on"

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
  if [ -d ~/.virtualenvs ]; then
	  export WORKON_HOME=$HOME/.virtualenvs 
	  source /usr/local/bin/virtualenvwrapper.sh 
	  export PIP_VIRTUALENV_BASE=$WORKON_HOME
  fi
