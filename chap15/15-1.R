exam <- read.csv("csv_exam.csv")

# 행 읽기
exam[]
exam[1, ]
exam[2, ]

# 특정 행 읽기
exam[exam$class == 1, ]
exam[exam$math >= 80, ]
exam[exam$class == 1 & exam$math >= 50, ]
exam[exam$english < 90 | exam$science < 50, ]

# 열 읽기
exam[, 1]
exam[, 2]
exam[, 3]

# 특정 열 읽기
exam[, "class"]
exam[, "math"]
exam[, c("class", "math", "english")]

# 특정 행, 열 읽기
exam[1, 3]
exam[5, "english"]
exam[exam$math >= 50, "english"]
exam[exam$math >= 50, c("english", "science")]



### Q. 수학 50점 이상, 영어 80점 이상인 학생들을 대상으로
###    각 반의 전 과목 평균을 구하라.

# 내장함수 이용
exam$tot <- (exam$math + exam$english + exam$science) / 3
aggregate(data = exam[exam$math >= 50 & exam$english >= 80, ], tot~class, mean)

# dplyr 이용
library(dplyr)
exam %>%
  filter(math >= 50 & english >= 80) %>%
  mutate(tot = (math + english + science) / 3) %>%
  group_by(class) %>%
  summarise(mean = mean(tot))
