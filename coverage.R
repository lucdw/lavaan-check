rat <- readLines("run.all.tests.r")
cover <- covr::package_coverage("../../Rpackages/lavaan", type="none", code = rat)
covr::report(x = cover, file = "lavaan-check.html")
