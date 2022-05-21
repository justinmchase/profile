source ~/.justin/.bash_colors
source ~/.justin/.bash_cursor
[ -f "~/.bash_local" ] && source ~/.bash_local

function status-color {
  if [ "$1" == "0" ]
  then
    echo -e "$IGreen"
  else
    echo -e "$IRed"
  fi
}

function branch {
  if [ -d .git ]; then
    name=$(git rev-parse --symbolic-full-name --abbrev-ref @ 2> /dev/null)
    tags=$(git name-rev --name-only @ 2> /dev/null)
    if [ "$name" == "$tags" ]; then
      echo -e "$Purple$name$Color_Off"
    else
      echo -e "$Purple$name $White($Cyan$tags$White)$Color_Off"
    fi
  fi
}

function ptime {
  echo -e "$(date '+%T')"
}

function prompt-command {
  if [ "$?" == "0" ]
  then
    ERR="$Green"
  else
    ERR="$Red"
  fi

  echo -ne "$Green$(ptime)$White:$Cyan$(whoami)$White:$Blue$(dirs +0)$White:$(branch)\n$ERR>$Color_Off "
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

alias guid="uuidgen | tr -d - | tr -d '\n' | tr '[:upper:]' '[:lower:]'  | pbcopy && pbpaste && echo"

PS1=
PROMPT_COMMAND="prompt-command"