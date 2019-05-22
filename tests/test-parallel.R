m <- cov(subset(iris, select = -Species))

f <- function(m) solve(m)

library(parallel)
ncores <- detectCores()
cl_psock <- makePSOCKcluster(ncores)
cl_fork <-  makeForkCluster(ncores)
ml <- rep(list(m), ncores)

message("Using parLapply psock...")
out_psock <- parLapply(cl_psock, ml, f)
message("Using parLapply fork...")
out_psock <- parLapply(cl_fork, ml, f)
message("Using mclapply...")
out_mclapply <- mclapply(ml, f)
message("Done!")
