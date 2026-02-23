test.id <- "HS_cov_multiple"
lavaan.model <- '
  speed   =~ x7 + x8 + x9
  textual =~ x4 + x5 + x6
  visual  =~ x1 + x2 + x3
'
lavaan.call <-  "cfa" 
D1 <- subset(lavaan::HolzingerSwineford1939, school=="Pasteur")[,7:15]
D2 <- subset(lavaan::HolzingerSwineford1939, school=="Grant-White")[,7:15]
S.Pasteur <- cov(D1)
S.GrantWhite <- cov(D2)
M.Pasteur <- apply(D1, 2, mean)
M.GrantWhite <- apply(D2, 2, mean)
lavaan.args <- list(
  sample.cov = list(Pasteur=S.Pasteur, `Grant-White`=S.GrantWhite),
  sample.mean = list(M.Pasteur, M.GrantWhite),
  sample.nobs = c(156, 145), 
  meanstructure = TRUE,
  ov.order = "data"
  )
reports <- c("all", "con")
test.comment <- '# 2b of TESTSUITE / Misc'
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
