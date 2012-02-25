\name{.}
\alias{.}
\alias{dot}
\title{Create an iterable object}
\usage{
  .(x, mode, ...)
}
\arguments{
  \item{x}{object to turn into an iterable object.}

  \item{mode}{If \code{x} is unspecified and modes are
  specified then objects in the global workspace of that
  mode are used to iterate over. The value is passed to
  \code{mget} to get the objects.}

  \item{...}{passed to \code{new} of \code{IterateR}
  subclass. Used by \code{ObjectIterateR}, for example, to
  pass in information to \code{ls}.}
}
\value{
  Returns an instance of a subclass of \code{IterateR}.
}
\description{
  As S3 generic to create a subclass of \code{IterateR}.
  Object that are subclasses of \code{IterateR} have
  numberous reference class methods defined for them,
  though the primary one is \code{each}.
}
\details{
  The \code{each} method allows a simple means to iterate
  over the objects. The functionality is very similar to
  \code{sapply}, say, but has some novelties: the function
  arguments determine what gets passed in. If the function
  has arguments \code{x}, \code{i} or \code{nm} then these
  are passed the object, its index, or name, respectively.

  Other methods include:

  \code{split} to split the objects before iterating

  \code{filter} to apply a function to filter the objects
  by

  \code{find} to apply R's \code{Find} function

  \code{position} to apply R's \code{Position} function

  \code{tail} to call \code{tail}

  \code{head} to call \code{head}

  \code{slice} to call \code{[}

  Each of the above returns an instance of a subclass of
  \code{IterateR} allowing them to be chained together in
  one call.

  The \code{core} method returns the underlying object. If
  \code{simplify=TRUE}, the default, then this is after
  calling \code{simplify2array}.

  The notation reverses that of jQuery where $(obj).method
  is replaced in R with .(obj)$method. Okay, cute but is it
  of any use? Maybe not.
}
\examples{
## just like sapply(mtcars, median)
.(mtcars)$each(median) ## subclass of IterateR
## call core to get objects:
.(mtcars)$each(median)
## can chain calls if you want.
.(iris)$filter(is.numeric)$each(median)
## Sometimes we want both index and value (e.g., mapply(f, mtcars, seq_len(nrow(mtcars))))
.(mtcars)$each(function(x, i) sprintf('Column \%s has max \%s', i, max(x)))
## lists have a pluck method
.(mtcars)$each(function(x) c(mean=mean(x), sd=sd(x))) ## a table, but really stored as a list
.(mtcars)$each(function(x) c(mean=mean(x), sd=sd(x)))$pluck("mean") ## just mean values
}

