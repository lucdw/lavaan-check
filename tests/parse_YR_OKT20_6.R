# Test_id : parse_YR_OKT20_6
# ==========================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'

 factor 1  =~ NA*V1 + V2 + V6 + V9 
 factor 2  =~ NA*V3 + V4 + V5 + V7 + V8 + V10 
 ACfactor =~  -0.061 * V1 +-0.026 * V2 +0.16 * V6 +0.137 * V9 +0.454 * V3 +0.048 * V4 +0.101 * V5 +0.125 * V7 +0.414 * V8 +0.487 * V10 
  factor 1 ~~1*factor 1 
 factor 2 ~~1*factor 2 
 
 factor 1 ~~0*ACfactor 
 factor 2 ~~0*ACfactor
'
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'open'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
