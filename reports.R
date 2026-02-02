# Names of reports should start with :
# nodata_ if applicable to cases without data
# all_ if applicable to all cases with data or covariance given
# data_ if applicable to all cases with data given
# cat_ if applicable to all cases with categorical data
# con_ if applicable to all cases with continuous data
# <special_string>_ for reports only applicable in very special cases

# Reports for text output, stored in text.reports, list(function to execute, text for lines to ignore)
if (exists("text.reports")) rm(text.reports)
text.reports <- new.env(parent = emptyenv())
assign("nodata_sum_fitted",
       list(
         fun = function(object) {
           sapply(fitted(object), function(x)
             sum(unlist(x)))
         },
         ignore = character(0)
       ),
       envir = text.reports)
assign("all_lavnames",
       list(
         fun = function(object) {
           lavNames(object, "all")
         },
         ignore = character(0)
       ),
       envir = text.reports)
assign("all_lavInspect",
       list(
         fun = function(object) {
           lavInspect(object)
         },
         ignore = character(0)
       ),
       envir = text.reports)
assign("all_inspect_patterns",
       list(
         func = function(object)
           lavInspect(object,  what = "patterns"),
         ignore = character(0)
       ),
       envir = text.reports)
assign("data_inspect_gamma",
       list(
         func = function(object)
           lavInspect(object,  what = "gamma"),
         ignore = character(0)
       ),
       envir = text.reports)
assign("all_summary",
       list(
         func = function(object)
           summary(object),
         ignore = c(" ended ", "This is lavaan ")
       ),
       envir = text.reports)
assign("efa_summary",
       list(
         func = function(object)
           summary(object),
         ignore = "This is lavaan "
       ),
       envir = text.reports)

# create tol function for tolerance handling
# default is severe: difference detected when > max(1e-4, 0.001 * mean(old, new))
tolerance <- function(type = c("MAX", "ABS", "REL", "MIN"), abs.val = 1e-4, rel.val = 0.001) {
  stopifnot(abs.val > 0, rel.val > 0)
  type <- match.arg(type)
  switch(type,
         ABS = function(old, new) {abs(old - new) > abs.val},
         REL = function(old, new) {abs(old - new) > 0.5 * rel.val * (abs(old) + abs(new))},
         MAX = function(old, new) {abs(old - new) > max(abs.val, 0.5 * rel.val * (abs(old) + abs(new)))},
         MIN = function(old, new) {abs(old - new) > min(abs.val, 0.5 * rel.val * (abs(old) + abs(new)))}
  )
}
# Reports for value output, stored in val.reports, list(function to execute, tol function)
# The tol function takes two values (old and new) as input and returns a boolean, TRUE if
# difference between old and new greater then tolerance. The tolerance function above is a helper 
# to creat tol functions.
if (exists("val.reports")) rm(val.reports)
val.reports <- new.env(parent = emptyenv())
assign("all_coef",
       list(
         fun = function(object) {
           coef(object)
         },
         tol = tolerance("MAX", abs.val = 0.001, rel.val = 0.01) # min(0.001, 0.01 * (abs(old) + abs(new)) / 2)
       ),
       envir = val.reports)
assign("con_residuals",
       list(
         fun = function(object) {
           residuals(object)[[2]]
         },
         tol = tolerance("MIN", abs.val = 0.001, rel.val = 0.01) # max(0.001, 0.01 * (abs(old) + abs(new)) / 2)
       ),
       envir = val.reports)
assign("con_resid",
       list(
         fun = function(object) {
           resid(object)
         },
         tol = tolerance("REL", rel.val = 0.01)
       ),
       envir = val.reports)
assign("data_objectobs",
       list(
         fun = function(object) {
           head(resid(object, "obs"))
         },
         tol = tolerance("REL", rel.val = 0.01)
       ),
       envir = val.reports)
assign("all_fittedvalues",
       list(
         fun = function(object) {
           fitted.values(object)
         },
         tol = tolerance("ABS", abs.val = 0.001)
       ),
       envir = val.reports)
assign("all_fitted",
       list(
         fun = function(object) {
           fitted(object)
         },
         tol = tolerance()
       ),
       envir = val.reports)
assign("data_predict",
       list(
         fun = function(object) {
           head(predict(object))
         },
         tol = tolerance()
       ),
       envir = val.reports)
assign("data_reg_fsm",
       list(
         fun = function(object) {
           out <- lavPredict(object,
                             fsm = TRUE,
                             se = TRUE,
                             acov = TRUE)
           attr(out, "fsm")
         },
         tol = tolerance()
       ),
       envir = val.reports)
assign("data_reg_se",
       list(
         fun = function(object) {
           out <- lavPredict(object,
                             fsm = TRUE,
                             se = TRUE,
                             acov = TRUE)
           attr(out, "se")
         },
         tol = tolerance()
       ),
       envir = val.reports)
assign("data_reg_acov",
       list(
         fun = function(object) {
           out <- lavPredict(object,
                             fsm = TRUE,
                             se = TRUE,
                             acov = TRUE)
           attr(out, "acov")
         },
         tol = tolerance()
       ),
       envir = val.reports)
assign("data_Bart_fsm",
       list(
         fun = function(object) {
           out <-
             lavPredict(
               object,
               fsm = TRUE,
               se = TRUE,
               acov = TRUE,
               method = "Bartlett"
             )
           attr(out, "fsm")
         },
         tol = tolerance()
       ),
       envir = val.reports)
assign("data_Bart_se",
       list(
         fun = function(object) {
           out <-
             lavPredict(
               object,
               fsm = TRUE,
               se = TRUE,
               acov = TRUE,
               method = "Bartlett"
             )
           attr(out, "se")
         },
         tol = tolerance()
       ),
       envir = val.reports)
assign("data_Bart_acov",
       list(
         fun = function(object) {
           out <-
             lavPredict(
               object,
               fsm = TRUE,
               se = TRUE,
               acov = TRUE,
               method = "Bartlett"
             )
           attr(out, "acov")
         },
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_anova",
       list(
         fun = function(object) {
           anova(object)
         },
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_vcov",
       list(
         fun = function(object) {
           vcov(object)
         },
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_ortho",
       list(
         fun = function(object) {
           object.ortho <- update(object, orthogonal = TRUE)
           coef(object.ortho)
         },
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_AIC",
       list(
         fun = function(object) {
           AIC(object)
         },
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_BIC",
       list(
         fun = function(object) {
           BIC(object)
         },
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_logLik",
       list(
         fun = function(object) {
           logLik(object)
         },
         tol = tolerance()
       ),
       envir = val.reports)
assign("data_nobs",
       list(
         fun = function(object) {
           nobs(object)
         },
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_partable",
       list(
         func = function(object)
           lavInspect(object,  what = "partable"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_se",
       list(
         func = function(object)
           lavInspect(object,  what = "se"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_start",
       list(
         func = function(object)
           lavInspect(object,  what = "start"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_est",
       list(
         func = function(object)
           lavInspect(object,  what = "est"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_dx.free",
       list(
         func = function(object)
           lavInspect(object,  what = "dx.free"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_std.all",
       list(
         func = function(object)
           lavInspect(object,  what = "std.all"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_std.lv",
       list(
         func = function(object)
           lavInspect(object,  what = "std.lv"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_std.nox",
       list(
         func = function(object)
           lavInspect(object,  what = "std.nox"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_sampstat",
       list(
         func = function(object)
           lavInspect(object,  what = "sampstat"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_rsquare",
       list(
         func = function(object)
           lavInspect(object,  what = "rsquare"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_cov.lv",
       list(
         func = function(object)
           lavInspect(object,  what = "cov.lv"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_cor.lv",
       list(
         func = function(object)
           lavInspect(object,  what = "cor.lv"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_mean.lv",
       list(
         func = function(object)
           lavInspect(object,  what = "mean.lv"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_cov.ov",
       list(
         func = function(object)
           lavInspect(object,  what = "cov.ov"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_cor.ov",
       list(
         func = function(object)
           lavInspect(object,  what = "cor.ov"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_mean.ov",
       list(
         func = function(object)
           lavInspect(object,  what = "mean.ov"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_th",
       list(
         func = function(object)
           lavInspect(object,  what = "th"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_theta",
       list(
         func = function(object)
           lavInspect(object,  what = "theta"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_theta.cor",
       list(
         func = function(object)
           lavInspect(object,  what = "theta.cor"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_coverage",
       list(
         func = function(object)
           lavInspect(object,  what = "coverage"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_converged",
       list(
         func = function(object)
           as.numeric(lavInspect(object,  what = "converged")),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_wls.est",
       list(
         func = function(object)
           lavInspect(object,  what = "wls.est"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_wls.obs",
       list(
         func = function(object)
           lavInspect(object,  what = "wls.obs"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_wls.v",
       list(
         func = function(object)
           lavInspect(object,  what = "wls.v"),
         tol = tolerance()
       ),
       envir = val.reports)
assign("all_inspect_hessian",
       list(
         func = function(object)
           lavInspect(object,  what = "hessian"),
         tol = tolerance()
       ),
       envir = val.reports)
# temporary removed report because modindices gives an error when fitted with ov.order = "data"
# assign("all_inspect_head_modindices",
#        list(
#          func = function(object)
#            head(modindices(object)),
#          tol = tolerance()
#        ),
#        envir = val.reports)
assign(
  "all_inspect_standardizedSolution",
  list(
    func = function(object)
      standardizedSolution(object),
    tol = tolerance()
  ),
  envir = val.reports
)
assign(
  "all_inspect_parameterEstimates",
  list(
    func = function(object)
      parameterEstimates(object),
    tol = tolerance()
  ),
  envir = val.reports
)
assign(
  "all_inspect_parameterTable",
  list(
    func = function(object)
      parameterTable(object),
    tol = tolerance()
  ),
  envir = val.reports
)
assign("all_inspect_varTable",
       list(
         func = function(object)
           varTable(object),
         tol = tolerance()
       ),
       envir = val.reports)
assign(
  "all_inspect_fitMeasures",
  list(
    func = function(object)
      fitMeasures(object),
    tol = tolerance()
  ),
  envir = val.reports
)
assign(
  "all_inspect_fitMeasures_chisq",
  list(
    func = function(object)
      fitMeasures(object, "chisq"),
    tol = tolerance()
  ),
  envir = val.reports
)
assign(
  "all_inspect_fitMeasures_diverse",
  list(
    func = function(object)
      fitMeasures(object, c("chisq", "df", "pvalue", "rmsea", "cfi")),
    tol = tolerance()
  ),
  envir = val.reports
)
assign("data_inspect_head_lavScores",
       list(
         func = function(object)
           head(lavScores(object)),
         tol = tolerance()
       ),
       envir = val.reports)
assign(
  "all_inspect_lavTables_dimension0",
  list(
    func = function(object)
      lavTables(object, dimension = 0L),
    tol = tolerance()
  ),
  envir = val.reports
)
assign(
  "all_inspect_lavTables_dimension1",
  list(
    func = function(object)
      lavTables(object, dimension = 1L),
    tol = tolerance()
  ),
  envir = val.reports
)
assign(
  "all_inspect_lavTables_dimension2",
  list(
    func = function(object)
      lavTables(object, dimension = 2L),
    tol = tolerance()
  ),
  envir = val.reports
)
assign(
  "all_inspect_lavTestLRT",
  list(
    func = function(object)
      lavTestLRT(object),
    tol = tolerance()
  ),
  envir = val.reports
)
assign(
  "all_inspect_lavCor",
  list(
    func = function(object)
      lavCor(object),
    tol = tolerance()
  ),
  envir = val.reports
)
# special cases
assign(
  "stanse_solution",
  list(
    func = function(object)
      standardizedSolution(object),
    tol = tolerance()
  ),
  envir = val.reports
)
assign(
  "bootse_se",
  list(
    func = function(object) parameterEstimates(object)$se,
    tol = tolerance("REL", rel.val = 0.15 )
  )
)