library(lavaan)

Data <- read.table("/home/yves/semtest/MULTILEVEL/ex9.6.dat")
#Data <- read.table("http://statmodel.com/usersguide/chap9/ex9.6.dat")
names(Data) <- c("y1", "y2", "y3", "y4", "x1", "x2", "w", "clus")

model <- '
    level: 1
        fw =~ y1 + y2 + y3 + y4
        fw ~ x1 + x2

    level: 2
        fb =~ y1 + y2 + y3 + y4

        # option 1: free
        #y1 ~~ y1
        #y2 ~~ y2
        #y3 ~~ y3
        #y4 ~~ y4

        # option 2: bounded
        #y1 ~~ lower(0.0001)*y1
        #y2 ~~ lower(0.0001)*y2
        #y3 ~~ lower(0.0001)*y3
        #y4 ~~ lower(0.0001)*y4

        # option 3: fixed-to-zero
        y1 ~~ 0*y1
        y2 ~~ 0*y2
        y3 ~~ 0*y3
        y4 ~~ 0*y4

        fb ~ w
'

fit <- sem(model, data = Data, cluster = "clus")
source("common.srcR", echo = TRUE)


Data <- read.table("/home/yves/semtest/MULTILEVEL/MISSING/demo2_missing.dat")
Data[Data == -999999 ] <- NA
names(Data) <- c("y1", "y2", "y3", "y4", "y5", "y6", "y7", "y8", "y9", "y10",
                 "x1", "x2",  "x3",  "z1", "z2", "z3", "z4", "w1", "w2", "w3",
                 "cluster")

model <- '
    level: 1
      fw1 =~ y1 + y2 + y3
      fw2 =~ y4 + y5 + y6
      fw1 ~~ fw2 # not added by default!
      fa  =~ y7 + y8 + y9 + y10
      fa ~ fw1 + fw2
      fw1 ~ x1 + x2 + x3

  level: 2
      fb1 =~ y1 + y2 + y3
      fb2 =~ y4 + y5 + y6
      fbz =~ z1 + z2 + z3 + z4
      fbz ~ fb1 + fb2
      fb1 ~ w1 + w2 + w3

      #y3 ~~ lower(0.02)*y3
      #y6 ~~ lower(0.02)*y6
'

fit <- sem(model, data = Data, cluster = "cluster", verbose = TRUE,
           fixed.x = FALSE, missing = "ml")
source("common.srcR", echo = TRUE)


