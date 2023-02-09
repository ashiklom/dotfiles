#!/usr/bin/env zsh

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

if [[ -f ~/.travis/travis.sh ]]; then
    source /home/ashiklom/.travis/travis.sh
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

if command -v gman > /dev/null ; then
    alias man=gman
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

alias unfreeze='pkill -SIGUSR2 emacs'

EMACS="/Users/ashiklom/Applications/Emacs.app/Contents/MacOS/Emacs"
if [ -f "$EMACS" ]; then
    alias emacs="$EMACS"
fi
unalias rm

if [ -f "$HOME/src/aws-mfa" ]; then
    alias aws-mfa='. ~/src/aws-mfa'
    alias eis-compute-stop='aws ec2 stop-instances --instance-ids i-01372ccb6a8b5a762'
    alias eis-compute-start='aws ec2 start-instances --instance-ids i-01372ccb6a8b5a762'
fi

if [ -f "$HOME/.aws-auth" ]; then
    source "$HOME/.aws-auth"
fi
