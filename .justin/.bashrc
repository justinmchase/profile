source ~/.justin/.bash_colors
source ~/.justin/.bash_cursor
[ -f ~/.bash_local ] && source ~/.bash_local

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
      echo -e "$Color_Off:$Purple$name$Color_Off"
    else
      echo -e "$Color_Off:$Purple$name $White($Cyan$tags$White)$Color_Off"
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

function repo() {
  URL=$1
  DIR=$(URL#https://}
  DIR=$HOME/code/${DIR%%.git}
  if [[ ! -d $DIR ]]; then
    echo "$URL to $DIR"
    git clone $URL $DIR
  fi
  code $DIR
}


# If not running interactively, don't set PS1
case $- in
    *i*) ;;
      *) return;;
esac

PS1="\[$IGreen\]\t\[$IWhite\]:\[$IRed\]\u\[$IWhite\]:\[$IYellow\]\w\$(branch)\[$Color_Off\]\n\[\$(status-color \$?)\]>\[$Color_Off\] "
PROMPT_COMMAND=
