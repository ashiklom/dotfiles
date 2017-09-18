options(repos=structure(c(CRAN="https://cloud.r-project.org")))

if (interactive()) {
    if (!requireNamespace("colorout", quietly = TRUE)) {
        devtools::install_github("jalvesaq/colorout")    
    }
    if (!requireNamespace("setwidth", quietly = TRUE)) {
        devtools::install_github("cran/setwidth")
    }
    #options(nvimcom.verbose = 1) # To know nvimcom was successfully loaded
    suppressPackageStartupMessages({
        library(colorout)   # Color terminal output
        library(setwidth)   # For automatic update of options('width')
    })
    if (Sys.getenv("VIMRUNTIME") != "") {
        library(nvimcom)
    }
}

# vim: set syntax=r filetype=r:
