# Auto-install zplug
if [[ ! -d ~/.zplug ]]; then
  echo '[zhrc] Installing zplug...'
  git clone https://github.com/zplug/zplug ~/.zplug
fi

# Load zplug and register plugins
if [[ -f ~/.zplug/init.zsh ]]; then

  source ~/.zplug/init.zsh
  zplug 'zplug/zplug'

  zplug 'zsh-users/zsh-syntax-highlighting'

  zplug 'modules/editor', from:prezto
  zstyle ':prezto:module:editor' key-bindings 'vi'
  zstyle ':prezto:module:editor' dot-expansion 'yes'

  zplug 'modules/directory', from:prezto
  zplug 'modules/completion', from:prezto
  zplug 'modules/git', from:prezto
  zplug 'modules/utility', from:prezto
  zplug 'modules/prompt', from:prezto
  zstyle ':prezto:module:prompt' theme 'sorin'

  # Source plugins and add to path
  zplug check || zplug install
  zplug load

fi

unalias rm
alias ls='ls --color=auto'
alias vim='nvim'
alias git='hub'
alias open='xdg-open'

export PATH=$PATH:$HOME/.local/bin

source $HOME/dotfiles/shrc-aliases/pbcopy.sh
source $HOME/dotfiles/shrc-aliases/rfunctions.sh
