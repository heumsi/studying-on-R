##### 15-3. 데이터 구조 #####

### 데이터 구조 비교하기
# Vector
a <- 1
a

b <- "hello"
b

class(a)
class(b)

# Data.frame
x1 <- data.frame(var1 = c(1, 2, 3),
                 var2 = c("a", "b", "c"))
x1
class(x1)

# Matrix
x2 <- matrix(c(1:12), ncol = 2)
x2
class(x2)

# Array
x3 <- array(1:20, dim = c(2, 5, 2))
x3
class(x3)

# List
x4 <- list(f1 = a,  # 벡터
           f1 = x1, # 데이터 프레임
           f3 = x2, # 매트릭스
           f4 = x3) # 어레이
x4
class(x4)


# List example.
mpg <- ggplot2::mpg
x <- boxplot(mpg$cty)
x

x$stats[, 1]        # 요약 통계량 추출
x$stats[, 1][3]     # 중앙값 추출
x$stats[, 1][2]     # 1분위수 추출
