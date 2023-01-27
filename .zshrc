# .zshrc local file

## Enable correction if needed and disable unsecure directories fix which is truely just annoying
ZSH_DISABLE_COMPFIX="true"
ENABLE_CORRECTION="true"

## Setup a couple environmental variables (most will be in the source-doc files)
export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8

## Setup the EDITOR variable for when using SSH
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nano'
 else
   export EDITOR='kwrite'
 fi

## Now source the prompt init.  There are a few ways to do this, this method works best for when frequently preforming fresh installations.
source $ZSH/oh-my-zsh.sh

## This is the last file to be sourced when executing a zsh call.  Load the prompt theme
source ~/bin/theme

## Load the synaxers
if [ -e $script/syntaxers ]; then
  cd $func; wait
  ./syntaxers
  if [[ $? -ne 0 ]]; then
    chmod +x $script/syntaxers
    if [[ $? -ne 0 ]]; then
      echo "It's possble that the syntaxers file is not present, or this could be a script error calling this message"
    fi
  fi
fi

cd ~/

  for files in /main/source-docs/*; do
     source $files
  done

