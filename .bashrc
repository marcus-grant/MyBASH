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

  #---  FUNCTION  ----------------------------------------------------------------
  #          NAME:  old_prompt
  #   DESCRIPTION:  The old version using static decorations for old bash PS1
  #    PARAMETERS:  
  #       RETURNS:  
  #-------------------------------------------------------------------------------
  function old_prompt {
    # Define some local colors
    # local   RED="\[\033[0;31m\]" # This syntax is some weird bash color stuff
    local color_nc='\e[0m' # No Color
    local color_white='\e[1;37m' # Some color codes that make absolutely
    local color_black='\e[0;30m' # no sense to me, they're just googled snippets
    local color_blue='\e[0;34m'
    local color_light_blue='\e[1;34m'
    local color_green='\e[0;32m'
    local color_light_green='\e[1;32m'
    local color_cyan='\e[0;36m'
    local color_light_cyan='\e[1;36m'
    local color_red='\e[0;31m'
    local color_light_red='\e[1;31m'
    local color_purple='\e[0;35m'
    local color_light_purple='\e[1;35m'
    local color_brown='\e[0;33m'
    local color_yellow='\e[0;33m'
    local color_light_yellow='\e[1;33m'
    local color_gray='\e[0;30m'
    local color_light_gray='\e[0;37m'


    
    

    # ♥ ☆ - Keeping some cool ASCII Characters for reference
    local char_heart="♥"
    local char_open_square_bracket="["
    local char_closed_square_bracket="]"
    


    # Here is where we actually export the PS1 Variable which stores the text for your prompt
    local timestamp='$color_white#'
    #Old Prompt
    #export PS1="$color_nc[\[\e[37;44;1m\]\t\[\e[0m\]]$COLOR_red\$(parse_git_branch) \[\e[32m\]\W\[\e[0m\]\n\[\e[0;31m\]$COLOR_blue//$COLOR_RED $char_heart \[\e[0m\]"
    # OLD PROMPT [user@host:pwd](git)(venv)\n:
    #local TOP_POINTER_LINE=$color_white'['
    #local USER_PROMPT=$color_light_green"\u"$COLOR_white"@"
    #local HOST_PROMPT=$color_light_green"\h"$COLOR_white':'
    #local PWD_PROMPT=$color_light_blue"\w"$COLOR_white']'
    #local GIT_PROMPT=$color_red$COLOR_white
    #local BOTTOM_PROMPT=":"
    #PS1=$TOP_POINTER_LINE$USER_PROMPT$HOST_PROMPT$PWD_PROMPT$color_light_yellow$(parse_git_branch)$COLOR_white'\n'$BOTTOM_PROMPT

    # New prompt to look like powerline
    local 
      PS2='> '
      PS4='+ '
    }

     
    #---  FUNCTION  ----------------------------------------------------------------
    #          NAME:  _update_ps
    #   DESCRIPTION:  updates PS1 prompt using powerline-shell.py
    #    PARAMETERS:  no params, but uses /bashrc/path/powerline-shell.py
    #       RETURNS:  
    #-------------------------------------------------------------------------------
    function _update_ps1 ()
    {
        PS1="$(~/.powerline-shell.py $? 2> /dev/null)" 
    }	# ----------  end of function _update_ps1  ----------

    if [ "$TERM" != "linux" ]; then
            PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi

  # DEPRECATED - No longer using
  # Finally call the function and our prompt is all pretty
  #prompt

  # For more prompt coolness, check out Halloween Bash:
  # http://xta.github.io/HalloweenBash/

  # If you break your prompt, just delete the last thing you did.
  # And that's why it's good to keep your dotfiles in git too.



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
    
    # Anaconda (change for OS)
    export PATH="/home/marcus/.anaconda3/bin:$PATH"

    # eval keychain to update ssh-agent with private keys
    eval $(keychain --eval --quiet ~/.ssh/git.key )



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

# A helper to pipe commands into python for immediate interpretation
# TODO: figure out proper way to handle newlines, quotes, and spaces
function pypipe()
{

  python_statements="$1"
  echo "$python_statements" | python
  # for statement in "$@"; do
  #   python_statements="$python_statements$statement\n"
  # done
  # echo "$python_statements" | python
}


function caps-as-esc()
{
    xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
}


keyboard-default ()
{
    setxkbmap us
}	# ----------  end of function keyboard-default  ----------



# ssh-agent startup script that checks for a previous running one
#if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#    ssh-agent > ~/.ssh-agent-thing
#fi
#if [[ "$SSH_AGENT_PID" == "" ]]; then
#    eval "$(<~/.ssh-agent-thing)"
#fi


#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  toggle-touchpad
#   DESCRIPTION:  From http://bit.ly/2tUl5QN & http://bit.ly/1lsLa2r
#				Toggles touchpad on & off to the system with prompts if desired
#    PARAMETERS:  -q or --quiet if no prompts are wanted, otherwise it will
#       RETURNS:  Nothin but an echo and notify-osd even by default
#-------------------------------------------------------------------------------
toggle-touchpad ()
{	
	IS_QUIET=0
	if (( $# > 0 )); then
		if [[ "$1" == "-q" ]] || [[ "$1" == "--quiet" ]]; then
			IS_QUIET=1
		else
			echo ""
			echo "[ERROR] bashrc:toggle-touchpad(): wrong argument given, only -q or --quiet or nothing permitted"
			echo "By default the toggle invokes bash echo outs and notify osd prompts"
			echo ""
		fi
	fi 
    declare -i ID
    ID=`xinput list | grep -Eio '(touchpad|glidepoint)\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`
    declare -i STATE
    STATE=`xinput list-props $ID|grep 'Device Enabled'|awk '{print $4}'`
    if [ $STATE -eq 1 ]; then
    	xinput disable $ID
		if (( IS_QUIET == 0 )); then
    		echo "Touchpad disabled." 
			notify-send 'Touchpad' 'Disabled' -i /usr/share/icons/Adwaita/48x48/devices/input-touchpad.png
		fi
	else
    	xinput enable $ID
		if (( IS_QUIET == 0 )); then
    		echo "Touchpad enabled." 
			notify-send 'Touchpad' 'Enabled' -i /usr/share/icons/Adwaita/48x48/devices/input-touchpad.png
		fi
    # echo "Touchpad enabled."
    # notify-send 'Touchpad' 'Enabled' -i /usr/share/icons/Adwaita/48x48/devices/input-touchpad.png
	fi

}	# ----------  end of function toggle-touchpad  ----------

#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  view-markup
#   DESCRIPTION:  From https://unix.stackexchange.com/questions/4140/markdown-viewer#120519
#   -- Views any marked up document like *.md as a styled page inside lynx
#   -- Requires pandoc & lynx, potentially python later
#    PARAMETERS: None (for now) | TODO: output options 
#       RETURNS: Opens lynx after piping with pandoc
#-------------------------------------------------------------------------------
view-markup ()
{
    pandoc $1 | lynx -stdin
}	# ----------  end of function view-markup  ----------

########
#
# 4. Aliases
#
########

  #CD - UPDATE THIS
#  alias ios='cd ~/Dropbox/Dev/iOS'
  alias dev='cd ~/Code'
  alias pydev='cd ~/Code/python'
  alias webdev='cd ~/Code/web'
  alias dev-notes='cd ~/Documents/dev-notes'
  alias dotfiles='cd ~/.dotfiles'
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
  alias igrep='grep -i' # a grep alias for case insensitive searches

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
  function tmn()    { tmux new -2 -s $1; }
  function tms()    { tmux switch -t $1; }
  function tmk()    { tmux kill-session -t $1; }
  function tmr()    { tmux rename-session -t $1 $2; }
  function tmlk()   { tmux list-keys; }


  #-----------------------------------------------------------------------
  # Vim aliases
  #-----------------------------------------------------------------------
  alias viml='vim "+set background=light"' #runs vim in a light colorscheme

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
