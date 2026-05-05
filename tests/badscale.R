# Test_id : badscale
# ==================
# 8. standardized SE badly-scaled problem

library(lavaan)

set.seed(1234)

Model <- c(
'
Hopeless~~Hopeless
TB~~TB
PB~~PB
SI~~SI
Hopeless~1
TB~1
PB~1
SI~1
Time~~Time
Hopelesslag~~Time
TBlag~~Time
PBlag~~Time
SIlag~~Time
Hopelesslag~~Hopelesslag
TBlag~~Hopelesslag
PBlag~~Hopelesslag
SIlag~~Hopelesslag
TBlag~~TBlag
PBlag~~TBlag
SIlag~~TBlag
PBlag~~PBlag
SIlag~~PBlag
SIlag~~SIlag
Time~1
Hopelesslag~1
TBlag~1
PBlag~1
SIlag~1
Time~0*Hopeless
Time~0*TB
Time~0*PB
Time~0*SI
Hopelesslag~0*Hopeless
Hopelesslag~0*TB
Hopelesslag~0*PB
Hopelesslag~0*SI
TBlag~0*Hopeless
TBlag~0*TB
TBlag~0*PB
TBlag~0*SI
PBlag~0*Hopeless
PBlag~0*TB
PBlag~0*PB
PBlag~0*SI
SIlag~0*Hopeless
SIlag~0*TB
SIlag~0*PB
SIlag~0*SI
Hopeless~Hopelesslag
TB~TBlag
PB~PBlag
SI~SIlag
TB~PB
PB~Hopeless
SI~PB
'
)
object <- try(sem(
data = readRDS("stanse.rds"), missing = 'fiml', estimator = 'ml', int.ov.free = FALSE, int.lv.free = TRUE, auto.fix.first = TRUE, auto.var = TRUE, auto.cov.lv.x = TRUE, auto.th = TRUE, auto.delta = TRUE, auto.cov.y = FALSE, auto.fix.single = TRUE, warn = FALSE, model = Model, parser = 'new'
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
standardizedSolution(object)
})}
