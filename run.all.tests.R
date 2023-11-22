if (!file.exists("utilities.R")) stop("working directory isn't the main test directory")
ownrep <- "own_reports.R"
source("utilities.R")
if (file.exists(ownrep)) source(ownrep) # global own reports
group.environment <- new.env()
assign("i", 0L, group.environment)
cat("STARTING TIME:", format(Sys.time()), "\n")
if (!dir.exists("snapshots")) dir.create("snapshots")
testfiles <- list.files(pattern = "^test\\.[^.]*\\.R$")
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
  if (i == 1) {
    df <- df1
  } else {
    df <- rbind(df, df1)
  }
}
close(reportcon)
rm(group.environment)
saveRDS(df, file = "result.rds")
cat("Logging of tests are in result.txt\n")
cat("Data.frame with overview (variable df) is saved in result.rds\n")
cat("ENDING TIME:", format(Sys.time()), "\n")