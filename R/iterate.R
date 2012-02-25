## IteraterR object is an object with methods that make iterating over it easy
## 
IterateR <- setRefClass("IterateR",
                        fields=list(
                          obj="ANY"
                          ),
                        methods=list(
                          each=function(FUN, ..., MARGIN) {
                            "
##' General purpose iterator. Slightly different from sapply
##'
##' Each object has some notion of what to iterate over. For vectors
##' and lists it is just like sapply. For data frames one can specify
##' a margin to iterate over if one wants to iterate over the
##' rows. For arrays, one must specify a margin (or take the default
##' of 1). This iterator passes along the objects and optionally their index and their name,
##' @param FUN a function to call. The function has a special set of
##' arguments. The arguments are parsed to see if 'x', 'i' or 'nm' are
##' present and if so these values are sent otherwise the objects are
##' passed through.
##' @param ... passed to function after first three elements
##' @param MARGIN for arrays and data frame used to specify which margin to go over (1 row, 2 column, 3, ...)
##' @return Returns an object which inherits from the *IterateR* class, so one can chain method calls.
##' @examples
##' ## just like sapply(mtcars, median)
##' .(mtcars)$each(median) ## returns subclass of IterateR
##' ## call core to get objects
##' .(mtcars)$each(median)$core() ## returns numeric vector
##' ## can chain calls if you want.
##' .(Cars93)$filter(is.numeric)$each(median)
##' ## Sometimes we want both index and value (e.g., mapply(f, mtcars, seq_len(nrow(mtcars))))
##' .(mtcars)$each(function(x, i) sprintf('Column %s has max %s', i, max(x)))
"
                            x <- get_x()
                            idx <- seq_along(x)
                            nms <- names(x)
                            call_lapply(FUN, x, idx, nms, ...)
                          },

                          ## Main interface
                          split=function(FAC, ...) {
                            "Split data, return list object"
                            stop("No default")
                          },
                          filter=function(FUN, ...) {
                            "Filter out results by values of FUN"
                            ind <- each(FUN, ...)$.unlist()
                            slice(!is.na(ind) & ind)
                          },
                          find=function(f,  right = FALSE, nomatch = NULL) {
                            "Interface to R's Find function"
                            .(Find(f, obj, right, nomatch))
                          },
                          position=function(f, right = FALSE, nomatch = NA_integer_) {
                            "Interface to R's Position function"                            
                            .(Position(f, obj, right=right, nomatch=nomatch))
                          },
                          tail=function(...) {
                            "Interace to R's tail function"
                            utils:::tail(obj, ...)
                          },
                          head=function(...) {
                            "Applies head to the objects"
                            utils:::head(obj, ...)
                          },
                          slice=function(i, MARGIN) {
                            "Slice object"
                            .(obj[i])
                          },
                          ## coercion
                          to_list=function() {
                            "Convert object to list object"
                            stop("no default")
                          },
                          to_data_frame=function() {
                            "Convert to data frame type"
                            stop("no default")
                          },
                          to_array=function() {
                            "Convert to array object"
                            stop("no default")
                          },
                          to_vector=function(){
                            "Convert to vector-like object"
                            stop("no default")
                          },
                          .unlist=function() {
                            base:::unlist(obj)
                          },
                          simplify2array=function() {
                            base:::simplify2array(obj)
                          },
                          ## The next few methods need to be made better.
                          get_x=function(MARGIN) {
                            "Get objects to iterate over"
                            obj
                          },
                          parse_fun=function(FUN) {
                            "Helper function to adjust call to function's arguments"
                            if(is.primitive(FUN)) {
                              out <- 4
                            }
                            out <- 0
                            lst <- formals(FUN)
                            if("x" %in% names(lst))
                              out <- out + 4
                            if(any(c("i") %in% names(lst)))
                              out <- out + 2
                            if(any(c("nm") %in% names(lst)))
                              out <- out + 1
                            if(out == 0)
                              out <- 4
                            return(out)
                          },
                          call_mapply=function(FUN, x, idx, nms, ...) {
                            "Helper function for calling a function."
                            FUN <- match.fun(FUN)
                            if(is.primitive(FUN)) {
                              
                            } else {
                              lst <- formals(FUN)
                              no_args <- length(lst)
                            }
                            if(no_args==1) {
                              .(mapply(FUN, x, ...))
                            } else if(no_args==2) {
                              .(mapply(FUN, x, idx, ...))
                            } else {
                              .(mapply(FUN, x, idx, nms, ...))
                            }
                          },
                          call_lapply=function(FUN, x, idx, nms, ...) {
                            "Helper function to call lapply, not mapply"
                            ## call lapply, not mapply -- used when x is a list
                            ## XXX This is ugly
                            FUN <- match.fun(FUN)
                            val <- parse_fun(FUN)

                            if(val == 1) {
                              .(sapply(nms, FUN, ..., simplify=FALSE))
                            } else if(val == 2) {
                              .(sapply(idx, FUN, ..., simplify=FALSE))
                            } else if(val == 3) {
                              .(sapply(idx, function(i, ...) FUN(i, nms[i], ...), ..., simplify=FALSE))
                            } else if(val == 4) {
                              .(sapply(x, FUN, ..., simplify=FALSE))
                            } else if(val == 5) {
                              .(sapply(idx, function(i, ...) FUN(x[i], nms[i], ...), ..., simplify=FALSE))
                            } else if(val == 6) {
                              .(sapply(idx, function(i, ...) FUN(x[i], i, ...), ..., simplify=FALSE))
                            } else if(val == 7) {
                              .(sapply(idx, function(i, ...) FUN(x[i], i, nms[i], ...), ..., simplify=FALSE))
                            }
                              
                          },                          
                          ## Output functions
                          show=function(...) {
                            "Show the object"
                            methods:::show(core(...))
                          },
                          core = function(simplify=TRUE) {
                            "Return obj"
                            if(simplify)
                              base:::simplify2array(obj)
                            else
                              obj
                          }

                            
                          ))

