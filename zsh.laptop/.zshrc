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

    zplug "modules/editor", from:prezto
    zplug "modules/directory", from:prezto
    zplug "modules/completion", from:prezto
    zplug "modules/git", from:prezto
    zplug "modules/utility", from:prezto
    zplug "modules/prompt", from:prezto
    #zplug "modules/tmux", from:prezto
    zplug "zuxfoucault/colored-man-pages_mod"

    zstyle 'prezto:*:*' color 'yes'
    zstyle ':prezto:module:editor' key-bindings 'vi'
    zstyle ':prezto:module:editor' dot-expansion 'yes'
    zstyle ':prezto:module:prompt' theme 'sorin'

    # Autostart tmux
    #zstyle ':prezto:module:tmux:auto-start' local 'yes'

    zplug check || zplug install
    zplug load
fi

source "$MY_DOT_DIR/sh.common/common"

export VISUAL=${VISUAL:-nvim}
alias vim='nvim'

if (hub --version &> /dev/null); then
    alias git='hub'
fi

if (exa --version &> /dev/null); then
    alias ls='exa'
fi

source "$MY_DOT_DIR/shrc-aliases/pbcopy.sh"

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

#if [[ -z "$TMUX" ]] && [[ "$TERM" != "linux" ]]; then
    #tmux new-session
#fi

# added by travis gem
[ -f /home/ashiklom/.travis/travis.sh ] && source /home/ashiklom/.travis/travis.sh
# PEcAn VM-specific settings
#

if [ $(hostname) = 'pecan.vm' ]; then
    setopt complete_aliases
    export PATH=$PATH:/snap/bin/
fi
