export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'
export GREP_OPTIONS='--color=auto'

bindkey -e
bindkey "^[[Z" reverse-menu-complete
bindkey '^[^B' vi-backward-blank-word
bindkey '^[^F' vi-forward-blank-word
bindkey '^[^U' backward-delete-word
bindkey '^[^K' delete-word

case "${OSTYPE}" in
darwin*)
  alias ls="ls -G"
  alias ll="ls -lG"
  alias la="ls -laG"
  ;;
linux*)
  alias ls='ls --color'
  alias ll='ls -l --color'
  alias la='ls -la --color'
  ;;
esac
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias fuck='eval $(thefuck $(fc -ln -1))'

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
HIST_STAMPS="mm/dd/yyyy"

setopt correct
setopt auto_list
setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_menu
setopt list_types
setopt list_packed
setopt print_eight_bit
setopt interactive_comments
setopt autocd
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt extended_glob

autoload -Uz select-word-style
autoload -Uz compinit
compinit
autoload -Uz colors
colors

zstyle ':completion:*:default' menu select=2
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                     /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey '^]' insert-last-word

source ~/.zplug/init.zsh
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "b4b4r07/enhancd", use:init.sh
if ! zplug check; then
    zplug install
fi
zplug load

function history-fzf() {
  export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
  local tac

  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi

  BUFFER=$(history -n 1 | eval $tac | fzf --query "$LBUFFER")
  CURSOR=$#BUFFER

  zle reset-prompt
}
zle -N history-fzf
bindkey '^r' history-fzf

function cd()
{
    builtin cd $@ && ls -la;
}
