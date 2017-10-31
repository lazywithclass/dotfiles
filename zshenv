HOME_BINARIES=$HOME/bin
NODE_BINARIES=/usr/local/lib/node_modules
HASKELL_BINARIES=$HOME/.cabal/bin:$HOME/workspace/idris-dev/.cabal-sandbox/bin
CLING_BINARIES=$HOME/workspace/cling-build/builddir/bin
JAVASCRIPT_BINARIES=$HOME/workspace/tern/bin
RACKET_BINARIES=/Applications/Racket\ v6.11/bin/

# prevent tmux from renaming windows
export DISABLE_AUTO_TITLE=true
export EDITOR="vim"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=white"
export PATH="$RACKET_BINARIES:$HOME_BINARIES:$NODE_BINARIES:$HASKELL_BINARIES:$CLING_BINARIES:$PATH"
export GTAGSLABEL=pygments
export GTAGSCONF=/usr/local/share/gtags/gtags.conf
