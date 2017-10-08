#!/bin/bash

# check that exactly one argument for configuration to link path is given
if (( $# != 1 )); then
  echo "[ERROR]: invalid number of arguments given, please give a single argument for path to prompt configuration"
  exit 1
fi

# check that a valid prompt file was chosen
if [ ! -e $1 ]; then
  echo "[ERROR]: The given file path doesn't exist, please chose a valid path to a prompt configuration."
  exit 1
fi
# foolproof way to figure out where this script is placed
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  dir="$( cd -P "$( dirname "$source" )" && pwd )"
  source="$(readlink "$source")"
  # if $source was a relative symlink, we need to resolve it relative
  # to the path where the symlink file was located
  [[ $source != /* ]] && source="$dir/$source"
done
dir="$( cd -P "$( dirname "$source" )" && pwd )" #dir now has the script locat'n

ln -s "$dir/$1" "$dir/prompt-link"
