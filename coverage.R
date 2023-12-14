setwd("C:/GitHub/lavaan-check")
rat <- readLines("run.all.tests.R")
cover <- covr::package_coverage("C:/GitHub/lavaan", type="none", code = rat)
covr::report(x = cover, file = "c:/temp/lavaan-check.html")
