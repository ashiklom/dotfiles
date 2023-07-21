#!/usr/bin/env zsh

# Uncomment here and at end for profiling startup
# zmodload zsh/zprof

if [[ -f "$HOME/.profile" ]]; then
    source "$HOME/.profile"
fi

MY_DOT_DIR=${MY_DOT_DIR:-$HOME/dotfiles}

# Bootstrap zgenom
if [[ ! -d "$HOME/.zgenom" ]]; then
  git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi

# Load zgenom
source "${HOME}/.zgenom/zgenom.zsh"
zgenom autoupdate

if ! zgenom saved; then

    # zgenom ohmyzsh
    zgenom ohmyzsh plugins/colored-man-pages

    zgenom prezto
    zgenom prezto directory
    zgenom prezto git
    zgenom prezto utility
    zgenom prezto editor key-bindings 'emacs'
    zgenom prezto editor dot-expansion 'yes'
    zgenom prezto prompt theme 'sorin'

    zgenom load zdharma-continuum/fast-syntax-highlighting

    zstyle 'prezto:*:*' color 'yes'

    zgenom save
    # zgenom compile "$HOME/.zshrc"
fi

hascmd() {
  command -v $1 >/dev/null
}

# Add incremental search key
# NOTE: `fzf` (below) will override this if installed
bindkey '^r' history-incremental-search-backward

if hascmd hub; then
    alias git='hub'
fi

alias ghash="git log --pretty=format:'%h' -n 1"
alias ls='ls --color=auto'

# fzf
if [[ -f "$HOME/.fzf.zsh" ]]; then
  source "$HOME/.fzf.zsh"
fi

# Use neovim for vim
if hascmd nvim; then
  alias vim=nvim
  export EDITOR=nvim
fi

if [[ -d "$HOME/Applications/Emacs.app" ]]; then
  alias emacs="$HOME/Applications/Emacs.app/Contents/MacOS/Emacs"
  export PATH="$HOME/Applications/Emacs.app/Contents/MacOS/bin:$PATH":
fi

if [ -f "$HOME/src/aws-mfa" ]; then
    alias aws-mfa='. ~/src/aws-mfa'
    eis() {
        declare -A ec2commands
        ec2commands[status]="describe-instances"
        ec2commands[start]="start-instances"
        ec2commands[stop]="stop-instances"
        COMMAND=${1}
        declare -A eisids
        eisids[compute]="i-01372ccb6a8b5a762"
        eisids[bastion]="i-0d4f1c3769c2426db"
        TARGET=${2}
        aws ec2 "$ec2commands[$COMMAND]" --instance-ids "$eisids[$TARGET]"
    }
fi

if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
  if command -v fd > /dev/null; then
    # FZF_SEARCH="--search-path $HOME --search-path $HOME/.config --search-path $HOME/.local"
    _fzf_compgen_path() {
      fd --hidden --follow --exclude ".git" . "$1"
    }
    _fzf_compgen_dir() {
      fd --type d --hidden --follow --exclude ".git"
    }
    FZF_SEARCH=""
    export FZF_DEFAULT_COMMAND="fd . -t f $FZF_SEARCH"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd -t d . $FZF_SEARCH"
  fi
fi

alias isodate="date +%Y-%m-%d"
alias temperature='sudo powermetrics --samplers smc |grep -i "CPU die temperature"'

NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias maapauth='source -- <(ssh root@35.162.142.31 -p 32034 python -- < ~/projects/eis/aws-auth.py)'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ashiklom/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ashiklom/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/ashiklom/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/ashiklom/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/ashiklom/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/ashiklom/mambaforge/etc/profile.d/mamba.sh"
fi

certs() {
  eval $("/mnt/c/weasel/weasel-pageant-1.4/weasel-pageant" -r)
}

aws-mfa() {
  . ~/.local/src/aws-mfa
}

open() {
  powershell.exe -c start "$1"
}

export BROWSER='powershell.exe -c start "%s"'

MY_SPACKDIR="$HOME/projects/src/spack"
if [ -f "$MY_SPACKDIR/share/spack/setup-env.sh" ]; then
  source "$MY_SPACKDIR/share/spack/setup-env.sh"
fi

# Set up WSL display
export DISPLAY=:0

# zprof
