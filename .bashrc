# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### PATHS ###
# nvim
# export PATH="$PATH:/opt/nvim-linux-arm64/bin"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
export PATH=$PATH:/Users/snowy/.local/bin

# starship
eval "$(starship init bash)"

# ble.sh
source -- ~/.local/share/blesh/ble.sh

export BUN_INSTALL="$HOME/.bun"

# opencode
export PATH=/home/snowy/.opencode/bin:$PATH

# go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin



### ALIASES ###
# .bashrc
alias rc='nvim $HOME/.bashrc'
alias s='source ~/.bashrc'

# home, clear, list
alias h='cd $HOME'
alias c='clear'
alias l='eza -lah'

# opencode
alias ocrc='nvim $HOME/.config/opencode/opencode.json'
alias omorc='nvim $HOME/.config/opencode/oh-my-openagent.json'

# GIT RELATED
alias gs='git rev-parse --git-dir > /dev/null 2>&1 && git status || eza'
alias ga='git add'
alias gaa='git add .'
alias gpo='git push -u origin'
alias gc='git commit -m'
alias gco='git checkout'
alias gmg='git merge'
alias gr='git rebase'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch -D'
alias gcp='git cherry-pick'
alias gd='git diff -w'
alias gu='git reset --soft HEAD~1'
alias gpr='git remote prune origin'
alias ff='gpr && git pull --ff-only'
alias grd='git fetch origin && git rebase origin/main'
alias gbb='git-switchbranch'
# alias gbf='git branch | head -1 | xargs' # top branch?
alias git-current-branch='git branch --show-current'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gpf='git push --force-with-lease'

# NPM RELATED
alias ni='npm install'
alias nrb='npm run build'
alias nrd='npm run dev -- -H 0.0.0.0 -p 3000'
alias nrl='npm run lint'

# tmux
alias tsw='tmux select-window -t'
alias tnw='tmux new-window'
alias tkw='tmux kill-window'


### FUNCTIONS ###
# mkdir & cd
# Usage: mc new_directory
function mc {
    mkdir -p $1
    cd $1
}

# Kills processes using the specified ports
# Usage: kps 3000 8080 9001
kps() {
    # Check if at least one argument (port) is provided
    if [ -z "$1" ]; then
        echo "Error: Please provide at least one port number."
        echo "Usage: kps [port1] [port2] ..."
        return 1
    fi

    # Loop through all provided port numbers
    for port in "$@"; do
        echo "Searching for process on port: $port"

        # lsof -t: Prints only the PID
        # -i :$port: Searches for processes on that port
        PIDS=$(lsof -t -i :"$port")

        if [ -z "$PIDS" ]; then
            echo "No process found on port $port."
        else
            # kill -9: Force kill the process (SIGKILL)
            # This handles multiple PIDs at once if found
            kill -9 $PIDS
            echo "Process(es) on port $port (PID: $PIDS) killed."
        fi
    done
}


export PATH=$PATH:/usr/local/go/bin

. "$HOME/.local/bin/env"


fixperms() {
    # 1. 소유권을 현재 로그인한 사용자로 통일
    # $USER 변수를 사용하여 어떤 환경에서도 본인 계정으로 설정됩니다.
    sudo chown -R $USER:$USER .

    # 2. 모든 디렉토리는 755 (drwxr-xr-x)
    find . -type d -exec chmod 755 {} +

    # 3. 모든 파일은 기본적으로 644 (-rw-r--r--)
    find . -type f -exec chmod 644 {} +

    # 4. 'file' 도구를 사용하여 실행 가능한 파일들만 찾아 +x 부여
    # 파일명이 아닌 실제 내용(바이너리, 스크립트 등)을 검사하므로 정확합니다.
    echo "Detecting and setting executable permissions..."
    find . -type f -exec sh -c '
        case "$(file -b "$1")" in
            *executable*|*script*) exit 0 ;;
            *) exit 1 ;;
        esac
    ' _ {} \; -exec chmod +x {} + -print
}

# k-skill hosted proxy for GJC user skills
export KSKILL_PROXY_BASE_URL="https://law.snowykr.com"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Prefer locally linked development commands over global Bun installs.
export PATH="$HOME/.local/bin:$PATH"

# GJC upstream update
gjcdu() {
    local repo="$HOME/gjc-upstream-dev"

    cd "$repo" || return
    git restore --source=HEAD --staged --worktree . || return
    git switch dev || return
    git pull --ff-only || return
    bun install --frozen-lockfile || return
    bun run build:native || return
    git restore --source=HEAD --staged --worktree packages/natives/native/index.d.ts || return
    bun run dev:link || return
    gjc --smoke-test
}
