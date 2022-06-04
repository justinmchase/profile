#!/bin/sh

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

if [ ! $(which deno) ]
then
  echo "Installing deno..."
  curl -fsSL https://deno.land/x/install/install.sh | sh
fi
