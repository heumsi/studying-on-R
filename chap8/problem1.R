library(ggplot2)

# Q1
ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point()

# Q2
as.data.frame(ggplot2::midwest)
ggplot(data = as.data.frame(ggplot2::midwest), aes(x = poptotal, y = popasian)) +
  geom_point() +
  xlim(0, 500000) +
  ylim(0, 10000)
