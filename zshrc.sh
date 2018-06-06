# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Note that zsh-syntax-highlighting should be the last plugin
plugins=(copydir copyfile zsh-256color z zsh-autosuggestions zsh-syntax-highlighting)

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
    [ -n "$git_where" ] && echo "on $(parse_git_state)$GIT_PROMPT_PREFIX%{$fg[yellow]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"
}

function customW {
  pwd | awk -F\/ '{print $(NF-1),$(NF)}' | tr ' ' '/'
}

function foldersFromGit {
  steps=0
  while [[ ! $(ls -a .git &>/dev/null) && $CWD != '/' ]]; do 
    steps=$((steps+1))
    cd ..
  done
  echo $steps
}

PS1='$(whoami) at $(hostname) in %{$fg[yellow]%}$(customW)%{$reset_color%} $(git_prompt_string)
\$ '

RPS1='$(date "+%H:%M:%S %d/%m/%Y")'

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    alias ls='ls -G'
    alias ll='ls -l'
    alias la='ls -la'
    alias rgrep='grep -r --color=always'
    alias e='emacsclient -t'
    alias u='up'
    alias docker-clean='docker rmi -f $(docker images | grep "^<none>" | tr -s " " | cut -d" " -f3)'
    alias vmip='vmrun getGuestIPAddress "$(vmrun list | tail -1)"'
    alias ctags="`brew --prefix`/bin/ctags"
    alias man="tldr"
    alias dot="xdot"

    # Enable simplealiases to be sudo'ed. ("sudone"?)
    # http://www.gnu.org/software/bash/manual/bashref.html#Aliases says: "If the
    # last character of the alias value is a space or tab character, then the next
    # command word following the alias is also checked for alias expansion."
    alias sudo='sudo '
    # https://superuser.com/a/1127215/346
    alias scp='noglob scp'

    alias vless='vim -u /usr/share/vim/vim80/macros/less.vim'
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

hextostring() {
  echo $1 | tr ',' ' ' | sed 's/0x//g' | xxd -r -p
}

stringtohex() {
  echo $1 | tr ',' ' ' | sed 's/0x//g' | od -t x1
}

funx='\033[38;5;200m'
symbol='\033[38;5;85m'
parens='\033[1;36m'
quote='\033[38;5;200m'
nc='\033[0m'
todo() {
  echo -e "${parens}(${nc}${funx}it-will-be${nc} ${quote}'${nc}${symbol}okay${nc}${parens})${nc}"
  sort <~/workspace/project-status | sort -t '+' -k1,1 | column -s '|' -t
  echo ""
}

if [ -x "$(command -v setxkbmap)" ]; then
  setxkbmap -option caps:ctrl_modifier
fi

bindkey '^R' history-incremental-search-backward

eval $(thefuck --alias)

[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

echo ""
fortune
echo ""

COLUMNS=$(tput cols)
echo -e " _____                _         _____  _                          ____" | fmt -c -w $(($COLUMNS - 12))
echo -e "|  __ \              | |       |  __ \| |                        / __ \\" | fmt -c -w $(($COLUMNS - 12))
echo -e "| |__) |___  __ _  __| |_   _  | |__) | | __ _ _   _  ___ _ __  | |  | |_ __   ___" | fmt -c -w $(($COLUMNS -1))
echo -e "|  _  // _ \/ _\` |/ _\` | | | | |  ___/| |/ _\` | | | |/ _ \ '__| | |  | | '_ \ / _ \\" | fmt -c -w $COLUMNS
echo -e "| | \ \  __/ (_| | (_| | |_| | | |    | | (_| | |_| |  __/ |    | |__| | | | |  __/" | fmt -c -w $COLUMNS
echo -e "|_|  \_\___|\__,_|\__,_|\__, | |_|    |_|\__,_|\__, |\___|_|     \____/|_| |_|\___|" | fmt -c -w $COLUMNS
echo -e "                         __/ |                  __/ |" | fmt -c -w $(($COLUMNS - 6))
echo -e "                        |___/                  |___/" | fmt -c -w $(($COLUMNS - 8))
echo ""

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/lazywithclass/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/lazywithclass/Downloads/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/lazywithclass/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/lazywithclass/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

todo

