# TODO where am I setting 
# /usr/local/Cellar/ruby/2.4.2_1/bin
# ?
# Also, why $PATH is all messed up with duplicates?

HOME_BINARIES=$HOME/bin
NODE_BINARIES=/usr/local/lib/node_modules
HASKELL_BINARIES=$HOME/.cabal/bin:$HOME/workspace/idris-dev/.cabal-sandbox/bin
CLING_BINARIES=$HOME/workspace/cling-build/builddir/bin
JAVASCRIPT_BINARIES=$HOME/workspace/tern/bin
RACKET_BINARIES=/Applications/Racket\ v6.11/bin/
GIT_BINARIES=/usr/local/Cellar/git/2.15.0/bin/git
export PATH="/usr/local/bin:$GIT_BINARIES:$JAVA_BINARIES:$RACKET_BINARIES:$HOME_BINARIES:$NODE_BINARIES:$HASKELL_BINARIES:$CLING_BINARIES:$PATH"

export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_9_HOME=$(/usr/libexec/java_home -v9)
alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java9='export JAVA_HOME=$JAVA_9_HOME'
export JAVA_HOME=$JAVA_8_HOME

# prevent tmux from renaming windows
export DISABLE_AUTO_TITLE=true
export EDITOR="vim"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=white"
export GTAGSLABEL=new-ctags
export GTAGSCONF=/usr/local/share/gtags/gtags.conf
