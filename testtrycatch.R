tryCatch.W.E <- function(expr)   # see demo(error.catching)
{
  W <- NULL
  w.handler <- function(w) {
    # warning handler
    W <<- c(W, w$message)
    invokeRestart("muffleWarning")
  }
  list(value = withCallingHandlers(tryCatch(
    expr,
    error = function(e)
      e
  ),
  warning = w.handler, message = w.handler),
  warning = W)
}
x <- tryCatch.W.E(
  {
    warning("this is a warning.")
    warning("this is also a warning.")
    stop("oeps")
    3.14159
  }
)
print(x$value)
if (inherits(x$value, "error")) cat("An error occurred:" , x$value$message)
if (!is.null(x$warning)) cat(x$warning, sep = "\n")