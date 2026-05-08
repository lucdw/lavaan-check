if (file.exists("README.md")) setwd("tests")
source("../select_tests.R")
testfiles <- select_tests()
for (test.i in seq_along(testfiles)) {
  testfile <- testfiles[test.i]
  cat("Processing", testfile, "\n")
  system2(paste(R.home(), "bin", "R", sep= "/"), 
    stdin=testfile, 
    stdout=paste0(testfile, "out.save"),
    stderr=paste0(testfile, "out.save"),
    args = "--no-save")
}
