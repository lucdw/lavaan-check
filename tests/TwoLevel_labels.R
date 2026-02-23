test.id <- "TwoLevel_labels"
df <- lavaan::Demo.twolevel
df$g <- ifelse(df$cluster %% 2L, "type1", "type2")
lavaan.model <- ' 
  group: type1
    level: within
      fac =~ y1 + L2*y2 + L3*y3
    level: between
      fac =~ y1 + L2*y2 + L3*y3
     
  group: type2
    level: within
      fac =~ y1 + L2*y2 + L3*y3
    level: between
      fac =~ y1 + L2*y2 + L3*y3
'
lavaan.call <- "sem"
lavaan.args <- list(
  data = df,
  cluster = "cluster",
  group = "g"
) 
reports <- c("all", "con", "data")
test.comment <- 'this one special for ov.names'
if (!exists("group.environment") || is.null(group.environment)) {
  source("utilities.R")
  execute_test(test.id, lavaan.model, lavaan.call, lavaan.args, reports, test.comment)
}
