test.id <- 'parse_h_a'
lavaan.model <- '
f1=~ c(.8,.8)*x1+ start(c(.8,.8))*x2 +start(c(.8,.8))*x3
                 f2 =~ c(.6,.6)*x4+start(c(.6,.6))*x5+start(c(.6,.6))*x6
                f1 ~~ start (c(1,1))*f1
                f2 ~~ start(c(1,1))*f2
                f2 ~~ start(c(.3,.6))*f1
             x1 ~~ start(c(.2,.3))*x1
             x2 ~~ start(c(.2,.3))*x2
             x3 ~~ start(c(.2,.3))*x3
             x4 ~~ start(c(.2,.3))*x4
             x5 ~~ start(c(.2,.3))*x5
             x6 ~~ start(c(.2,.3))*x6
'
lavaan.call <- 'lavParseModelString'
lavaan.args <- list(as.data.frame. = TRUE)
reports <- 'parser'
test.comment <- 'imported from ldwParse project'
if (!exists('group.environment') || is.null(group.environment)) {
    source('utilities.R')
    execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
