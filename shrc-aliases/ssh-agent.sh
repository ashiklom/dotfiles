#!/usr/bin/env bash

SSH_ENV="${HOME}/.ssh/environment"

function start_agent {
  echo "Initializing new SSH agent..."
  rm -f "${SSH_ENV}"
  ssh-agent -s > "${SSH_ENV}"
  echo "Succeeded!"
  source "${SSH_ENV}" 
  ssh-add
}

# Source SSH settings, if available

if [[ -f "${SSH_ENV}"  ]]; then
  pgrep 'ssh-agent' > /dev/null || start_agent
  source "${SSH_ENV}"
else
  start_agent
fi
