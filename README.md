# lavaan-check

this project is intended to compare the results of fitting models in lavaan with the results of previous runs

There are two main procedures:

- create_snapshots, which generates all reports defined in the R-files test.\*.R and stores snapshots.

- run.all.tests.R which performs all tests defined in the R-files test.\*.R and reports the differences.


The test files are as indicated in the example below:

```         
test.id <- "HS_mean_GLS"
lavaan.model <- '
  visual  =~ x1 + x2 + x3
  textual =~ x4 + x5 + x6
  speed   =~ x7 + x8 + x9
'
lavaan.call <-  "sem" 
lavaan.args <- list(
  estimator = "GLS",
  data = "HS.rds",
  meanstructure = TRUE)
reports <- c("all", "con", "data")
test.comment <- ''
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

-   reports : a character vector with prefixes of reports (see below) to produce for this test

-   test.comment : optional comment on the test, which will also be copied in the logging

The following lines execute the test if the file is sourced directly (not as a result of sourcing run.all.tests.r, where this is done in the 'calling' script).

The reports are defined in reports.R. An extraction of this file is shown below:

```
# Names of reports should start with :
# nodata_ if applicable to cases without data
# all_ if applicable to all cases with data or covariance given
# data_ if applicable to all cases with data given
# cat_ if applicable to all cases with categorical data
# con_ if applicable to all cases with continuous data

# Reports for text output, stored in text.reports, list(function to execute, text for lines to ignore)
if (exists("text.reports")) rm(text.reports)
text.reports <- new.env(parent = emptyenv())
assign("nodata_sum_fitted", 
       list(
          fun = function(object) {sapply(fitted(object), function(x) sum(unlist(x)))},
          ignore = character(0)
       ),
       envir = text.reports
       )
assign("all_lavnames", 
       list(
         fun = function(object) {lavNames(object, "all")},
         ignore = character(0)
       ),
       envir = text.reports
)
# Reports for value output, stored in val.reports, list(function to execute, tolerance function)
# The tolerance function takes two values (old and new) as input and returns a boolean, TRUE if 
# difference between old and new greater then tolerance. 
if (exists("val.reports")) rm(val.reports)
val.reports <- new.env(parent = emptyenv())
assign("all_coef", 
       list(
         fun = function(object) {coef(object)},
         tol = tolerance("REL", rel.val = 0.05)
       ),
       envir = val.reports
)
etc...
```

Text reports are reports for which the output is printed to a file and the test exists of comparing this output with the output produced earlier (and stored in a file in the snapshots directory).
The definition of these reports are stored in environment text.reports and consist of a list with two elements:

- fun : the function to call with as only parameter the object resulting from the lavaan call.

- ignore : a - possibly empty - vector with character strings which identify lines in the report which should not be compared.

Value reports are reports for which the output is transformed to a named numeric vector and the elements of this vector are compared to those from a previous run (stored in snapshots).
The definition of these reports are stored in environment val.reports and consist of a list with two elements:

- fun : the function to call with as only parameter the object resulting from the lavaan call.

- tol : a function which takes two numeric values as input (old and new), and returns a logical indicating if the difference between those values is greater then the tolerance.

The tol functions can easily be made with the tolerance function (which is in file 'utilities.R'):

```
# create tol function for tolerance handling
# default is severe: difference detected when > max(1e-4, 0.001 * mean(old, new))
tolerance <- function(type = c("MAX", "ABS", "REL", "MIN"), abs.val = 1e-4, rel.val = 0.001) {
  stopifnot(abs.val > 0, rel.val > 0)
  type <- match.arg(type)
  switch(type,
         ABS = function(old, new) {abs(old - new) > abs.val},
         REL = function(old, new) {abs(old - new) > 0.5 * rel.val * (abs(old) + abs(new))},
         MAX = function(old, new) {abs(old - new) > max(abs.val, 0.5 * rel.val * (abs(old) + abs(new)))},
         MIN = function(old, new) {abs(old - new) > min(abs.val, 0.5 * rel.val * (abs(old) + abs(new)))}
  )
}
```

Notes:

1. If a snapshot for a test does not exist it is created and there is no comparison. This makes it easyer to define new tests and source the corresponding R file twice to see if it behaves as expected.

2. When new reports are defined and after adding new tests, it is advisable to recreate the entire snapshot structure via create.snapshots.R.