if (file.exists("README.md")) setwd("tests")
source("../select_tests.R")
testfiles <- select_tests()
extra <- substr(Sys.info()[["sysname"]], 1, 1) # because results depend on OS
mccores <- if(extra == "W") 1L else 3L
test1 <- function(testfile) {
  starttime <- format(Sys.time(), "%X")
  system2(paste(R.home(), "bin", "R", sep= "/"), 
    stdin=testfile, 
    stdout=paste0(testfile, extra, "out"),
    stderr=paste0(testfile, extra, "out"),
    args = "--no-save")
  paste(starttime, "=>", format(Sys.time(), "%X"), testfile)
}
resultaat <- parallel::mclapply(testfiles, test1, mc.cores = mccores)
cat(paste(resultaat, collapse = "\n"))
cat("\n\n")
testfiles_cache <- testfiles
source("../all_tests_compare.R", echo = FALSE)
