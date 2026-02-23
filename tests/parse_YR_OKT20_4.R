test.id <- 'parse_YR_OKT20_4'
lavaan.model <- '

  # loadings
    A1B1 =~ 1*var1
    A2B1 =~ 1*var2
    A3B1 =~ 1*var3
    A1B2 =~ 1*var4
    A2B2 =~ 1*var5
    A3B2 =~ 1*var6
  # intercepts
    var1 ~ 0*1
    var2 ~ 0*1
    var3 ~ 0*1
    var4 ~ 0*1
    var5 ~ 0*1
    var6 ~ 0*1
    A1B1 ~ 0*1
    A2B1 ~ 0*1
    A3B1 ~ 0*1
    A1B2 ~ 0*1
    A2B2 ~ 0*1
    A3B2 ~ 0*1
  # variances
    A1B1 ~~ 0*A1B1
    A2B1 ~~ 0*A1B1 + 0*A2B1
    A3B1 ~~ 0*A1B1 + 0*A2B1 + 0*A3B1
    A1B2 ~~ 0*A1B1 + 0*A2B1 + 0*A3B1 + 0*A1B2
    A2B2 ~~ 0*A1B1 + 0*A2B1 + 0*A3B1 + 0*A1B2 + 0*A2B2
    A3B2 ~~ 0*A1B1 + 0*A2B1 + 0*A3B1 + 0*A1B2 + 0*A2B2 + 0*A3B2
    .pi1 ~~ .pi1
    .pi2 ~~ .pi1 + .pi2
    .pi3 ~~ .pi1 + .pi2 + .pi3
    .pi4 ~~ .pi1 + .pi2 + .pi3 + .pi4
    .pi5 ~~ .pi1 + .pi2 + .pi3 + .pi4 + .pi5
    .pi6 ~~ .pi1 + .pi2 + .pi3 + .pi4 + .pi5 + .pi6
  # struc_coeff
    .pi1 =~ 0.166666666666667*A1B1 + 0.166666666666667*A2B1 + 0.166666666666667*A3B1 + 0.166666666666667*A1B2 + 0.166666666666667*A2B2 + 0.166666666666667*A3B2
    .pi2 =~ 0.333333333333333*A1B1 + -0.166666666666667*A2B1 + -0.166666666666667*A3B1 + 0.333333333333333*A1B2 + -0.166666666666667*A2B2 + -0.166666666666667*A3B2
    .pi3 =~ -0.166666666666667*A1B1 + 0.333333333333333*A2B1 + -0.166666666666667*A3B1 + -0.166666666666667*A1B2 + 0.333333333333333*A2B2 + -0.166666666666667*A3B2
    .pi4 =~ 0.166666666666667*A1B1 + 0.166666666666667*A2B1 + 0.166666666666667*A3B1 + -0.166666666666667*A1B2 + -0.166666666666667*A2B2 + -0.166666666666667*A3B2
    .pi5 =~ 0.333333333333333*A1B1 + -0.166666666666667*A2B1 + -0.166666666666667*A3B1 + -0.333333333333333*A1B2 + 0.166666666666667*A2B2 + 0.166666666666667*A3B2
    .pi6 =~ -0.166666666666667*A1B1 + 0.333333333333333*A2B1 + -0.166666666666667*A3B1 + 0.166666666666667*A1B2 + -0.333333333333333*A2B2 + 0.166666666666667*A3B2
  # regressions
    .pi1 ~ .m1*1
    .pi2 ~ .m2*1
    .pi3 ~ .m3*1
    .pi4 ~ .m4*1
    .pi5 ~ .m5*1
    . pi6 ~ .m6*1
  # constraints
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
