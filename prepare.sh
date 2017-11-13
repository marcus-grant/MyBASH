#!/bin/bash


#---  FUNCTION  ----------------------------------------------------------------
#          NAME:  get-script-dir
#   DESCRIPTION:  Gets the current script directory
#    PARAMETERS:  
#       RETURNS:  
#-------------------------------------------------------------------------------
get-script-dir ()
{
   	source="${BASH_SOURCE[0]}"
	while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  		dir="$( cd -P "$( dirname "$source" )" && pwd )"
  		source="$(readlink "$source")"
  		# if $source was a relative symlink, we need to resolve it relative
 		# to the path where the symlink file was located
  		[[ $source != /* ]] && source="$dir/$source"
	done
	dir="$( cd -P "$( dirname "$source" )" && pwd )"
	echo $dir
}	# ----------  end of function get-script-dir  ----------

# TODO: edit to set powerline shell inside dot folder
# TODO: Refactor path variable names for better readability
#       - Use names like SRC, DST to make more clear which is the real file
#            and which is the link path
dotfile_path=$(get-script-dir)
real_config_path=$dotfile_path/bashrc
home_path=$HOME
link_path=$home_path/.bashrc
profile_link_path=$home_path/.bash_profile
profile_origin_path=$dotfile_path/bash_profile
powerline_origin_path=$dotfile_path/powerline-shell.py
powerline_link_path=$HOME/.powerline-shell.py

# TODO: V
# Style the console output better and put the removal steps in line with
# corresponding linking steps
echo "Preparing environment for BASH configuration."
echo "Checking if previous .bashrc exists."

if [ -f $link_path ]; then
	echo "Previous bash file exists, backing it up with .bak suffix"
	mv $link_path $linkPath.bak
fi

if [ -L $link_path ]; then
	echo "Previous symlink exists, removing it."
	rm $link_path
fi

if [ -f $profile_link_path ]; then
    echo "Previous bash_profile exists, removing it."
    rm $profile_link_path
fi

if [ -f $profile_link_path ]; then
    echo "Previous bash_profile symlink exists, removing it."
    rm $profile_link_path
fi


echo "Creating symlink for .bashrc"
echo "$link_path -> $real_config_path"
ln -s $real_config_path $link_path

echo "Creating symlink for .bash_profile"
echo "$profile_link_path -> $profile_origin_path"
ln -s $profile_origin_path $profile_link_path
echo

echo "Creating symlink for ~/powerline-shell.py"
rm ~/powerline-shell.py
ln -s $powerline_origin_path $powerline_link_path
echo

echo "Dotfile preperation complete!"
exit 0
