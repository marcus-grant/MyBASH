# MyBASH

This is my repository to store my personal bash configurations. They are divided into different files so it is easier to maintain different versions. They are also stored in ~/SHELL/mybash/ so that git can work properly, and they are sourced in .bash_profile and .bashrc by single line references so that they reference whatever version I'd like. There will be a write up for my blog for how I set this config up, how I use it, and why coming shortly, and its contents will be here and on my [personal site/blog](http://thepatternbuffer.com).

Whenever this repository is being used for the first time, a few things will need to be done first:
1. Run `git clone https://github.com/marcus-grant/mybash` in your `~/` directory, aka, your home
2. Clear .bashrc and paste this into it and save:
```
	if [ -f ~/Shell/mybash/.bashrc ]; then
		source ~/Shell/mybash/.bashrc
	fi

```
3. Do the same for `~/.bash_profile` with this:
```
	if [ -f ~/Shell/mybash/.bash_profile ]; then
		source ~/Shell/mybash/.bashrc
	fi
``` 
**TODO: create a simple shell script that takes care of this to simplify install**
