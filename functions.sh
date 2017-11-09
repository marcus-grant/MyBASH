########
#
# Functions for Bash Prompt
#
########

# some functions need to know the host OS type, and the only argument to this script
# will be stored as variable 'machine'
machine=$1

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
  local GIT_ROOT="git@github.com:marcus-grant"
  local GIT_URL="$GIT_ROOT/$1.git"
  echo
  echo "Cloning from $GIT_URL ......."
  echo
  git clone $GIT_URL
  echo
  echo "Done cloning!"
}

# Easier way to clone a personal repository ussing https
# Only argument is the repository name from my personal github acct. marcus-grant
function gch () {
  local GIT_ROOT="https://github.com/marcus-grant"
  local GIT_URL="$GIT_ROOT/$1"
  echo "Cloning from $GIT_URL ......."
  git clone $GIT_URL
  echo
  echo "Done cloning!"
}

# Git Pull All - gpa - pulls all branches to local from remote
function gpa () {
  git branch -r | grep -v '\->' | while read remote;
    do git branch --track "${remote#origin/}" "$remote";
    done
  git fetch --all
  git pull --all
}

# Helper function to recursively apply the right plex permissions
function plex-permissions()
{
  echo
  echo "Recursively changing permissions of $1 to +r +x, & owned by marcus:media"
  echo
  chown -R marcus:media "$1"
  chmod -R +x "$1"
  echo
  echo "Done! Plex servers should now be able to index & gather metadata for this folder."
  echo
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
#    ssh-agent > $HOME/.ssh-agent-thing
#fi
#if [[ "$SSH_AGENT_PID" == "" ]]; then
#    eval "$(<$HOME/.ssh-agent-thing)"
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


  # TODO: Doesn't work -- Worth the effort????
  #function gacm() {
  #    local num_additions=$(($#-1))
  #    local additions=${@:1:$num_additions}
  #    local commit_message=${!#}
#
#      echo 
#      echo "Adding, then committing staged changes using git:"
#      echo "================================================="
#      echo "message: $message"
#      echo "files: $additions"
#      echo 
#      echo "Are these files & message correct?"
#      echo "Hit [Enter] to confirm, or any other key to discard!: "
#
#      read -s -n 1 key
#      if [[ $key = "" ]]; then
#          echo
#          echo "Adding, and committing!"
#          echo
#      else
#          exit 1
#      fi
#
#      git add $additions && git commit -m $commit_message
#  }


  # tmux
  # NOTE: Updated to include '-2' option to force the screen-256color option
  function tma()    { tmux -2 attach -t $1; }
  function tml()    { tmux list-sessions; }
  function tmn()    { tmux -2 new -s $1; }
  function tms()    { tmux -2 switch -t $1; }
  function tmk()    { tmux kill-session -t $1; }
  function tmr()    { tmux rename-session -t $1 $2; }
  function tmlk()   { tmux list-keys; }



  # launch steam on arch

function steam-arch {
	LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so' steam
}
# Case-Insensitive Auto Completion
  bind "set completion-ignore-case on"

