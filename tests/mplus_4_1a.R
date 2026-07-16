# Test_id : mplus_4_1a
# ====================
# mplus example 4.1a

library(lavaan)

set.seed(1234)

object <- try(efa(
data = readRDS("ex4.1a.RDS"), nfactors = 1:4
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
summary(object)
})}
