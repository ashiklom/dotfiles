#!/usr/bin/env zsh

# Uncomment here and at end for profiling startup
# zmodload zsh/zprof

if [[ -f "$HOME/.profile" ]]; then
    source "$HOME/.profile"
fi

# Bootstrap zgenom
if [[ ! -d "$HOME/.zgenom" ]]; then
  git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi

# Load zgenom
source "${HOME}/.zgenom/zgenom.zsh"
# zgenom autoupdate

if ! zgenom saved; then

    zgenom ohmyzsh
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

# fzf
if [[ -f "$HOME/.fzf.zsh" ]]; then
  source "$HOME/.fzf.zsh"
fi

# Use neovim for vim
if hascmd nvim; then
  export EDITOR=nvim
fi

if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
  if hascmd fd; then
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

if [ -f "$HOME/.local/src/aws-mfa" ]; then
  aws-mfa() {
    . "$HOME/.local/src/aws-mfa"
  }
fi

NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

MY_SPACKDIR="$HOME/projects/src/spack"
if [ -f "$MY_SPACKDIR/share/spack/setup-env.sh" ]; then
  source "$MY_SPACKDIR/share/spack/setup-env.sh"
fi

[ -f "$HOME/.bash_aliases" ] && \. "$HOME/.bash_aliases"
[ -f "$HOME/.zsh_windows" ] && \. "$HOME/.zsh_windows"

# zprof

if [ -d "$HOME/.pixi/bin" ]; then
  export PATH=$PATH:$HOME/.pixi/bin
fi

[ -f "$HOME/.cargo/env" ] && \. "$HOME/.cargo/env"
