options(
  repos = structure(c(CRAN = "https://cloud.r-project.org"))
)

.width <- function(w = Sys.getenv("COLUMNS"), verbose = TRUE) {
  options(width = as.integer(w))
  if (verbose) {
    message("Setting console width to ", getOption("width"))
  }
}

if (interactive()) {
    if (!requireNamespace("colorout", quietly = TRUE)) {
        devtools::install_github("jalvesaq/colorout")
    }
    #options(nvimcom.verbose = 1) # To know nvimcom was successfully loaded
    suppressPackageStartupMessages({
        library(colorout)   # Color terminal output
    })
    if (Sys.getenv("VIMRUNTIME") != "") {
        library(nvimcom)
    }
}

# vim: set syntax=r filetype=r:
