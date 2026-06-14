# Test_id : whalen_cov
# ====================
# # 2c. fit a model from sample.cov, (no lm), fixed.x=TRUE

library(lavaan)

set.seed(1234)

Model <- c(
'lnchla ~ pesticide + macroalgae + grass'
)
object <- try(sem(
sample.cov = c(0.24, -0.104, -0.0085, -0.207, -0.527, 0.239, -0.104, 3.426, -0.163, 0.871, 1.203, -0.312, -0.0085, -0.163, 0.412, 0.062, 0.098, 0.103, -0.207, 0.871, 0.062, 0.893, 0.766, -0.35, -0.527, 1.203, 0.098, 0.766, 1.92, -0.651, 0.239, -0.312, 0.103, -0.35, -0.651, 0.466), sample.mean = c(0.4, 0.702, 1.374, 1.044, 2.374, -0.254), sample.nobs = 40, model = Model, parser = 'open'
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
resid(object)
residuals(object)[[2]]
})}
