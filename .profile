# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

# if running bash
[ -n "$BASH_VERSION" ] && . "$HOME/.justin/.bashrc"

. $HOME/.justin/common.sh
. $HOME/.justin/deno.sh
. $HOME/.justin/node.sh
. $HOME/.justin/kubernetes.sh
. $HOME/.justin/dotnet.sh
