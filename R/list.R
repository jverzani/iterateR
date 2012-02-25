##' @include vector.R
NULL


##' class to iterate over a list
##'
##' @exportClass ListIterateR
##' @rdname ListIterateR
##' @name ListIterateR
ListIterateR <- setRefClass("ListIterateR",
                             contains="IterateR",
                              methods=list(
                                push=function(x, nm) {
                                  if(missing(nm))
                                    obj <<- c(obj, x)
                                  else
                                    obj[[nm]] <<- x
                                },
                                pop = function() {
                                  if(length(obj) >= 1) {
                                    x <- obj[[length(obj)]]
                                    obj <<- obj[[-length(obj)]]
                                    return(x)
                                  }
                                },
                                pluck=function(attr, FUN, ...) {
                                  "Pluck items out of each element"
                                  tmp <- each(function(x) x[attr])
                                  if(!missing(FUN))
                                    tmp$each(FUN, ...)
                                  else
                                    tmp
                                },
                                to_list=function() .self,
                                to_data_frame=function() {
                                  out <- try(cbind(obj), silent=TRUE)
                                  if(inherits(out, "try-error"))
                                    stop("can't coerce to a data frame")

                                  return(.(out))
                                }
                                ))
                        
