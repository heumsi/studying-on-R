mpg <- ggplot2::mpg

# Q1
class(mpg$drv)

# Q2
mpg$drv <- as.factor(mpg$drv)
class(mpg$drv)

# Q3
levels(mpg$drv)