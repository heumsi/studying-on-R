library(dplyr)

# Q1
suv_cty <- mpg %>%
  filter(class == "suv") %>%
  group_by(manufacturer) %>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(-mean_cty) %>%
  head(5)
suv_cty

ggplot(data = suv_cty, aes(x = reorder(manufacturer, -mean_cty), y = mean_cty)) + geom_col()

# Q2
ggplot(data = mpg, aes(x = class)) + geom_bar()
