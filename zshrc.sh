# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=()

source $ZSH/oh-my-zsh.sh

setopt prompt_subst
autoload -U colors && colors # Enable colors in prompt
setopt HIST_IGNORE_SPACE

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"

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
    echo $PWD | sed 's|.*/\([a-zA-Z0-9][a-zA-Z0-9]*/[a-zA-Z0-9][a-zA-Z0-9]*\)|\1|'
}
PS1='$(customW) $(git_prompt_string)\$ '
RPS1='$(date "+%H:%M:%S %d/%m/%Y") $(type node >/dev/null 2>&1 && echo node $(node -v))'

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias ll='ls -l'
    alias la='ls -la'
    alias grep='grep --color=always'
    alias rgrep='rgrep --color=always'
    alias e='emacsclient -t'
    alias xc='xclip'
    alias copy='xclip -sel clip'
    alias gits='git status'
    # Enable simplealiases to be sudo'ed. ("sudone"?)
    # http://www.gnu.org/software/bash/manual/bashref.html#Aliases says: "If the
    # last character of the alias value is a space or tab character, then the next
    # command word following the alias is also checked for alias expansion."
    alias sudo='sudo '
    alias t='tig status'
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
	history | grep "$@"; 
    fi
}

xs(){
    cd $1 
    ls
}

f(){
    find . -name $1;
}

r(){
    rgrep "$1" *
}

js-beautify(){
    /home/lazywithclass/js-beautify/python/js-beautify -i
}

. ~/Dropbox/z/z.sh

# away with you CAPS LOCK!
setxkbmap -option caps:none

export EDITOR="nano"
export GOROOT=~/go-1.1.2
export GOPATH=~/gocode
export ELIXIRPATH=~/elixir
export PHANTOMJS_HOME=/home/lazywithclass/phantomjs/bin
export PATH=~/bin:/home/lazywithclass/nave:/usr/local/heroku/bin:$GOROOT/bin:$GOPATH/bin:$ELIXIRPATH/bin:$PHANTOMJS_HOME:$PATH

[ -s "/home/lazywithclass/.scm_breeze/scm_breeze.sh" ] && source "/home/lazywithclass/.scm_breeze/scm_breeze.sh"

setxkbmap -option caps:escape

echo ""
fortune


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
