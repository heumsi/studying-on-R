# Q1
df <- as.data.frame(ggplot2::midwest)

# Q2
df <- rename(df, total = poptotal)
df <- rename(df, asian = popasian)

# Q3
df$asianRate <- df$asian / df$total
hist(df$asianRate)

# Q4
asianMean <- mean(df$asianRate)
df$asianAvg <- ifelse(df$asianRate > asianMean, "large", "small")

# Q5
table(df$asianAvg)
qplot(df$asianAvg)
