if (!file.exists("utilities.R")) stop("working directory isn't the main test directory")
source("utilities.R")
group.environment <- -1 # indicate execute_test function that it only should create snapshots
cat("STARTING TIME:", format(Sys.time()), "\n")
if (dir.exists("snapshots")) unlink("snapshots", recursive = TRUE)
if (dir.exists("reports")) unlink("reports", recursive = TRUE)
dir.create("snapshots")
dir.create("reports")
writeLines(packageDescription("lavaan", fields = "Version"), "snapshots/version.txt")
testfiles <- list.files(pattern = "^test\\.[^.]*\\.R$")
for (test.i in seq_along(testfiles)) {
  testfile <- testfiles[test.i]
  source(testfile)
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment, group.environment)
}
rm(group.environment)
