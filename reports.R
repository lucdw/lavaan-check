# Names of reports should start with :
# nodata_ if applicable to cases without data
# all_ if applicable to all cases with data or covariance given
# data_ if applicable to all cases with data given
# cat_ if applicable to all cases with categorical data
# con_ if applicable to all cases with continuous data

# Reports for text output, stored in text.reports, list(function to execute, text for lines to ignore)
if (exists("text.reports")) rm(text.reports)
text.reports <- new.env(parent = emptyenv())
assign("nodata_sum_fitted", 
       list(
          fun = function(object) {sapply(fitted(object), function(x) sum(unlist(x)))},
          ignore = character(0)
       ),
       envir = text.reports
       )
assign("all_lavnames", 
       list(
         fun = function(object) {lavNames(object, "all")},
         ignore = character(0)
       ),
       envir = text.reports
)
# Reports for value output, stored in val.reports, list(function to execute, tolerance function)
# The tolerance function takes two values (old and new) as input and returns a boolean, TRUE if 
# difference between old and new greater then tolerance. 
if (exists("val.reports")) rm(val.reports)
val.reports <- new.env(parent = emptyenv())
assign("all_coef", 
       list(
         fun = function(object) {coef(object)},
         tol = tolerance("REL", rel.val = 0.05)
       ),
       envir = val.reports
)
assign("con_residuals", 
       list(
         fun = function(object) {residuals(object)[[2]]},
         tol = tolerance("REL", rel.val = 0.01)
       ),
       envir = val.reports
)
assign("con_resid", 
       list(
         fun = function(object) {resid(object)},
         tol = tolerance("REL", rel.val = 0.01)
       ),
       envir = val.reports
)
assign("data_fitobs", 
       list(
         fun = function(object) {head(resid(object, "obs"))},
         tol = tolerance("REL", rel.val = 0.01)
       ),
       envir = val.reports
)
assign("all_fittedvalues", 
       list(
         fun = function(object) {fitted.values(object)},
         tol = tolerance("ABS", abs.val = 0.001)
       ),
       envir = val.reports
)

# default extractor functions
# we do not include the summary(); this shows the version number
# and this changes all the time

# stats
if (FALSE) {
fitted(fit)
head(predict(fit))
out <- lavPredict(fit, fsm = TRUE, se = TRUE, acov = TRUE)
attr(out, "fsm")
attr(out, "se")
attr(out, "acov")
out <- lavPredict(fit, fsm = TRUE, se = TRUE, acov = TRUE,
                  method = "Bartlett")
attr(out, "fsm")
attr(out, "se")
attr(out, "acov")
anova(fit)
vcov(fit)
fit.ortho <- update(fit, orthogonal=TRUE)
coef(fit.ortho)

# graphics
# skip plot

# methods
# show(fit) - skip, shows version number

# stats4
AIC(fit)
BIC(fit)
logLik(fit)
nobs(fit)

# lavaan fitting functions
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
}