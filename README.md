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
		source ~/Shell/mybash/.bash_profile
	fi
``` 
**TODO: create a simple shell script that takes care of this to simplify install**

# Prompt Configuration
The prompt is what you see on the left-most side of every open command line, it is there originally to show you what user you are currently logged in or aliased as on the system, and it shows you under which hostname you are operating on, which is very useful when you telnet or ssh into a system to manage it. In this case we are going to add some more info, like the timestamp for when the prompt was written, to help track time, the git branch you are on if there is one in your current directory, the current directory, and we will style it to my liking. To do this, add the lines below to your `.bashrc`.
```
# Configuring Our Prompt
# ======================

  # if you install git via homebrew, or install the bash autocompletion via homebrew, you get __git_ps1 which you can use in the PS1
  # to display the git branch.  it's supposedly a bit faster and cleaner than manually parsing through sed. i dont' know if you care 
  # enough to change it

  # This function is called in your prompt to output your active git branch.
  function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
  }

  # This function builds your prompt. It is called below
  function prompt {
    # Define some local colors
    local         RED="\[\033[0;31m\]" # This syntax is some weird bash color thing I never
    local   LIGHT_RED="\[\033[1;31m\]" # really understood
    local        CHAR="♥"
    local   BLUE="\[\e[0;49;34m\]"

    # ♥ ☆ - Keeping some cool ASCII Characters for reference

    # Here is where we actually export the PS1 Variable which stores the text for your prompt
    export PS1="\[\e]2;\u@\h\a[\[\e[37;44;1m\]\t\[\e[0m\]]$RED\$(parse_git_branch) \[\e[32m\]\W\[\e[0m\]\n\[\e[0;31m\]$BLUE//$RED $CHAR \[\e[0m\]"
      PS2='> '
      PS4='+ ' 
    }

  # Finally call the function and our prompt is all pretty
  prompt

  # For more prompt coolness, check out Halloween Bash:
  # http://xta.github.io/HalloweenBash/

  # If you break your prompt, just delete the last thing you did.
  # And that's why it's good to keep your dotfiles in git too.
```

