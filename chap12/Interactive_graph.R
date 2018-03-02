install.packages("plotly")
library(plotly)

library(ggplot2)
p <- ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) + geom_point()

ggplotly(p)


##### 12-2. dygraphs 패키지로 인터렉티브 시게열 그래프 만들기 #####

install.packages("dygraphs")
library(dygraphs)

economics <- ggplot2::economics
head(economics)

# xts 타입(시간 순서 속성)으로 변경
library(xts)
eco <- xts(economics$unemploy, order.by = economics$date)
head(eco)

# 인터렉티브 시계열 그래프 만들기
dygraph(eco)

# 날짜 범위 선택 기능
dygraph(eco) %>% dyRangeSelector()

## 여러 값 표현하기
# 저축률
eco_a <- xts(economics$psavert, order.by = economics$date)
# 실업자 수
eco_b <- xts(economics$unemploy/1000, order.by = economics$date)

# 데이터 결합
eco2 <- cbind(eco_a, eco_b)
# 변수명 바꾸기
colnames(eco2) <- c("psavert", "unemploy")
head(eco2)

# 그래프 만들기
dygraph(eco2) %>% dyRangeSelector()
