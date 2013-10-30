# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Appearance
source "`brew --prefix`/etc/grc.bashrc"
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad
export PS1="\u@\h:\w \$(vcprompt)\$ "

# don't put duplicate lines in the history. See bash(1) for more options
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=32768
HISTFILESIZE=$HISTSIZE
shopt -s histappend
export PROMT_COMMAND='history -a'

# Make some commands not show up in history
export HISTIGNORE="ls:ls *:cd:cd -:pwd;exit:date:* --help"

# enabling virtual envs
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/local/bin/lesspipe.sh ] && eval "$(SHELL=/bin/sh /usr/local/bin/lesspipe.sh)"

# Adding bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Adding git completion
. ~/.config/completion/git-completion.bash
complete -o default -o nospace -F _git g

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
         COMP_CWORD=$COMP_CWORD \
            PIP_AUTO_COMPLETE=1 $1  )  )

}
complete -o default -F _pip_completion pip
# pip bash completion end

# Add RVM to path
PATH=/usr/local/bin:$PATH:/Users/walid/tools/android-sdk-macosx/platform-tools

# Loading custom aliases
. ~/.config/bash_aliases

# Enabling liquidprompot
if [ -f $(brew --prefix)/bin/liquidprompt ]; then
  . $(brew --prefix)/bin/liquidprompt
fi

# Set default editor to vim
export EDITOR=vim
export HOMEBREW_EDITOR=vim

# Set pager to vimpager
export PAGER=vimpager
alias less=$PAGER
alias zless=$PAGER

# Set Vim for manuals
export MANPAGER="col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -"
