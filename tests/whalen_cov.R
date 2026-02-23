test.id <- "whalen_cov"
lavaan.model <- 'lnchla ~ pesticide + macroalgae + grass'
lavaan.call <-  "sem" 
lower <- "0.24,
-0.104,    3.426,
-0.0085,    -0.163,    0.412,
-0.207,    0.871,    0.062,    0.893,
-0.527,    1.203,    0.098,    0.766,    1.92,
0.239,    -0.312,    0.103,    -0.35,    -0.651,    0.466"
whalenCov <- lavaan::lav_getcov(lower, names=c("pesticide",  "macroalgae",    "grass",    "LNCaprell",    "LNGamm",    "lnchla"))
whalenMeans <- c(0.4,  0.702,  1.374,    1.044,    2.374,    -0.254)
whalenN <- 40
lavaan.args <- list(
  sample.cov = whalenCov, 
  sample.mean = whalenMeans, 
  sample.nobs = whalenN
)
reports <- c("all", "con")
test.comment <- '# 2c. fit a model from sample.cov, (no lm), fixed.x=TRUE'
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
