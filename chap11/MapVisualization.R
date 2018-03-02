# 패키지 준비하기
install.packages("ggiraphExtra")
library(ggiraphExtra)

##### 11-1. 미국 주별 강력 범죄율 단계 구분도 만들기 #####

# 데이터 준비하기
str(USArrests)
head(USArrests)

# tibble package 를 이용하여 row 를 가지고 col 변수 만들기
library(tibble)

crime <- rownames_to_column(USArrests, var = "state")
crime$state <- tolower(crime$state)
str(crime)

# ggplot2 package 내 state 데이터 가져오기
library(ggplot2)
states_map <- map_data("state")
str(states_map)

# 단계 구분도 만들기
ggChoropleth(data = crime,         # 지도에 표현할 데이터
             aes(fill = Murder,    # 색깔로 표현할 변수
                 map_id = state),  # 지역 기준 변수
             map = states_map,     # 지도 데이터
             interactive = T)      # 인터랙티브



##### 11-2. 대한민국 시도별 인구, 결핵 환자 수 단계 구분도 만들기 #####

# 패키지 준비하기
install.packages("stringi")
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")

library(kormaps2014)

# 데이터 준비하기
str(changeCode(korpop1))

library(dplyr)
korpop1 <- rename(korpop1,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)

# 인구 단계 구분도 만들기
ggChoropleth(data = korpop1,
             aes(fill = pop,
                 map_id = code,
                 tooltip = name),
             map = kormap1,
             interactive = T)

# 결핵 단계 구분도 만들기
str(changeCode(tbc))
ggChoropleth(data = tbc,
             aes(fill = NewPts,
                 map_id = code,
                 tooltip = name),
             map = kormap1,
             interactive = T)
