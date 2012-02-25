Toy iterator package
---------------------------

Slightly enamored with jQuery's selector notation, e.g., $('<a>').each
...  to iterate over objects, this implements a similar but reverse
notation for R objects. So things like .(mtcars)$each(median) will
apply the median to each object. Akin to sapply(mtcars, median) of
course, bu the point is more objects fit into the same form (no apply
versus sapply).

This package needs some serious thought as to exactly what the
interface should be, as it is now it is just an experiment

Example
-------

The following examples illlustrate a bit. 

> install_github("IterateR", "jverzani")
> require(IterateR)
> require(MASS)
> require(MASS)
## simple example
> .(mtcars)$each(median)
    mpg     cyl    disp      hp    drat      wt    qsec      vs      am    gear 
 19.200   6.000 196.300 123.000   3.695   3.325  17.710   0.000   0.000   4.000 
   carb 
  2.000 
## chaining of commands
> .(Cars93)$filter(is.numeric)$each(median)
         Min.Price              Price          Max.Price           MPG.city 
              14.7               17.7               19.6               21.0 
       MPG.highway         EngineSize         Horsepower                RPM 
              28.0                2.4              140.0             5200.0 
      Rev.per.mile Fuel.tank.capacity         Passengers             Length 
            2340.0               16.4                5.0              183.0 
         Wheelbase              Width        Turn.circle     Rear.seat.room 
             103.0               69.0               39.0               27.5 
      Luggage.room             Weight 
              14.0             3040.0 
