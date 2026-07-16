# Test_id : HS_cov_multiple
# =========================
# # 2b of TESTSUITE / Misc

library(lavaan)

set.seed(1234)

Model <- c(
'
  speed   =~ x7 + x8 + x9
  textual =~ x4 + x5 + x6
  visual  =~ x1 + x2 + x3
'
)
D1 <- subset(lavaan::HolzingerSwineford1939, school=="Pasteur")[,7:15]
D2 <- subset(lavaan::HolzingerSwineford1939, school=="Grant-White")[,7:15]
S.Pasteur <- cov(D1)
S.GrantWhite <- cov(D2)
M.Pasteur <- apply(D1, 2, mean)
M.GrantWhite <- apply(D2, 2, mean)
object <- try(cfa(
  sample_cov = list(Pasteur=S.Pasteur, `Grant-White`=S.GrantWhite),
  sample_mean = list(M.Pasteur, M.GrantWhite),
  sample_nobs = c(156, 145), meanstructure = TRUE, ov_order = 'data', model = Model
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
