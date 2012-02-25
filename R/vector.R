##' @include iterate.R
NULL

## vector-like objects (have [, names style lists, vectors, ...)

##' class to iterate over a vector
##'
##' @exportClass VectorIterateR
##' @rdname VectorIterateR
##' @name VectorIterateR
VectorIterateR <- setRefClass("VectorIterateR",
                              contains="IterateR",
                              methods=list(
                                to_list=function() {
                                  .(as.list(obj))
                                },
                                to_vector=function() .self,
                                split=function(FAC) {
                                  .(split(obj, FAC))
                                },
                                ## New methods
                                push=function(x, nm) {
                                  ## how to add to the object
                                  if(missing(nm)) {
                                    obj <<- c(obj, x)
                                  } else {
                                    obj[nm] <<-x
                                  }
                                },
                                pop=function() {
                                  ## get last object
                                  base:::tail(obj, n=1)
                                }

                                ))

