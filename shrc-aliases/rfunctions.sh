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
