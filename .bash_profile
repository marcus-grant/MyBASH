#######
# 
# myBash .bash_profile
# 
# written by Marcus Grant (2016) of thepatternbuffer.com
#
#######

# for now we will have the profile match the rc, later I will add things like system info messages so you see them on login


if [ -f $HOME/.bashrc ]; then
	source $HOME/.bashrc
fi


# run archey3 if it exists
if hash archey3 2>/dev/null; then
    archey3
fi
# TODO: Add an else for when archey isn't there, that at the very least includes uname and hostname

# TODO: Move keychain key installations commands to here instead of rc

#-------------------------------------------------------------------------------
# environment variables
#-------------------------------------------------------------------------------
# TODO !!!!!! Be sure to migrate the .bashrc ones over to here instead

# Rust's cargo package manager needs for there to be some kind of standard path
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/share/anaconda3/bin:$PATH"
export PATH="$HOME/bin:$PATH"
# Go's GOPATH
export PATH="$PATH:$HOME/bin/go/bin"

# Run the bashrc
source $HOME/.bashrc

# set xdg's
# TODO: find better way to standardize this across systems particularly on arch
#export XDG_CONFIG_HOME="${XDG_CONFIG_HOME}:$HOME/.config"
