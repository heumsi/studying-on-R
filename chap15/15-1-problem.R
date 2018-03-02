mpg <- ggplot2::mpg

# wrong answer ( my answer )
mpg$tot <- (mpg$cty + mpg$hwy) / 2
mpg[, "class" == "compact" | "class" == "suv"]
aggregate(data = mpg, tot~class, mean)

# correct answer
mpg$tot <- (mpg$cty + mpg$hwy) / 2

df_comp <- mpg[mpg$class == "compact", ]
df_suv <- mpg[mpg$class == "suv", ]

mean(df_comp$tot)
mean(df_suv$tot)
