#!/usr/bin/sh

alias ghash="git log --pretty=format:'%h' -n 1"
alias ls='ls --color=auto'
alias isodate="date +%Y-%m-%d"

alias vnv="source .venv/bin/activate"

M21C_ID="i-0e32163ee5438c0fb"
m21c_off() {
  aws ec2 stop-instances --instance-ids $M21C_ID --no-cli-pager
}

m21c_on() {
  aws ec2 start-instances --instance-ids $M21C_ID --no-cli-pager
}

m21c_status() {
  aws ec2 describe-instances --instance-ids $M21C_ID --query 'Reservations[].Instances[].[State.Name,PublicIpAddress]' --output table --no-cli-pager
}
