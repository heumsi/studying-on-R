midwest <- as.data.frame(ggplot2::midwest)

# Q1
midwest <- midwest %>%
  mutate(rateUnderAdult = (poptotal - popadults) / poptotal * 100)

# Q2
midwest %>%
  select(county, rateUnderAdult) %>%
  arrange(desc(rateUnderAdult)) %>%
  head(5)

# Q3
midwest <- midwest %>%
  mutate(rateGrade = ifelse( rateUnderAdult >= 40, "large",
                             ifelse (rateUnderAdult >= 30 , "middle", "small")))
table(midwest$rateGrade)

# Q4
midwest %>%
  mutate(rateAsian = popasian / poptotal * 100) %>%
  group_by(state, county) %>%
  select(rateAsian) %>%
  arrange(rateAsian) %>%
  head(10)
