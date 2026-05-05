# Test_id : HS_ML_nodata2
# =======================
# a run without data

library(lavaan)

set.seed(1234)

Model <- c(
'
  visual  =~ x1 + x2 + x3
  textual =~ x4 + x5 + x6
  speed   =~ x7 + x8 + x9
'
)
object <- try(sem(
sample.nobs = c(100, 200), model = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
fitted(object)
})}
