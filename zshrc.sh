# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Note that zsh-syntax-highlighting should be the last plugin
plugins=(copydir copyfile z zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

setopt prompt_subst
autoload -U colors && colors # Enable colors in prompt
setopt HIST_IGNORE_SPACE
setopt histignoredups

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}m%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}o%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}o%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[green]%}o%{$reset_color%}"

# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
    (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# Show different symbols as appropriate for various Git repository states
parse_git_state() {

    # Compose this value via multiple conditional appends.
    local GIT_STATE=""

    local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_AHEAD" -gt 0 ]; then
	    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
    fi

    local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_BEHIND" -gt 0 ]; then
	    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
    fi

    local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
    if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
	    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
    fi

    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
	    GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
    fi

    if ! git diff --quiet 2> /dev/null; then
	    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
    fi

    if ! git diff --cached --quiet 2> /dev/null; then
	    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
    fi

    if [[ $(git stash list | wc -l) -gt 0 ]]; then
	    GIT_STATE=$GIT_STATE'$'
    fi

    if [[ -n $GIT_STATE ]]; then
	    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
    fi

}

# If inside a Git repository, print its branch and state
git_prompt_string() {
    local git_where="$(parse_git_branch)"
    [ -n "$git_where" ] && echo "$(parse_git_state)$GIT_PROMPT_PREFIX%{$fg[yellow]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"
}

function customW {
    echo $PWD | sed 's|.*/\([a-zA-Z0-9]*/[a-zA-Z0-9]*\)|\1|'
}

function tmuxPaneNumber {
  echo $(tmux display-message -p '#P')
}

PS1='$(customW) $(git_prompt_string)\$ '
RPS1='$(tmuxPaneNumber) $(date "+%H:%M:%S %d/%m/%Y") $(type node >/dev/null 2>&1 && echo node $(node -v)) $(type ruby >/dev/null 2>&1 && echo $(ruby -v) | cut -d" " -f1-2)'

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    alias ls='ls -G'
    alias ll='ls -l'
    alias la='ls -la'
    alias grep='grep --color=always'
    alias rgrep='grep -r --color=always'
    alias e='emacsclient -t'
    alias xc='xclip'
    alias copy='xclip -sel clip'
    alias u='up'
    alias docker-clean='docker rmi -f $(docker images | grep "^<none>" | tr -s " " | cut -d" " -f3)'
    # Enable simplealiases to be sudo'ed. ("sudone"?)
    # http://www.gnu.org/software/bash/manual/bashref.html#Aliases says: "If the
    # last character of the alias value is a space or tab character, then the next
    # command word following the alias is also checked for alias expansion."
    alias sudo='sudo '
fi

#goes up many dirs as the number passed as argument, if none goes up by 1 by default
up(){
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++))
    do
	    d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
	    d=..
    fi
    cd $d
}

h(){
    if [ -z "$1" ]
    then history;
    else
	    history | grep "$@"
    fi
}

xs(){
    cd $1
    ls
}

f(){
    find . -name $1
}

r(){
    rgrep "$1" *
}

rv() {
    rgrep "$1" * | grep -vE $(echo "${@:2}" | tr ' ' '|')
}

js-beautify(){
    $HOME/js-beautify/python/js-beautify -i
}

todo(){
    sort <~/workspace/projects-status | sort -t '+' -k1,1 | column -s '|' -t
}

bindkey '^R' history-incremental-search-backward
bindkey 'OC' forward-word
bindkey 'OD' backward-word

tmux-select-pane-0() { tmux select-pane -t '0' }
zle -N tmux-select-pane-0
bindkey " 0" tmux-select-pane-0

tmux-select-pane-1() { tmux select-pane -t '1' }
zle -N tmux-select-pane-1
bindkey " 1" tmux-select-pane-1

tmux-select-pane-2() { tmux select-pane -t '2' }
zle -N tmux-select-pane-2
bindkey " 2" tmux-select-pane-2

tmux-select-pane-3() { tmux select-pane -t '3' }
zle -N tmux-select-pane-3
bindkey " 3" tmux-select-pane-3

# prevent tmux from renaming windows
export DISABLE_AUTO_TITLE=true
export EDITOR="vim"
export PATH=~/bin:~/.cabal/bin:~/.cask/bin:~/.rbenv/bin:/Users/lazywithclass/.rbenv/shims:$PATH
eval "$(rbenv init -)"

[ -s "/Users/lazywithclass/.scm_breeze/scm_breeze.sh" ] && source "/Users/lazywithclass/.scm_breeze/scm_breeze.sh"

echo ""
~/workspace/quote/bin/quote.sh
echo ""

todo
echo ""

COLUMNS=$(tput cols)
echo -e " _____                _         _____  _                          ____" | fmt -c -w $(($COLUMNS - 12))
echo -e "|  __ \              | |       |  __ \| |                        / __ \\" | fmt -c -w $(($COLUMNS - 13))
echo -e "| |__) |___  __ _  __| |_   _  | |__) | | __ _ _   _  ___ _ __  | |  | |_ __   ___" | fmt -c -w $(($COLUMNS - 2))
echo -e "|  _  // _ \/ _\` |/ _\` | | | | |  ___/| |/ _\` | | | |/ _ \ '__| | |  | | '_ \ / _ \\" | fmt -c -w $COLUMNS
echo -e "| | \ \  __/ (_| | (_| | |_| | | |    | | (_| | |_| |  __/ |    | |__| | | | |  __/" | fmt -c -w $COLUMNS
echo -e "|_|  \_\___|\__,_|\__,_|\__, | |_|    |_|\__,_|\__, |\___|_|     \____/|_| |_|\___|" | fmt -c -w $COLUMNS
echo -e "                         __/ |                  __/ |" | fmt -c -w $(($COLUMNS - 6))
echo -e "                        |___/                  |___/" | fmt -c -w $(($COLUMNS - 8))
echo ""
