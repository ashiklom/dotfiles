#
# default .bashrc
# 03/31/13
#
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export TERM='xterm-256color'

# Use local modules
#export MODULEPATH=${HOME}/privatemodules:${MODULEPATH}
 
umask 022

# disable coredumps by default
ulimit -c 0

# User specific aliases and functions
#alias rm='rm -i'

# Load modules from
#MODULEFILE=${HOME}/.modules
#if [ -e $MODULEFILE ]; then
    #while read mod; do
        #module load $mod
    #done < $MODULEFILE
#else
    #echo "Module file ${MODULEFILE} not found"
#fi

alias lqstat='qstat -u ashiklom | less'
alias wqstat='watch "qstat -u ashiklom"'
alias ls='ls --color=auto'

# Git bash autocompletion
source ~/dietzelab/.src/git-completion.bash

export PATH=${HOME}/.singularity:${PATH}:${HOME}/dietzelab/.local/bin
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}

# R aliases
rdoc() {
    pth=${1:-.}
    Rscript -e "devtools::document('"$pth"')"
}

rinst() {
    pth=${1:-.}
    Rscript -e "devtools::install('"$pth"')"
}

rtest() {
    pth=${1:-.}
    Rscript -e "devtools::test('"$pth"')"
}

rdbt() {
    pth=${1:-.}
    rdoc $pth
    rinst $pth
    rtest $pth
}

linediff() {
    diff --new-line-format='' --unchanged-line-format='' <(sort $1) <(sort $2)
}

alias singularity='/share/singularity/utils/scc-singularity'
alias centos7='singularity exec /share/singularity/images/scc-centos7.img'
alias qlogmem='qlogin -l mem_total=94G'
alias qlogcpu='qlogin -l cpu_arch=ivybridge'
