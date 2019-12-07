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
------------------------------------------------------------
#Change the way my prompt appears
export PS1="\n[\u \W]$ " 
#I'm adding my own personal /bin path that has functions I've written.
export PATH=~/Projects/Coursework/jhu-unix-workbench/Commands:$PATH
#I'm sourcing a commands file that keeps a list of all the commands and source's them so that they are up to date when opening a shell
echo "sourcing Commands directory"
source ~/Projects/Coursework/jhu-unix-workbench/Commands/commands.sh

# Aliases
alias ls='ls -G'
alias ll='ls -alF'
alias cdwork='cd ~/Projects/Coursework'
alias rsmongo='brew services restart mongodb-community'

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export WEB_URL='http://www.coursera.com'
export FOOD2FORK_KEY='6c9e5c2bfe59ec7e7a4e95a64a189fcd'
 
#Digital Ocean server 
export DO_ROOT_USER='root@159.65.109.164'
export MONGO_USER='admin'
export MONGO_PW='1234'
export MONGO_URI='mongodb+srv://admin:1234@cluster0-493fz.mongodb.net/test?retryWrites=true&w=majority'
