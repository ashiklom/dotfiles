#! /bin/bash
shopt -s extglob

ln -rs urxvt-perls/!([[:upper:]]*) /usr/lib/urxvt/perl
