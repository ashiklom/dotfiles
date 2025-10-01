#!/usr/bin/sh

alias ghash="git log --pretty=format:'%h' -n 1"
alias ls='ls --color=auto'
alias isodate="date +%Y-%m-%d"

alias vnv="source .venv/bin/activate"

if alias pivssh &> /dev/null; then
  unalias pivssh
fi

pivssh() {
  # Remove existing keys (if present)
  ssh-add -L | grep 'PIV\|Digital Signature' | ssh-add -d -
  # ...and then refresh the input
  ssh-add -s /usr/lib/ssh-keychain.dylib
}

awsprof() {
  if ! command -v aws-sso-profile >/dev/null; then
    echo "aws-sso-profile command not found"
    return 1
  fi
  if [[ "$#" -eq 0 ]]; then
    echo "AWS_SSO_PROFILE=$AWS_SSO_PROFILE"
    return 0
  fi
  if [[ "$1" = "-d" ]]; then
    echo "Clearing AWS_PROFILE"
    aws-sso-clear 
    return 0
  fi
  PROF="smdc-aws-"${1}":Project-Admin"
  echo "Setting profile: $PROF"
  aws-sso-profile "$PROF"
}

azsubid() {
  export ARM_SUBSCRIPTION_ID=$(az account list --query '[?isDefault].id' --output tsv)
}

azlogin() {
  az login -t smce.nasa.gov
  azsubid
}

apache() {
  LICENSEFILE="$HOME/.cache/apache_2_0"
  if [[ ! -f $LICENSEFILE ]]; then
    echo "$LICENSEFILE not found in cache. Downloading..."
    curl -L https://www.apache.org/licenses/LICENSE-2.0.txt -o $LICENSEFILE
  fi
  cp $LICENSEFILE ${1:-LICENSE}
}

ghostic() {
  infocmp -x xterm-ghostty | ssh "$@" -- tic -x -
}
