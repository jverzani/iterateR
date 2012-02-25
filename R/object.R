##' @include dataframe.R
NULL


##' Class for iterating over an object
##' 
##' @exportClass ObjectIterateR
##' @rdname ObjectIterateR
##' @name ObjectIterateR
ObjectIterateR <- setRefClass("ObjectIterateR",
                              contains="IterateR",
                              method=list(
                                initialize=function(mode,  ..., envir=.GlobalEnv, inherits=TRUE) {
                                  objects <- mget(ls(envir=envir),
                                                  envir=envir)
                                  is_of_mode <- function(x) any(sapply(mode, is, object=x))
                                  callSuper(Filter(is_of_mode, objects), ...)
                                }
                                ))
