# Test_id : HS_mean_ML_bootstrap
# ==============================
# bootstrap fitted parameters will allways differ !!!

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
estimator = 'ML', information = 'observed', se = 'bootstrap', bootstrap = 200, data = readRDS("HS.rds"), meanstructure = TRUE, model = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
parameterEstimates(object)$se
})}
