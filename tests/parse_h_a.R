# Test_id : parse_h_a
# ===================
# 

library(lavaan)

set.seed(1234)

Model <- c(
'
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
)
object <- try(lavParseModelString(
as.data.frame. = TRUE, model.syntax = Model, parser = 'new'
), outFile = stdout())
if (!inherits(object, 'try-error')) {withAutoprint({
print(as.data.frame(object))
})}
