export EDITOR=vim
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PATH:$PYENV_ROOT/bin
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export GOROOT=/usr/local/go
export PATH=$GOROOT/bin:$PATH
export GOPATH=$HOME/.go
export PATH=$GOPATH/bin:$PATH
export GCLOUD=$HOME/google-cloud-sdk/
export PATH=$GCLOUD/bin:$PATH

bindkey -e
bindkey '^y' forward-word
bindkey '^t' backward-word

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
alias brew="env PATH=${PATH/${HOME}\/\.pyenv\/shims:/} brew"

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
select-word-style default
autoload -Uz compinit
compinit
autoload -Uz colors
colors

zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
zstyle ':completion:*:default' menu select=2
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
if ! zplug check; then
    zplug install
fi
zplug load

PROMPT='%(?.%F{green}.%F{red})${PURE_PROMPT_SYMBOL:-❯}%f '
RPROMPT='%F{242}[%D %*]'
[[ "$SSH_CONNECTION" != '' ]] && prompt_pure_username='%F{magenta}%n%f %F{white}%M%f'
[[ $UID -eq 0 ]] && prompt_pure_username='%F{magenta}%n%f %F{white}%M%f'

function history-fzf() {
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

function search-fzf() {
  local filepath="$(find . | grep -v '.git*'| fzf)"

  zle reset-prompt
  [ -z "$filepath" ] && return
  if [ -n "$LBUFFER" ]; then
    BUFFEr="$LBUFFER$filepath"
  else
    if [ -d "$filepath" ]; then
      BUFFER="cd $filepath"
    elif [ -f "$filepath" ]; then
      BUFFER="$EDITOR $filepath"
    fi
  fi
  CURSOR=$#BUFFER
}
zle -N search-fzf
bindkey '^o' search-fzf

function find-fzf() {
  local filepath="$(ag . -i --hidden | fzf)"

  zle reset-prompt
  [ -z "$filepath" ] && return
  if [ -n "$LBUFFER" ]; then
    BUFFEr="$LBUFFER$filepath"
  else
    if [ -d "$filepath" ]; then
      BUFFER="cd $filepath"
    elif [ -f "$filepath" ]; then
      BUFFER="$EDITOR $filepath"
    fi
  fi
  CURSOR=$#BUFFER
}
zle -N find-fzf
bindkey '^_' find-fzf

function cd()
{
    builtin cd $@ && ls -la;
}

function ssh() {
  if [[ -n $(printenv TMUX) ]]
  then
    local window_name=$(tmux display -p '#{window_name}')
    tmux rename-window -- "$@[-1]" # zsh specified
    # tmux rename-window -- "${!#}" # for bash
    command ssh $@
    tmux rename-window $window_name
  else
    command ssh $@
  fi
}
