if (file.exists("README.md")) setwd("tests")
extra <- substr(Sys.info()[["sysname"]], 1, 1) # because results depend on OS
filenames <- list.files(pattern=paste0("\\.R", extra, "out$"))
if (length(filenames) < 10L) stop(".Rxout files not present")
file.remove(list.files(pattern=paste0("\\.R", extra, "out\\.save$")))
filenamesnew <- paste0(filenames, ".save")
file.rename(filenames, filenamesnew)