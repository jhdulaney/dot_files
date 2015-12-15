# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# MPD daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd

stty -ixon

BYOBUPID=$(pgrep tmux)
if [[ -z "$BYOBUPID" ]]; then
    byobu-tmux new-session -d -n Music ncmpcpp
    # byobu-tmux new-window -d -t 0 -n Music ncmpcpp
    byobu-tmux new-window -d -t 1 -n a /home/jdulaney/.tt
    byobu-tmux new-window -d -t 2 -n b
    byobu-tmux new-window -d -t 3 -n c
fi
unset BYOBUPID

EMACSPID=$(pgrep emacs)
if [[ -z "$EMACSPID" ]]; then
    emacs --daemon
fi
unset EMACSPID

alias uzbl='uzbl-tabbed'
alias vi='emacsclient -nw'
alias music='ncmpcpp'

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
[ -r /home/jdulaney/.byobu/prompt ] && . /home/jdulaney/.byobu/prompt   #byobu-prompt#

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus


