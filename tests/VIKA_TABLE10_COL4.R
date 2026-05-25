 library(lavaan)

HS.model <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9 '

TR <- function(x) { sum(diag(x)) }

### 19. column 4: Omega 'hat' -- row 1: U 'hat' E0

fit <- cfa(HS.model, data = HolzingerSwineford1939, test = "yuan.bentler",
           # U
           information               = c("expected",   "expected"),
           h1.information            = c("structured", "structured"),
           # Omega
           omega.information         = "observed",
           omega.h1.information      = "structured",
           omega.h1.information.meat = "structured")

unlist(fit@test[[2]][c("stat", "df", "scaling.factor", "scaling.factor.h1",
                       "scaling.factor.h0", "trace.UGamma")])
#              stat                df    scaling.factor scaling.factor.h1
#         55.261176         24.000000          1.543679          1.091298
# scaling.factor.h0      trace.UGamma
#          1.062094         37.048298

# manual
U.options <- fit@Options
U.options$information    <- "expected"
U.options$h1.information <- "structured"

# U
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = U.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
Delta <- lavTech(fit, "delta")[[1]]
U <- A1 - A1 %*% Delta %*% solve(t(Delta) %*% A1 %*% Delta) %*% t(Delta) %*% A1

# manual
O.options <- fit@Options
O.options$information    <- "observed"
O.options$h1.information <- "structured"
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
B1 <- lavaan:::lav_model_h1_info_firstorder(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
Omega <- solve(A1) %*% B1 %*% solve(A1)
print(TR(U %*% Omega), digits = 8)
# 37.048298


### 20. column 4: Omega 'hat' -- row 2: U 'tilde' E0

fit <- cfa(HS.model, data = HolzingerSwineford1939, test = "yuan.bentler",
           # U
           information               = c("expected",   "expected"),
           h1.information            = c("structured", "unstructured"),
           # Omega
           omega.information         = "observed",
           omega.h1.information      = "structured",
           omega.h1.information.meat = "structured")

unlist(fit@test[[2]][c("stat", "df", "scaling.factor", "scaling.factor.h1",
                       "scaling.factor.h0", "trace.UGamma")])
#              stat                df    scaling.factor scaling.factor.h1
#         44.139743         24.000000          1.932624          1.091298
# scaling.factor.h0      trace.UGamma
#          1.061903         46.382973

# manual
U.options <- fit@Options
U.options$information    <- "expected"
U.options$h1.information <- "unstructured"

# U
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = U.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
Delta <- lavTech(fit, "delta")[[1]]
U <- A1 - A1 %*% Delta %*% solve(t(Delta) %*% A1 %*% Delta) %*% t(Delta) %*% A1

# manual
O.options <- fit@Options
O.options$information    <- "observed"
O.options$h1.information <- "structured"
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
B1 <- lavaan:::lav_model_h1_info_firstorder(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
Omega <- solve(A1) %*% B1 %*% solve(A1)
print(TR(U %*% Omega), digits = 8)
# 46.382973



### 21. column 4: Omega 'hat' -- row 3: U 'tilde' (same as E0 if complete)

fit <- cfa(HS.model, data = HolzingerSwineford1939, test = "yuan.bentler",
           # U
           information               = c("observed",     "observed"),
           observed.information      = c("h1",           "h1"),
           h1.information            = c("unstructured", "unstructured"),
           # Omega
           omega.information         = "observed",
           omega.h1.information      = "structured",
           omega.h1.information.meat = "structured")

unlist(fit@test[[2]][c("stat", "df", "scaling.factor", "scaling.factor.h1",
                       "scaling.factor.h0", "trace.UGamma")])
#              stat                df    scaling.factor scaling.factor.h1
#         44.139743         24.000000          1.932624          1.091298
# scaling.factor.h0      trace.UGamma
#          1.061903         46.382973

# manual
U.options <- fit@Options
U.options$information          <- "observed"
U.options$observed.information <- "h1"
U.options$h1.information       <- "unstructured"

# U
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = U.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
Delta <- lavTech(fit, "delta")[[1]]
U <- A1 - A1 %*% Delta %*% solve(t(Delta) %*% A1 %*% Delta) %*% t(Delta) %*% A1

# manual
O.options <- fit@Options
O.options$information    <- "observed"
O.options$h1.information <- "structured"
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
B1 <- lavaan:::lav_model_h1_info_firstorder(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
Omega <- solve(A1) %*% B1 %*% solve(A1)
print(TR(U %*% Omega), digits = 8)
# 46.382973



### 22. column 4: Omega 'hat' -- row 4: U 'hat' h1

fit <- cfa(HS.model, data = HolzingerSwineford1939, test = "yuan.bentler",
           # U
           information               = c("observed",     "observed"),
           observed.information      = c("h1",           "h1"),
           h1.information            = c("structured",   "structured"),
           # Omega
           omega.information         = "observed",
           omega.h1.information      = "structured",
           omega.h1.information.meat = "structured")

unlist(fit@test[[2]][c("stat", "df", "scaling.factor", "scaling.factor.h1",
                       "scaling.factor.h0", "trace.UGamma")])
#              stat                df    scaling.factor scaling.factor.h1
#         76.410298         24.000000          1.116414          1.091298
# scaling.factor.h0      trace.UGamma
#          1.062593         26.793935

# manual
U.options <- fit@Options
U.options$information          <- "observed"
U.options$observed.information <- "h1"
U.options$h1.information       <- "structured"

# U
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = U.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
Delta <- lavTech(fit, "delta")[[1]]
U <- A1 - A1 %*% Delta %*% solve(t(Delta) %*% A1 %*% Delta) %*% t(Delta) %*% A1

# manual
O.options <- fit@Options
O.options$information    <- "observed"
O.options$h1.information <- "structured"
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
B1 <- lavaan:::lav_model_h1_info_firstorder(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
Omega <- solve(A1) %*% B1 %*% solve(A1)
print(TR(U %*% Omega), digits = 8)
# 26.793935


### 23. column 4: Omega 'hat' -- row 5: U 'hat'

fit <- cfa(HS.model, data = HolzingerSwineford1939, test = "yuan.bentler",
           # U
           information               = c("observed",     "observed"),
           observed.information      = c("hessian",      "hessian"),
           h1.information            = c("structured",   "structured"),
           # Omega
           omega.information         = "observed",
           omega.h1.information      = "structured",
           omega.h1.information.meat = "structured")

unlist(fit@test[[2]][c("stat", "df", "scaling.factor", "scaling.factor.h1",
                       "scaling.factor.h0", "trace.UGamma")])
#              stat                df    scaling.factor scaling.factor.h1
#         80.890406         24.000000          1.054581          1.091298
# scaling.factor.h0      trace.UGamma
#          1.133259         25.309955

# manual
U.options <- fit@Options
U.options$information          <- "observed"
U.options$observed.information <- "hessian"
U.options$h1.information       <- "structured"

# U
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = U.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
A0 <- lavaan:::lav_model_info(lavmodel = fit@Model,
          lavoptions = U.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)
Delta <- lavTech(fit, "delta")[[1]]
U <- A1 - A1 %*% Delta %*% solve(A0) %*% t(Delta) %*% A1

# manual
O.options <- fit@Options
O.options$information    <- "observed"
O.options$h1.information <- "structured"
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
B1 <- lavaan:::lav_model_h1_info_firstorder(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
Omega <- solve(A1) %*% B1 %*% solve(A1)
print(TR(U %*% Omega), digits = 8)
# 25.309955


### 24. column 4: Omega 'hat' -- row 6: U 'tilde' mix

fit <- cfa(HS.model, data = HolzingerSwineford1939, test = "yuan.bentler",
           # U
           information               = c("observed",     "observed"),
           observed.information      = c("hessian",      "hessian"),
           h1.information            = c("unstructured", "unstructured"),
           # Omega
           omega.information         = "observed",
           omega.h1.information      = "structured",
           omega.h1.information.meat = "structured")

unlist(fit@test[[2]][c("stat", "df", "scaling.factor", "scaling.factor.h1",
                       "scaling.factor.h0", "trace.UGamma")])
#              stat                df    scaling.factor scaling.factor.h1
#       124.2208247        24.0000000         0.6867248         1.0912977
# scaling.factor.h0      trace.UGamma
#         1.3119548        16.4813954

# manual
U.options <- fit@Options
U.options$information          <- "observed"
U.options$observed.information <- "hessian"
U.options$h1.information       <- "unstructured"

# U
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = U.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
A0 <- lavaan:::lav_model_info(lavmodel = fit@Model,
          lavoptions = U.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)
Delta <- lavTech(fit, "delta")[[1]]
U <- A1 - A1 %*% Delta %*% solve(A0) %*% t(Delta) %*% A1

# manual
O.options <- fit@Options
O.options$information    <- "observed"
O.options$h1.information <- "structured"
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
B1 <- lavaan:::lav_model_h1_info_firstorder(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
Omega <- solve(A1) %*% B1 %*% solve(A1)
print(TR(U %*% Omega), digits = 9)
# 16.4813954

