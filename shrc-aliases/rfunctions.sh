#!/bin/bash

# R aliases
rdoc() {
  local pth=${1:-.}
  Rscript -e "devtools::document('$pth')"
}

rinst() {
  local pth=${1:-.}
  Rscript -e "devtools::install('$pth')"
}

rtest() {
  local pth=${1:-.}
  Rscript -e "devtools::test('$pth')"
}

rdbt() {
  local pth=${1:-.}
  rdoc $pth
  rinst $pth
  rtest $pth
}

rpkg() {
  local pth=${1:-.}
  Rscript -e "devtools::create('$pth', rstudio = FALSE)"
}

rupdate() {
    Rscript -e "update.packages(ask = FALSE)"
}

rpinst() {
    local pkg=$1
    if [ -z "$pkg" ]; then
        echo "No package provided"
        return 0
    fi
    Rscript -e "install.packages('$pkg')"
}

rrcpp() {
    local pkg=$1
    Rscript -e "Rcpp::compileAttributes('$pth')"
}

rclean() {
    local pkg=$1
    Rscript -e "devtools::clean_dll('$pth')"
}
