# Test_id : analyse_categorical
# =============================
# 6q. non-convergence WLSMV + pairwise (scaling issue)

library(lavaan)

set.seed(1234)

Model <- c(
'
    # Latent variables
    DV1 =~ Y11 + Y12 + Y13 
    DV2 =~  Y21 + Y22 + Y23
  
    M1 =~ M11 + M12 + M13 + M14
    M2 =~ 1*M21 + 1*M22
    M3 =~ 1*M31 + 1*M32
   
    # Covariances between latent variables
    DV1 ~~ DV2
    M1 ~~ M2
    M2 ~~ M3
    M1 ~~ M3

    # Regressions
    DV1 + DV2 ~ M1 + M2 + M3 + IV
    M1 + M2 + M3 ~ IV
'
)
object <- try(sem(
data = readRDS("DF.rds"), ordered = c("M11", "M12", "M13", "M14"), missing = 'pairwise', control = list(iter.max = 500), model = Model
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
AIC(object)
anova(object)
BIC(object)
coef(object)
fitted(object)
fitted.values(object)
as.numeric(lavInspect(object,  what = 'converged'))
lavInspect(object,  what = 'cov.lv')
lavInspect(object,  what = 'cov.ov')
lavInspect(object,  what = 'coverage')
lavInspect(object,  what = 'dx.free')
lavInspect(object,  what = 'est')
fitMeasures(object)
fitMeasures(object, 'chisq')
fitMeasures(object, c('chisq', 'df', 'pvalue', 'rmsea', 'cfi'))
lavInspect(object,  what = 'hessian')
lavCor(object)
lavTables(object, dimension = 0L)
lavTables(object, dimension = 1L)
lavTables(object, dimension = 2L)
lavTestLRT(object)
lavInspect(object,  what = 'mean.lv')
lavInspect(object,  what = 'mean.ov')
parameterEstimates(object)
parameterTable(object)
lavInspect(object,  what = 'partable')
lavInspect(object,  what = 'patterns')
lavInspect(object,  what = 'rsquare')
lavInspect(object,  what = 'sampstat')
lavInspect(object,  what = 'se')
standardizedSolution(object)
lavInspect(object,  what = 'start')
lavInspect(object,  what = 'std.all')
lavInspect(object,  what = 'std.lv')
lavInspect(object,  what = 'std.nox')
lavInspect(object,  what = 'th')
lavInspect(object,  what = 'theta')
lavInspect(object,  what = 'theta.cor')
varTable(object)
lavInspect(object,  what = 'wls.est')
lavInspect(object,  what = 'wls.obs')
lavInspect(object,  what = 'wls.v')
lavInspect(object)
lavNames(object, 'all')
logLik(object)
coef(update(object, orthogonal = TRUE))
summary(object)
vcov(object)
})}
