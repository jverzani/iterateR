##' @include list.R
NULL

##' Class for iterating over columns or rows of a data frame
##'
##' @exportClass DataFrameIterateR
##' @rdname DataFrameIterateR
##' @name DataFrameIterateR
DataFrameIterateR <- setRefClass("DataFrameIterateR",
                                 contains="ListIterateR",
                                 methods=list(
                                   each=function(FUN, ..., MARGIN) {
                                     if(missing(MARGIN) || MARGIN == 2) {
                                       callSuper(FUN, ...)
                                     } else if (MARGIN == 1) {
                                       ## iterate over rows
                                       idx <- seq_along(nrow(obj))
                                       nms <- rownames(obj)
                                       call_lapply(FUN, get_x(MARGIN), idx, nms, ...)
                                     } else {
                                       if (!(MARGIN %in% seq_along(dim(obj))))
                                         stop(gettext("Invalid margin. Must be unspecified, 1 (for a row) or 2 (a column)."))
                                     }
                                   },
                                   get_x=function(MARGIN) {
                                     if(missing(MARGIN) || MARGIN == 2) {
                                       x <- obj
                                     } else {
                                       idx <- seq_along(nrow(obj))
                                       x <- lapply(idx, function(i) obj[i,])
                                     }
                                     x
                                   },
                                   to_list = function() .(as.list(obj)),
                                   to_data_frame=function() .self
                                   ))

