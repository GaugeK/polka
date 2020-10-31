#  ~/etc/sh/zshrc

set -k                     # Allow comments in shell
setopt auto_cd             # cd by just typing the directory name
unsetopt flowcontrol       # Disable Ctrl-S + Ctrl-Q
. "$ZDOTDIR/aliases"       # Aliases
setopt SHwordsplit

# fancy prompts
command_not_found_handler() {
	printf 'not found:\033[38;05;16m %s\033[0m\n' "$0" >&2
	return 127
}

topdir() {
	v=${(%):-%1~}
	printf '\033[7%b%b' \
		"\033[8\033[s\033[0;$((COLUMNS-${#OLDPWD##*/}))H\033[K" \
		"\033[0;$((COLUMNS-${#v}))H${v}\033[u"
}

setopt prompt_subst
PROMPT='%{$(topdir)%}%F{%(?.16.17)} > %f'
export SUDO_PROMPT=$'pass for\033[38;05;16m %u\033[0m '

[ "$TERM" = linux ] &&
	PROMPT=' %1~%F{%(?.4.1)} %(!.|./) %f'

#
#  Keybinds
#

bindkey '^a'       beginning-of-line      # Ctrl-A
bindkey '^e'       end-of-line            # Ctrl-E
bindkey '^[[3~'    delete-char            # Delete
bindkey '^[[1;5C'  forward-word           # Ctrl-RightArrow
bindkey '^[[1;5D'  backward-word          # Ctrl-LeftArrow
bindkey '^[^M'     self-insert-unmeta     # Alt-Return
bindkey '^[[Z'     reverse-menu-complete  # Shift-Tab
bindkey '^r'       history-incremental-search-backward  # Ctrl-E

load() { autoload -U "$1"; zle -N "$1"; bindkey "$2" "$1"; }

# open current command in $EDITOR
load edit-command-line '^f'

# arrow keys search history
load  up-line-or-beginning-search  '^[[A'
load down-line-or-beginning-search '^[[B'

cle() { clear; zle redisplay; }
zle -N cle
bindkey '^l' cle

# git status on ^j
kgs() { clear; git status -sb; zle redisplay; }
zle -N kgs; bindkey ^j kgs

# ls on ^k
kls() { clear; ls -A; zle redisplay; }
zle -N kls; bindkey ^k kls

#
#  History
#

HISTSIZE=999999
SAVEHIST=999999
HISTFILE="${ZDOTDIR:-$HOME}/zsh_history"
setopt histignorespace
setopt extended_history   # Record timestamp of command in HISTFILE
setopt hist_ignore_dups   # Ignore duplicated commands history list
setopt share_history      # Save command history before exiting

#
#  Autocompletion
#

setopt NO_NOMATCH   # disable some globbing
setopt complete_in_word
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list \
	'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -U compinit && compinit -C

# vim: ft=sh
