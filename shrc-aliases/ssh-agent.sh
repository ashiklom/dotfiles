#!/usr/bin/env bash

# Restart SSH agent if not already running
pgrep 'ssh-agent' > /dev/null || eval `ssh-agent -s`
