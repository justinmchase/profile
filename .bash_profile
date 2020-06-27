source ~/.bash_colors
source ~/.bash_cursor
[ -f "~/.bash_local" ] && source ~/.bash_local

function branch {
  if [ -d .git ]; then
    name=$(git rev-parse --symbolic-full-name --abbrev-ref @ 2> /dev/null)
    tags=$(git name-rev --name-only @ 2> /dev/null)
    if [ "$name" == "$tags" ]; then
      echo -e "$IWhite:$IPurple$name"
    else
      echo -e "$IWhite:$IPurple$name $IWhite($ICyan$tags$IWhite)"
    fi
  fi
}

function git-prune {
  git remote prune origin
  git fetch --prune
  git branch -vv | grep -v "\[origin\/" | awk '{print $1}' | xargs git branch -D
  git branch -v  | grep    "\[gone\]"   | awk '{print $1}' | xargs git branch -D
}

function git-clean {
  git-prune
}

function kill-port() {
  lsof -i tcp:$1 | grep LISTEN | awk '{print $2}' | xargs kill -9
}

function kill-app() {
  ps aux | grep "$1" | grep -v grep | awk 'killing {print$2}'
  ps aux | grep "$1" | grep -v grep | awk '{print $2}' | xargs kill -9
}

function docker-clean() {
  docker rmi $(sudo docker images --no-trunc=true --filter dangling=true --quiet)
}

alias guid="uuidgen | tr -d - | tr -d '\n' | tr '[:upper:]' '[:lower:]'  | pbcopy && pbpaste && echo"

PS1="\[$IGreen\]\t\[$IWhite\]:\[$IRed\]\u\[$IWhite\]:\[$IYellow\]\w\$(branch)\[$Color_Off\]\$ "

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
