if (!file.exists("utilities.R")) stop("working directory isn't the main test directory")
source("utilities.R")
cat("STARTING TIME:", format(Sys.time()), "\n")
if (dir.exists("snapshots")) unlink("snapshots", recursive = TRUE)
if (dir.exists("reports")) unlink("reports", recursive = TRUE)
dir.create("snapshots")
dir.create("reports")
writeLines(packageDescription("lavaan", fields = "Version"), "snapshots/version.txt")
testfiles <- list.files("tests", pattern = "\\.[rR]$")
options(warn = 1, width = 255L)
group.environment <- new.env() # used as switch in individual test files
for (test.i in seq_along(testfiles)) {
  testfile <- paste0("tests/", testfiles[test.i])
  source(testfile)
  execute_test(test.id, lavaan.model, lavaan.call, 
    lavaan.args, reports, test.comment, exec.mode = 1L)
}
rm(group.environment)
options(warn = 0, width = 100L)
