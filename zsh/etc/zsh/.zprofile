#
#   zprofile
#

export BLAZE_DIR="$HOME/opt/x/recs"

export XDG_CONFIG_HOME="$HOME/etc"
export XDG_CACHE_HOME="$HOME/usr/cache"
export XDG_DATA_HOME="$HOME/usr"
export XDG_CRAP_DIR="$HOME/opt"

export XAUTHORITY="/run/user/$UID/.Xauthority"
export LEESSHISTFILE="/dev/null"

export EDITOR="nvim"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-~/.config}/gtk-2.0/gtkrc-2.0"
export FZF_DEFAULT_OPTS="--height='50%' --layout='reverse-list' --color='16'"

# colours lol
export LS_COLORS="di=35:ln=36:pi=42:ex=33:tw=0:ow=0:st=0:*.md=31:*.css=32:*.tar=31:*.gz=31:*.xz=31:*.zip=31:*.mp4=34:*.webm=34:*.png=36:"

# make binaries in ~/bin/* be runnable without ./
export PATH="$(find ~/bin/ -type d | sed 's|/$||'| tr '\n' ':')$PATH"

# less/man colors
export LESS=-R
export LESS_TERMCAP_md=$'\033[1;34m'       # begin blink
export LESS_TERMCAP_{me,ue}=$'\033[0m'     # reset bold/blink and underline
export LESS_TERMCAP_us=$'\033[1;35m'       # begin underline

shortcuts

# subshell is to hide the info about the fork to the background
( sudo /usr/bin/kbdrate -d 200 -r 60 &>/dev/null & )
