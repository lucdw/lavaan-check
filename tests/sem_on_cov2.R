# Test_id : sem_on_cov2
# =====================
# sem on covariance matrix, regressions

library(lavaan)

set.seed(1234)

Model <- c(
' 
           Schop  =~ 6.409 * SP_A + SP_L
           Intel  =~ NA * IQ_A + IQ_L
           Intel ~~ 1*Intel

           ADVICE ~ Schop
           Schop  ~ Intel '
)
object <- try(sem(
sample.cov = c(4.01080729, 0.723002998151, 0.709007629876, 10.311646515156, 8.48659986384, 0.723002998151, 0.39025009, 0.231917338718, 3.390174597222, 1.95375374784, 0.709007629876, 0.231917338718, 0.33616804, 2.674291111752, 2.476723403648, 10.311646515156, 3.390174597222, 2.674291111752, 56.76416964, 30.418914201216, 8.48659986384, 1.95375374784, 2.476723403648, 30.418914201216, 41.41179904), sample.nobs = 276, likelihood = 'wishart', model = Model, parser = 'new'
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
