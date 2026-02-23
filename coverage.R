stopifnot(require("covr"), require("DT"), require("htmltools"))
rat <- readLines("run.all.tests.R")
cover <- covr::package_coverage("../../Rpackages/lavaan", type="none", code = rat)
covr::report(x = cover, file = "lavaan-check.html")
