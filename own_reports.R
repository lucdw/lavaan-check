# own reports for text output
txt_sum_fitted <- function(object) {
  sapply(fitted(object), function(x) sum(unlist(x)))
}
# own reports for value output
val_cov_lv <- function(object) {
  pe <- parameterestimates(object)
  lvs <- unique(pe$lhs[pe$op == "=~"])
  ind <- which(pe$lhs %in% lvs & pe$op == "~~") 
  x <- vapply(ind, function(i) {pe$est[i]}, 0.0)
  names(x) <- vapply(ind, function(i) {paste0(pe$lhs[i],"~~", pe$rhs[i])}, "")
  x
}
