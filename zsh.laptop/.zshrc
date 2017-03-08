if [[ -f "$HOME/.profile" ]]; then
    source "$HOME/.profile"
fi

MY_DOT_DIR=${MY_DOT_DIR:-$HOME/dotfiles}

if [[ ! -d "$HOME/.zplug" ]]; then
    git clone https://github.com/zplug/zplug "$HOME/.zplug"
fi

if [[ -f "$HOME/.zplug/init.zsh" ]]; then
    source "$HOME/.zplug/init.zsh"

    zplug "zsh-users/zsh-syntax-highlighting"

    zplug "modules/editor", from:prezto
    zplug "modules/directory", from:prezto
    zplug "modules/completion", from:prezto
    zplug "modules/git", from:prezto
    zplug "modules/utility", from:prezto
    zplug "modules/prompt", from:prezto
    zplug "plugins/colored-man-pages", from:oh-my-zsh

    zstyle 'prezto:*:*' color 'yes'
    zstyle ':prezto:module:editor' key-bindings 'vi'
    zstyle ':prezto:module:editor' dot-expansion 'yes'
    zstyle ':prezto:module:prompt' theme 'sorin'

    zplug check || zplug install
    zplug load
fi

source "$MY_DOT_DIR/sh.common/common"

alias vim='nvim'
alias git='hub'

source "$MY_DOT_DIR/shrc-aliases/pbcopy.sh"
source "$MY_DOT_DIR/shrc-aliases/rfunctions.sh"
source "$MY_DOT_DIR/shrc-aliases/xfce-setup"
