##### 13-2. t 검정 - 두 집단의 평균 비교 #####

mpg <- as.data.frame(ggplot2::mpg)

library(dplyr)

# class와 cty 변수만 추출
mpg_diff <- mpg %>%
  select(class, cty) %>%
  filter(class %in% c("compact", "suv"))

head(mpg_diff)
table(mpg_diff)

# t 검정
t.test(data = mpg_diff, cty ~ class, var.equal = T)



##### 13-3. 상관분석 - 두 변수의 관계성 분석 #####

economics <- as.data.frame(ggplot2::economics)

# 상관분석
cor.test(economics$unemploy, economics$pce)

## 상관행렬 히트맵 만들기
head(mtcars)

# 상관행렬 생성
car_cor <- cor(mtcars)
round(car_cor, 2)

install.packages("corrplot")
library(corrplot)

corrplot(car_cor)
corrplot(car_cor, method = "number")

col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(car_cor,
         method = "color",      # 색깔로 표현
         col = col(200),        # 색상 200개 선정
         type = "lower",        # 왼쪽 아래 행렬만 표시
         order = "hclust",      # 유사한 상관계수끼리 군집화
         addCoef.col = "black", # 상관계수 색깔
         tl.col = "black",      # 변수명 색깔
         tl.srt = 45,           # 변수명 45도 기울임
         diag = F)              # 대각 행렬 제외
