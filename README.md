# lavaan-check

this project is intended to compare the results of fitting models in lavaan with the results of previous runs

There is one main procedure, run.all.tests.R which performs all tests defined in the R-files test.\*.R.

The test files are as indicated in the example:

```         
test.id <- "HS_cov_multiple"
lavaan.model <- '
  visual  =~ x1 + x2 + x3
  textual =~ x4 + x5 + x6
  speed   =~ x7 + x8 + x9
'
lavaan.call <-  "cfa" 
D1 <- subset(HolzingerSwineford1939, school=="Pasteur")[,7:15]
D2 <- subset(HolzingerSwineford1939, school=="Grant-White")[,7:15]
S.Pasteur <- cov(D1)
S.GrantWhite <- cov(D2)
M.Pasteur <- apply(D1, 2, mean)
M.GrantWhite <- apply(D2, 2, mean)
lavaan.args <- list(
  sample.cov=list(Pasteur=S.Pasteur, `Grant-White`=S.GrantWhite),
  sample.mean=list(M.Pasteur, M.GrantWhite),
  sample.nobs=c(156, 145), 
  meanstructure=TRUE
  )
reports <- list(
  fitmeasures = list(rep.call = "fitMeasures", rep.args = list(), rep.tol.abs = 0.001),
  parm.est = list(rep.call = "parameterEstimates", rep.args = list(ci = FALSE), rep.ignore = NULL)
)
test.comment <- '# 2b of TESTSUITE / Misc'
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
```

The following values are set:

-   test.id : the identifying name of the test, this must be exactly the same as in the filename between "test." and ".R"

-   lavaan.model : the model to use in lavaan

-   lavaan.call : the model type to use in lavaan (sem, cfa, growth, ...)

-   lavaan.args : the parameters to specify for the call (except model), data is given as a data.frame or the name of an RDS-file containing the data.frame

-   reports : a list of reports based on the fitted model, whose output will be compared to the output of previous runs:

    -   rep.call : name of the function to call to create the report, this can be an self-written function present in "own_reports.R"

    -   rep.args : arguments for the call (the argument 'object' is automatically set to the result of the lavaan call)

    -   rep.ignore : character, lines with these strings will be ignored for comparison (overwritten in the report)

    -   rep.tol.abs : numeric, absolute value of tolerance

    -   rep.tol.rel : numeric, relative tolerance level

-   test.comment : optional comment on the test, which will also be copied in the logging

The following lines execute the test if the file is sourced directly (not as a result of sourcing run.all.tests.r, where this is done in the 'calling' script).

When rep.tol.abs or rep.tol.rel is specified the report must produce a named numeric output, which will be compared numerically with the output of a previous run. If the value rep.tol.rel is given the tolerance used is $rep.tol.rel \times abs(oldvalue + newvalue) / 2$. When none of these tolerances are specified the output of the report is printed to a file and the resulting report is compared textually to the old text, possibly ignoring lines containing one of the strings in $rep.ignore$.

When executing:

The lavaan function is called and the result, incorporated in a list to support errored executions, is compared to the result of a previous execution as stored in subdirectory snapshots. If there is no result of a previous execution the current result is stored in subdirectory snapshots.

If the current call of the lavaan function is without errors the same procedure is applied to the reports mentioned.

A logging of the differences in behavior of the lavaan calls (warnings and/or errors) and the results of comparing the reports is created.

To recreate the snapshots of a test, remove the corresponding snapshots in the snapshots map before executing the test.
