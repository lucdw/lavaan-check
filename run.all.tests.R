if (!file.exists("utilities.R")) stop("working directory isn't the main test directory")
options(width = 255L)
source("utilities.R")
group.environment <- new.env()
assign("i", 0L, group.environment)
cat("STARTING TIME:", format(Sys.time()), "\n")
cat("lavaan version of snapshots :", readLines("snapshots/version.txt"), "\n")
cat("current lavaan version :", packageDescription("lavaan", fields = "Version"), "\n")
testfiles <- list.files(pattern = "^test\\..*\\.[rR]$")
for (test.i in seq_along(testfiles)) {
  testfile <- testfiles[test.i]
  source(testfile)
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment, group.environment)
}
max.i <- get("i", group.environment)
reportcon <- file("result.txt", "wt")
for (i in seq_len(max.i)) {
  ich <- formatC(i, width=4, flag="0")
  df1 <- get(paste0("res", ich), group.environment)
  res1 <- get(paste0("log", ich), group.environment)
  cat(paste(res1, collapse="\n"), file=reportcon)
  cat("\n", file = reportcon)
  if (i == 1) {
    resultdf <- df1
  } else {
    resultdf <- rbind(resultdf, df1)
  }
}
close(reportcon)
rm(group.environment)
options(width = 100L)
saveRDS(resultdf, file = "result.rds")
cat("ENDING TIME:", format(Sys.time()), "\n")
cat("Logging of individual tests are in the map 'reports'.\n")
cat("Results are in data.frame resultdf, which is saved in file 'result.rds'.\n")
