#!/bin/bash

dotfilePath=$(pwd)
realConfigPath=$dotfilePath/.bashrc
homePath=$HOME
linkPath=$homePath/.bashrc

echo "Preparing environment for BASH configuration."
echo "Checking if previous .bashrc exists."

if [ -f $linkPath ]; then
	echo "Previous bash file exists, backing it up with .bak suffix"
	mv $linkPath $linkPath.bak
fi

if [ -L $linkPath ]; then
	echo "Previous symlink exists, removing it."
	rm $linkPath
fi

echo "Creating symlink for .bashrc"
echo "$linkPath -> $realConfigPath"
ln -s $realConfigPath $linkPath

echo
echo "Dotfile preperation complete!"
exit 0
