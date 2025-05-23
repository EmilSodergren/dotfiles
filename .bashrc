# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

source ~/.bash_git
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# make shell only exit after 10 consecutive Ctrl-D commands
IGNOREEOF=10

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

shopt -s autocd
shopt -s cdspell
shopt -s dirspell
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
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

white="\[\e[37m\]"
green="\[\e[32m\]"
yellow="\[\e[33m\]"
magenta="\[\e[35m\]"
reset="\[\e[0m\]"

if [ "$color_prompt" = yes ]; then
    PS1=$white'${debian_chroot:+($debian_chroot)}\u@\h '$green'(`/bin/ls -1 | /usr/bin/wc -l`)'$reset' '$yellow'\w'$magenta'$(__git_ps1 " (%s)")'$white'\\$ '$reset
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1 " (%s)")\\$ '
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

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more aliases
command -v lsd &> /dev/null && alias ll='lsd -lh' || alias ll='ls -lh'
command -v lsd &> /dev/null && alias tree='lsd --tree'
command -v bat &> /dev/null && alias cat='bat'
alias clock='date'
alias g='git'
alias k='kubectl'
alias 9g='9lvgit'
alias notes='nvim -c MarkdownPreview ~/Documents/notes.md'
alias vimdiff='nvim -d'
# alias cd='echo "!cd is for noobs!" && sleep 2 && cd'
#alias grep='rg'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

complete -cf sudo

export TERM=screen-256color
export MYVIMRC="$HOME/.config/nvim/init.lua"
export EDITOR=nvim
export SUDO_ASKPASS=/usr/bin/ssh-askpass
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
export WS_BOOTSTRAP_NO_SAVE=1
[ -f ~/.kube/k3s.yaml ] && export KUBECONFIG=~/.kube/k3s.yaml

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
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

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init bash)"
fi

eval "command -v tmux" &> /dev/null; TMUX_EXIST=$?
eval "/usr/bin/pgrep tmux" &> /dev/null; TMUX_IS_RUNNING=$?
eval "command -v kubectl" &> /dev/null; KUBECTL_EXIST=$?
eval "command -v helm" &> /dev/null; HELM_EXIST=$?
eval "command -v golangci-lint" &> /dev/null; GOLANGCI_LINT_EXIST=$?

if [ $TMUX_EXIST -eq 0 ] &&  [ -z "$WORKSPACE" ]; then
  if [ $TMUX_IS_RUNNING -eq 1 ];  then
    echo "Starting tmux server"
    nohup tmux -2 new-session -d -t emil </dev/null &> /dev/null &
    sleep 3
  fi
  [ -z "$TMUX" ] && tmux attach
fi

[ $KUBECTL_EXIST -eq 0 ] && . <(kubectl completion bash)
[ $HELM_EXIST -eq 0 ] && . <(helm completion bash)
[ $GOLANGCI_LINT_EXIST -eq 0 ] && . <(golangci-lint completion bash)

[ -f ~/qmk_firmware/util/qmk_tab_complete.sh ] && source ~/qmk_firmware/util/qmk_tab_complete.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. "$HOME/.cargo/env"
