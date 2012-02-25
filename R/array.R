##' @include iterate.R
NULL

##' Class for iterating over an array
##' 
##' @exportClass ArrayIterateR
##' @rdname ArrayIterateR
##' @name ArrayIterateR
ArrayIterateR <- setRefClass("ArrayIterateR",
                              contains="IterateR",
                              methods=list(
                                each=function(FUN, ..., MARGIN=1) {
                                  nms <- dimnames(obj)[[MARGIN]]
                                  idx <- seq_len(dim(obj)[MARGIN])
                                  out <- call_lapply(FUN, get_x(MARGIN), idx, nms, ...)
                                  .(out$simplify2array())
                                },
                                get_x=function(MARGIN=1) {
                                  x <- plyr:::splitter_a(obj, MARGIN)
                                }
                                ))
