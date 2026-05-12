 library(lavaan) # >= 0.6

load("usemmodelfit_lavaan0.5.RData")

fit <- usemmodelfit

summary(fit)

fit0 <- lavaan:::lav_object_independence(fit)
fit0

fitMeasures(fit)
lavTestLRT(fit)
parameterEstimates(fit)

lavInspect(fit, "information")
lavInspect(fit, "information.expected")
lavInspect(fit, "information.first.order")

FULL <- lavaan:::lav_partable_full(fit@ParTable, free = TRUE, start = TRUE,
                          strict_exo = FALSE)
FULL$free <- rep(1L, nrow(FULL))
FULL$user <- rep(10L, nrow(FULL))
FIT <- lavaan:::lav_object_extended(fit, add = FULL, all_free = TRUE)
information <- lavTech(FIT, "information.expected")

# stats
coef(fit)
residuals(fit)
resid(fit)
head(resid(fit, "obs"))
fitted.values(fit)
fitted(fit)
head(predict(fit))
anova(fit)
vcov(fit)

# stats4
AIC(fit)
BIC(fit)
logLik(fit)
nobs(fit)

# lavaan fitting functions
lavNames(fit, "all")
lavInspect(fit)
lavInspect(fit, what="partable")
lavInspect(fit, what="se")
lavInspect(fit, what="start")
lavInspect(fit, what="est")
lavInspect(fit, what="dx.free")
#lavInspect(fit, what="dx")
lavInspect(fit, what="std.all")
lavInspect(fit, what="std.lv")
lavInspect(fit, what="std.nox")
lavInspect(fit, what="sampstat")
lavInspect(fit, what="rsquare")
lavInspect(fit, what="cov.lv")
lavInspect(fit, what="cor.lv")
lavInspect(fit, what="mean.lv")
lavInspect(fit, what="cov.ov")
lavInspect(fit, what="cor.ov")
lavInspect(fit, what="mean.ov")
lavInspect(fit, what="th")
lavInspect(fit, what="theta")
lavInspect(fit, what="theta.cor")
lavInspect(fit, what="coverage")
lavInspect(fit, what="patterns")
lavInspect(fit, what="converged")
lavInspect(fit, what="wls.est")
lavInspect(fit, what="wls.obs")
lavInspect(fit, what="wls.v")
lavInspect(fit, what="gamma")
lavInspect(fit, what="hessian")
#lavInspect(fit, what="first.order")

head(modindices(fit))
standardizedSolution(fit)
parameterEstimates(fit)
parameterTable(fit)
varTable(fit)

# all fit measures -- this will change all the time?
fitMeasures(fit)

# just one
fitMeasures(fit, "chisq")

# a few
fitMeasures(fit, c("chisq","df","pvalue","rmsea","cfi"))

head(lavScores(fit))
lavTables(fit, dimension = 0L)
lavTables(fit, dimension = 1L)
lavTables(fit, dimension = 2L)
lavTestLRT(fit)
lavCor(fit)




