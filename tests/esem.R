 library(lavaan)

set.seed(1234)

# data preparation
ex5_24 = read.table("ex5.24.dat")
names(ex5_24) = c(paste0("y",1:8), "x1", "x2")

model <- '
    # efa
    efa("efa1")*f1 + efa("efa1")*f2 =~ y1 + y2 + y3 + y4 + y5 + y6 + y7 + y8

    f1 + f2 ~ x1 + x2
    y1 ~ x1
    y8 ~ x2
'

fit <- sem(model = model, data = ex5_24, information = "observed",
           verbose = FALSE, rotation = "geomin",
           # mimic Mplus
           meanstructure = TRUE,
           rotation.args = list(rstarts = 0, row.weights = "none",
                                algorithm = "gpa", orthogonal = FALSE,
                                std.ov = TRUE, # row standard = correlation
                                geomin.epsilon = 0.0001))
parameterEstimates(fit)
standardizedSolution(fit)





ex5_25 = read.table("ex5.25.dat")
names(ex5_25) = paste0("y",1:12)

model <- '
    # efa
    efa("efa1")*f1 +
    efa("efa1")*f2 =~ y1 + y2 + y3 + y4 + y5 + y6

    # cfa
    f3 =~ y7 + y8 + y9
    f4 =~ y10 + y11 + y12

    f3 ~ f1 + f2
    f4 ~ f3
'

fit <- sem(model = model, data = ex5_25, rotation = "geomin",
           # mimic Mplus
           meanstructure = TRUE,
           information = "observed",
           rotation.args = list(rstarts = 0, row.weights = "none",
                                algorithm = "gpa", orthogonal = FALSE,
                                std.ov = TRUE, # row standard = correlation
                                geomin.epsilon = 0.0001))
parameterEstimates(fit)
standardizedSolution(fit)


# data preparation
ex5_26 = read.table("ex5.26.dat")
names(ex5_26) = paste0("y",1:12)

model <- '
    efa("time1")*f1 =~ a*y1 + b*y2 + c*y3 + d*y4 + e*y5 + f*y6
    efa("time1")*f2 =~ 0*y1 + h*y2 + i*y3 + j*y4 + k*y5 + l*y6

    efa("time2")*f3 =~ a*y7 + b*y8 + c*y9 + d*y10 + e*y11 + f*y12
    efa("time2")*f4 =~ 0*y7 + h*y8 + i*y9 + j*y10 + k*y11 + l*y12

    y1 ~~ y7
    y2 ~~ y8
    y3 ~~ y9
    y4 ~~ y10
    y5 ~~ y11
    y6 ~~ y12

    # free varcov f3 and f4
    f3 ~~ NA*f3 + start(1)*f3
    f4 ~~ NA*f4 + start(1)*f4
'

fit <- sem(model = model, data = ex5_26, rotation = "geomin",
           meanstructure = TRUE, verbose = FALSE,
           # mimic Mplus
           information = "observed",
           rotation.args = list(rstarts = 0, row.weights = "none",
                                algorithm = "gpa", orthogonal = FALSE,
                                std.ov = FALSE, # row standard = covariance
                                geomin.epsilon = 0.0001))
parameterEstimates(fit)
standardizedSolution(fit)


# data preparation
ex5_27 = read.table("ex5.27.dat")
names(ex5_27) = c(paste0("y",1:10), "group")

# ex5.27
model <- '
    efa("efa")*f1 +
    efa("efa")*f2 =~ y1 + y2 + y3 + y4 + y5 + y6 + y7 + y8 + y9 + y10
'

fit <- sem(model = model, data = ex5_27, rotation = "geomin",
           group = "group",
           # mimic Mplus
           information = "observed",
           rotation.args = list(rstarts = 0, row.weights = "none",
                                algorithm = "gpa", orthogonal = FALSE,
                                std.ov = TRUE, # row standard = correlation
                                geomin.epsilon = 0.0001))
parameterEstimates(fit)
standardizedSolution(fit)


# ex5.27b
model <- '
    efa("efa")*f1 +
    efa("efa")*f2 =~ y1 + y2 + y3 + y4 + y5 + y6 + y7 + y8 + y9 + y10
'


fit <- sem(model = model, data = ex5_27, rotation = "geomin",
           group = "group", group.equal = "loadings",
           # mimic Mplus
           information = "observed",
           rotation.args = list(rstarts = 0, row.weights = "none",
                                algorithm = "gpa", orthogonal = FALSE,
                                std.ov = FALSE, # row standard = covariance!!
                                geomin.epsilon = 0.0001))
parameterEstimates(fit)
standardizedSolution(fit)


# data preparation
ex5_28 = read.table("ex5.28.dat")
names(ex5_28) = paste0("y",1:10)

model <- '
    # efa
    efa("efa1")*f1 + efa("efa1")*f2 =~
        y1 + y2 + y3 + y4 + y5 + y6 + y7 + y8 + y9 + y10

    y1  ~~ v1*y1
    y2  ~~ v2*y2
    y3  ~~ v3*y3
    y4  ~~ v4*y4
    y5  ~~ v5*y5
    y6  ~~ v6*y6
    y7  ~~ v7*y7
    y8  ~~ v8*y8
    y9  ~~ v9*y9
    y10 ~~ v10*y10

    v1 > 0
    v2 > 0
    v3 > 0
    v4 > 0
    v5 > 0
    v6 > 0
    v7 > 0
    v8 > 0
    v9 > 0
    v10 > 0
'

fit <- sem(model = model, data = ex5_28, information = "observed",
           verbose = FALSE, rotation = "geomin",
           # mimic Mplus
           meanstructure = TRUE,
           rotation.args = list(rstarts = 0, row.weights = "none",
                                algorithm = "gpa", orthogonal = FALSE,
                                std.ov = TRUE, # row standard = correlation
                                geomin.epsilon = 0.0001))

parameterEstimates(fit)
standardizedSolution(fit)

