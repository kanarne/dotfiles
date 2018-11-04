export LANG=ja_JP.UTF-8
export EDITOR=vim
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'
export GREP_OPTIONS='--color=auto'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PATH:$PYENV_ROOT/bin
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

bindkey -e
bindkey "^[u" undo
bindkey "^[r" redo
bindkey "^[[Z" reverse-menu-complete

eval "$(pyenv init -)"

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
HIST_STAMPS="mm/dd/yyyy"

autoload -Uz compinit
compinit

autoload -Uz select-word-style
select-word-style default
autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

setopt correct
setopt auto_list
setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_menu
setopt list_types
setopt list_packed
setopt print_eight_bit
setopt interactive_comments
setopt auto_cd
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt share_history
setopt extended_history
setopt extended_glob
setopt no_flow_control
setopt no_beep

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ls='ls -G'
alias la='ls -a'
alias ll='ls -la'
alias g='git'
alias fuck='eval $(thefuck $(fc -ln -1))'

TERM=xterm-256color
[ -f ~/.zsh_prompt ] && source ${HOME}/.zsh_prompt

PATH=~/.zsh/bin:~/.zsh/bin/`uname`:$PATH

[ -f ~/.zsh/fzf-key-bindings.zsh ] && source ~/.zsh/fzf-key-bindings.zsh
[ -f ~/.zsh/fzf-completion.zsh ] && source ~/.zsh/fzf-completion.zsh
