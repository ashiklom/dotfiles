#!/bin/bash

# Disable tap to click
synclient MaxTapTime=0 &
nm-applet &
#wicd-client -t &
dropbox start

