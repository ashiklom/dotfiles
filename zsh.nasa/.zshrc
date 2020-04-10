#!/usr/bin/env zsh

alias pivssh='ssh -A -o PKCS11Provider=/usr/lib/ssh-keychain.dylib'

if [[ -f "$HOME/.profile" ]]; then
    source "$HOME/.profile"
fi

alias pivssh='ssh -A -o PKCS11Provider=/usr/lib/ssh-keychain.dylib'

MY_DOT_DIR=${MY_DOT_DIR:-$HOME/dotfiles}

if [[ ! -d "$HOME/.zplug" ]]; then
    git clone https://github.com/zplug/zplug "$HOME/.zplug"
fi

if [[ -f "$HOME/.zplug/init.zsh" ]]; then
    source "$HOME/.zplug/init.zsh"

    zplug "zplug/zplug", hook-build:'zplug --self-manage'

    zplug "zdharma/fast-syntax-highlighting"

    zplug "modules/directory", from:prezto
    # zplug "modules/completion", from:prezto
    zplug "modules/git", from:prezto
    zplug "modules/utility", from:prezto
    zplug "zuxfoucault/colored-man-pages_mod"
    zplug "modules/prompt", from:prezto

    # Use a simpler configuration for Emacs
    if [[ -z "${EMACS}" ]]; then
        zstyle 'prezto:*:*' color 'yes'
        zstyle ':prezto:module:prompt' theme 'sorin'

        zplug "modules/editor", from:prezto
        zstyle ':prezto:module:editor' key-bindings 'vi'
        zstyle ':prezto:module:editor' dot-expansion 'yes'
    else
        zstyle ':prezto:module:prompt' theme 'suse'
    fi

    # Autostart tmux
    #zplug "modules/tmux", from:prezto
    #zstyle ':prezto:module:tmux:auto-start' local 'yes'

    zplug check || zplug install
    zplug load
fi

# Add incremental search key
# NOTE: `fzf` (below) will override this if installed
bindkey '^r' history-incremental-search-backward

if (hub --version &> /dev/null); then
    alias git='hub'
fi

# source "$MY_DOT_DIR/shrc-aliases/pbcopy.sh"
alias ghash="git log --pretty=format:'%h' -n 1"

alias ls='ls -G'

# pecan server setup
if [[ "$(hostname | grep 'pecan')" ]]; then
    source "$MY_DOT_DIR/shrc-aliases/ssh-agent.sh"
fi

# fzf
if [[ -f $HOME/.fzf.zsh ]]; then
    source $HOME/.fzf.zsh
fi

if [[ -d "$HOME/.cabal/bin" ]]; then
    export PATH=$PATH:$HOME/.cabal/bin
fi

# Local executables
PATH="$PATH":"${HOME}/.local/bin"

# Local Ruby gems (without sudo)
GEM_HOME=~/.gem
if [[ -f $GEM_HOME ]]; then
    export PATH="$GEM_HOME/bin:$PATH"
    export GEM_HOME
fi

# `rt` package -- Command-line utils for R
RT_PATH=~/R/rt/bin
if [[ -f $RT_PATH/rupdate ]]; then
    export PATH=$PATH:$RT_PATH
    alias rtdoc=$RT_PATH/rdoc
    export RT_PATH
fi

if [[ -f ~/.travis/travis.sh ]]; then
    source /home/ashiklom/.travis/travis.sh
fi

# Local Python packages
# Prefer Python 3.7, but add 2.7 as well
export PYTHON_ROOT="${HOME}/Library/Python"
export PATH="$PATH:${PYTHON_ROOT}/3.7/bin:${PYTHON_ROOT}/2.7/bin:"

# Doom emacs
DOOMPATH=~/.emacs.d/bin
if [[ -d $DOOMPATH ]]; then
    export PATH=$PATH:$DOOMPATH
fi

# Add Python local package paths (Python 3 preferred)
# PYTHON3="$HOME/Library/Python/3.7/bin"
# if [[ -d "$PYTHON3" ]]; then
#     export PATH=$PATH:"$PYTHON3"
# fi

# PYTHON2="$HOME/Library/Python/2.7/bin"
# if [[ -d "$PYTHON2" ]]; then
#     export PATH=$PATH:"$PYTHON2"
# fi

# Use neovim for vim
if command -v nvim >/dev/null; then
    alias vim=nvim
fi

if [[ -d "$HOME/.emacs.d/bin" ]]; then
    export PATH=$PATH:~/.emacs.d/bin
fi

if ! command -v emacs >/dev/null ; then
    export PATH=$PATH:~/Applications/Emacs.app/Contents/MacOS:~/Applications/Emacs.app/Contents/MacOS/bin
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ashiklom/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ashiklom/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ashiklom/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ashiklom/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# De-activate conda by default
conda deactivate

# Allow pyvenv to access conda environments
export WORKON_HOME="/Users/ashiklom/opt/anaconda3/envs/"
