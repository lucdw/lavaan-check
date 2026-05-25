 library(lavaan)

HS.model <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9 '

TR <- function(x) { sum(diag(x)) }

###  1. column 1: Omega 'hat' E0 -- row 1: U 'hat' E0

fit <- cfa(HS.model, data = HolzingerSwineford1939, test = "yuan.bentler",
           # U
           information               = c("expected",   "expected"),
           h1.information            = c("structured", "structured"),
           # Omega
           omega.information         = "expected",
           omega.h1.information      = "structured",
           omega.h1.information.meat = "structured")

unlist(fit@test[[2]][c("stat", "df", "scaling.factor", "scaling.factor.h1",
                       "scaling.factor.h0", "trace.UGamma")])
#              stat                df    scaling.factor scaling.factor.h1
#         80.017350         24.000000          1.066088          1.064224
# scaling.factor.h0      trace.UGamma
#          1.062094         25.586108

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
O.options$information    <- "expected"
O.options$h1.information <- "structured"
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
B1 <- lavaan:::lav_model_h1_info_firstorder(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
Omega <- solve(A1) %*% B1 %*% solve(A1)
print(TR(U %*% Omega), digits = 8)
# 25.586108


###  2. column 1: Omega 'hat' E0 -- row 2: U 'tilde' E0

fit <- cfa(HS.model, data = HolzingerSwineford1939, test = "yuan.bentler",
           # U
           information               = c("expected",   "expected"),
           h1.information            = c("structured", "unstructured"),
           # Omega
           omega.information         = "expected",
           omega.h1.information      = "structured",
           omega.h1.information.meat = "structured")

unlist(fit@test[[2]][c("stat", "df", "scaling.factor", "scaling.factor.h1",
                       "scaling.factor.h0", "trace.UGamma")])
#              stat                df    scaling.factor scaling.factor.h1
#         81.068617         24.000000          1.052263          1.064224
# scaling.factor.h0      trace.UGamma
#          1.061903         25.254317

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
O.options$information    <- "expected"
O.options$h1.information <- "structured"
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
B1 <- lavaan:::lav_model_h1_info_firstorder(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
Omega <- solve(A1) %*% B1 %*% solve(A1)
print(TR(U %*% Omega), digits = 8)
# 25.254317



###  3. column 1: Omega 'hat' E0 -- row 3: U 'tilde' (same as E0 if complete)

fit <- cfa(HS.model, data = HolzingerSwineford1939, test = "yuan.bentler",
           # U
           information               = c("observed",     "observed"),
           observed.information      = c("h1",           "h1"),
           h1.information            = c("unstructured", "unstructured"),
           # Omega
           omega.information         = "expected",
           omega.h1.information      = "structured",
           omega.h1.information.meat = "structured")

unlist(fit@test[[2]][c("stat", "df", "scaling.factor", "scaling.factor.h1",
                       "scaling.factor.h0", "trace.UGamma")])
#              stat                df    scaling.factor scaling.factor.h1
#         81.068617         24.000000          1.052263          1.064224
# scaling.factor.h0      trace.UGamma
#          1.061903         25.254317

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
O.options$information    <- "expected"
O.options$h1.information <- "structured"
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
B1 <- lavaan:::lav_model_h1_info_firstorder(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
Omega <- solve(A1) %*% B1 %*% solve(A1)
print(TR(U %*% Omega), digits = 8)
# 25.254317



###  4. column 1: Omega 'hat' E0 -- row 4: U 'hat' h1

fit <- cfa(HS.model, data = HolzingerSwineford1939, test = "yuan.bentler",
           # U
           information               = c("observed",     "observed"),
           observed.information      = c("h1",           "h1"),
           h1.information            = c("structured",   "structured"),
           # Omega
           omega.information         = "expected",
           omega.h1.information      = "structured",
           omega.h1.information.meat = "structured")

unlist(fit@test[[2]][c("stat", "df", "scaling.factor", "scaling.factor.h1",
                       "scaling.factor.h0", "trace.UGamma")])
#              stat                df    scaling.factor scaling.factor.h1
#         79.800505         24.000000          1.068985          1.064224
# scaling.factor.h0      trace.UGamma
#          1.062593         25.655634

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
O.options$information    <- "expected"
O.options$h1.information <- "structured"
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
B1 <- lavaan:::lav_model_h1_info_firstorder(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
Omega <- solve(A1) %*% B1 %*% solve(A1)
print(TR(U %*% Omega), digits = 8)
# 25.655634


###  5. column 1: Omega 'hat' E0 -- row 5: U 'hat'

fit <- cfa(HS.model, data = HolzingerSwineford1939, test = "yuan.bentler",
           # U
           information               = c("observed",     "observed"),
           observed.information      = c("hessian",      "hessian"),
           h1.information            = c("structured",   "structured"),
           # Omega
           omega.information         = "expected",
           omega.h1.information      = "structured",
           omega.h1.information.meat = "structured")

unlist(fit@test[[2]][c("stat", "df", "scaling.factor", "scaling.factor.h1",
                       "scaling.factor.h0", "trace.UGamma")])
#              stat                df    scaling.factor scaling.factor.h1
#        91.5396764        24.0000000         0.9318967         1.0642241
# scaling.factor.h0      trace.UGamma
#         1.1332591        22.3655206

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
O.options$information    <- "expected"
O.options$h1.information <- "structured"
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
B1 <- lavaan:::lav_model_h1_info_firstorder(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
Omega <- solve(A1) %*% B1 %*% solve(A1)
print(TR(U %*% Omega), digits = 8)
# 22.3655206


###  6. column 1: Omega 'hat' E0 -- row 6: U 'tilde' mix

fit <- cfa(HS.model, data = HolzingerSwineford1939, test = "yuan.bentler",
           # U
           information               = c("observed",     "observed"),
           observed.information      = c("hessian",      "hessian"),
           h1.information            = c("unstructured", "unstructured"),
           # Omega
           omega.information         = "expected",
           omega.h1.information      = "structured",
           omega.h1.information.meat = "structured")

unlist(fit@test[[2]][c("stat", "df", "scaling.factor", "scaling.factor.h1",
                       "scaling.factor.h0", "trace.UGamma")])
#              stat                df    scaling.factor scaling.factor.h1
#       102.6538763        24.0000000         0.8310015         1.0642241
# scaling.factor.h0      trace.UGamma
#         1.3119548        19.9440352

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
O.options$information    <- "expected"
O.options$h1.information <- "structured"
A1 <- lavaan:::lav_model_h1_info(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
B1 <- lavaan:::lav_model_h1_info_firstorder(lavmodel = fit@Model,
          lavoptions = O.options, lavdata = fit@Data,
          lavsamplestats = fit@SampleStats)[[1]]
Omega <- solve(A1) %*% B1 %*% solve(A1)
print(TR(U %*% Omega), digits = 8)
# 19.944035

