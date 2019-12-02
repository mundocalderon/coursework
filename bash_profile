#Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions

export PS1="[\w]$ "

alias ll='ls -laFG '
alias ls='ls -laFG '
alias la='ls -Al'  #show hidden files
alias lx='ls -lxB' #sort by extension
alias lk='ls -lSr' #sort by size, biggest last
alias lc='ls -ltcr' #sort by and show change time, most recent last
alias lu='ls -ltur' #sort by and show access time, most recent last
alias lt='ls -ltr' #sort by date, most recent last
alias lr='ls -lR' #recursive ls
alias tree='tree -Csu' #nice alternative to recursive ls
alias ..='cd ..'
alias ...='cd ../..'
alias mysql='mysql -uroot -p'
alias cdcap='cd /Users/mundocalderon/Sites/capsf-web/'
alias fresh='sudo service httpd restart'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
