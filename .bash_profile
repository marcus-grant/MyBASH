#######
# 
# myBash .bash_profile
# 
# written by Marcus Grant (2016) of thepatternbuffer.com
#
#######

# for now we will have the profile match the rc, later I will add things like system info messages so you see them on login


if [ -f ./bashrc ]; then
	source ~/.bashrc
fi


# run archey3 if it exists
if hash archey3 2>/dev/null; then
    archey3
fi


