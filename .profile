# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

if [ -f /usr/share/terminfo/k/konsole-256color ]; then
    export TERM="konsole-256color"
else
    export TERM="xterm-256color"
fi
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"

export PATH="/usr/local/go/bin:$GOBIN:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
which nvim > /dev/null 2>&1 && export EDITOR=nvim || export EDITOR=vim

IGNOREREF=10

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

`/usr/bin/which /usr/bin/tmux &> /dev/null`; TMUX_EXIST=$?
`/usr/bin/pgrep tmux &> /dev/null`; TMUX_IS_RUNNING=$?

if [ $TMUX_EXIST -eq 0 ] && [ $TMUX_IS_RUNNING -eq 1 ]; then
    echo "Running nohup <stuff>"
    nohup tmux new-session -d -t emil </dev/null > /dev/null 2>&1 &
    echo "Code was $?"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
