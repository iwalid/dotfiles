# Shortcuts
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias h='history'
alias j='jobs -l'
alias c='clear'
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'

# File & directory creation
alias mkdir='mkdir -pv'

# File & directory listing
alias ls='ls -F'
alias ll='ls -la'
alias l.='ls -d .*'

# Grep coloration
export GREP_OPTIONS='--color=auto'
alias diff='colordiff'
alias mount='mount|column -t'

# Git
alias g='git'
alias gr='git rm -rf'
alias gs='git status'
alias ga='g add'
alias gc='git commit -m'
alias gp='git push origin master'
alias gl='git pull origin master'

# Brew
alias b='brew'
alias brwe='brew'
alias bup='brew update'
alias bupg='brew upgrade'

# Others
alias v='vim'
alias vi='vim'
alias svi='sudo vi'
alias edit='vim'
alias ping='ping -c 5'
alias nping='\ping'
alias df='df -H'
alias du='du -h'
alias cpProgress="rsync --progress -ravz"
alias nocomment='grep -Ev '\''^(#|$)'\'''
alias hg='history|grep'
alias tf='tail -f '
alias psg='ps -ef | grep'
alias tmux='tmux -u'

# find file by name in current directory
function _fn() { find . -name $1;}
alias fn=_fn

# Debug webserver
alias header='curl -I'
alias headerc='curl -I --compress'
# Resume wget by default
alias wget='wget -c'
