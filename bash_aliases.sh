########
#
# All Bash Aliases Are defined here
#
########

#CD - All cd aliases for quickly changing directories
#  alias ios='cd $HOME/Dropbox/Dev/iOS'
alias dev='cd $HOME/code'
alias pydev='cd $HOME/code/python'
alias webdev='cd $HOME/code/web'
alias aidev='cd $HOME/code/ai'
alias dotfiles='cd $HOME/.dotfiles'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# different aliases based on if it's a mac
# TODO: Verify that this works after splitting aliases into own file and passing args
if [[ "$MACHINE" == 'mac' ]]; then
  alias dev-notes='cd $HOME/Documents/dev-notes'
elif [[ "$MACHINE" == 'linux' ]]; then
  alias dev-notes='cd $HOME/documents/dev-notes'
fi

# MAC open xcode
if [[ "$MACHINE" == "mac" ]]; then
  alias oxw='open *.xcw*'
  alias oxp='open *.xcod*'
fi

# LS
# Set all common options desired on ls first by replacing the default ls command, here, I want to force color always on ls
alias ls='ls --color=always'
alias l='ls -lahG'
alias la='ls -lah'
alias ll='ls -FGLAhp' # my preffered ls call, but I'm calling it ll instead of replacing
alias lt='ls -laHGt'

# Grep
alias grep='grep --color=auto'
alias igrep='grep -i' # a grep alias for case insensitive searches

# Use xclip to get & set the clipboard
alias clipin='xclip -i -selection clipboard'
alias clipout='xclip -o -selection clipboard'

# Xresources
alias xup='xrdb $HOME/.Xresources'

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

# Python, Anaconda & Jupyter
alias jnb="jupyter-notebook"

#-----------------------------------------------------------------------
# Vim aliases
#-----------------------------------------------------------------------
alias viml='vim "+set background=light"' #runs vim in a light colorscheme

# system sysctl service etc.
alias sctl="systemctl"

# QEMU-KVM virtual machine launch aliases
alias loki="sudo $HOME/VMs/Loki/loki-start"
alias loki-headless="sudo $HOME/VMs/Loki/loki-start-headless"

