if [[ -f "$HOME/.profile" ]]; then
    source "$HOME/.profile"
fi

MY_DOT_DIR=${MY_DOT_DIR:-$HOME/dotfiles}

if [[ ! -d "$HOME/.zplug" ]]; then
    git clone https://github.com/zplug/zplug "$HOME/.zplug"
fi

if [[ -f "$HOME/.zplug/init.zsh" ]]; then
    source "$HOME/.zplug/init.zsh"
    zplug "zplug/zplug", hook-build:'zplug --self-manage'

    zplug "zdharma/fast-syntax-highlighting"

    zplug "modules/directory", from:prezto
    zplug "modules/completion", from:prezto
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
alias edit='emacsclient -n -c --alternate-editor vim'
alias ghash="git log --pretty=format:'%h' -n 1"

alias ls='ls -G'

# pecan server setup
if [[ "$(hostname | grep 'pecan')" ]]; then
    source "$MY_DOT_DIR/shrc-aliases/ssh-agent.sh"
fi

# fzf
if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

if [[ -d "$HOME/.cabal/bin" ]]; then
    export PATH=$PATH:$HOME/.cabal/bin
fi

# Local executables
export PATH="$PATH":"${HOME}/.local/bin"

# Local Ruby gems (without sudo)
export GEM_HOME=~/.gem
export PATH="$GEM_HOME/bin:$PATH"

# added by travis gem
[ -f /home/ashiklom/.travis/travis.sh ] && source /home/ashiklom/.travis/travis.sh

if [[ -n $(find /usr/local/Cellar -name r -depth 1) ]]; then
    RHB_DIR=$(find /usr/local/Cellar/r -depth 1)
    alias rhb=${RHB_DIR}/bin/R
    alias Rhbscript=${RHB_DIR}/bin/Rscript
fi
