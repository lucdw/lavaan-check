if (file.exists("README.md")) setwd("tests")
source("../select_tests.R")
testfiles <- select_tests()
extra <- substr(Sys.info()[["sysname"]], 1, 1) # because results depend on OS
for (test.i in seq_along(testfiles)) {
  testfile <- testfiles[test.i]
  cat("Processing", testfile, "\n")
  system2(paste(R.home(), "bin", "R", sep= "/"), 
    stdin=testfile, 
    stdout=paste0(testfile, extra, "out"),
    stderr=paste0(testfile, extra, "out"),
    args = "--no-save")
}
testfiles_cache <- testfiles
source("../all_tests_compare.R", echo = FALSE)
