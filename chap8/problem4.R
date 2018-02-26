filtered_mpg <- mpg %>%
  filter(class %in% c("compact", "subcompact", "suv"))

ggplot(data = filtered_mpg, aes(x = class, y = cty)) + geom_boxplot()
