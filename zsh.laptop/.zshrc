if [[ -f "$HOME/.profile" ]]; then
    source "$HOME/.profile"
fi

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

    zstyle ':prezto:module:editor' key-bindings 'vi'
    zstyle ':prezto:module:editor' dot-expansion 'yes'
    zstyle ':prezto:module:prompt' theme 'sorin'

    zplug check || zplug install
    zplug load
fi

unalias rm 2>/dev/null
alias ls='ls --color=auto'
alias vim='nvim'
alias git='hub'
export PATH=$PATH:$HOME/.local/bin

source "$HOME/dotfiles/shrc-aliases/pbcopy.sh"
source "$HOME/dotfiles/shrc-aliases/rfunctions.sh"
