chap9. 데이터 분석 프로젝트
================

### 데이터 분석 준비하기

#### 1. 데이터 준비하기

``` r
Koweps_hpc10_2015_beta.sav
```

#### 2. 패키지 설치 및 로드하기

``` r
install.packages("foreign", repos = "http://cran.us.r-project.org")
```

    ## Installing package into 'C:/Users/Jeon/Documents/R/win-library/3.4'
    ## (as 'lib' is unspecified)

    ## package 'foreign' successfully unpacked and MD5 sums checked
    ## 
    ## The downloaded binary packages are in
    ##  C:\Users\Jeon\AppData\Local\Temp\RtmpaQgaq2\downloaded_packages

``` r
library(foreign)    # SPSS 파일 불러오기
library(dplyr)      # 전처리
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(ggplot2)    # 시각화
library(readxl)     # 엑셀 파일 불러오기
```

#### 3. 데이터 불러오기

``` r
raw_welfare <- read.spss(file = "../Koweps_hpc10_2015_beta1.sav", to.data.frame = T)
welfare <- raw_welfare
```

이때 주의할 부분은, read 할 file 의 경로가 R studio project 파일 기준이라는 점이다. file을 열 수 없다고 나오면, 꼭 data file을 프로젝트 최상위 폴더에 두고 다시 해보자.

#### 4. 데이터 검토하기

``` r
head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)
```

#### 5. 변수명 바꾸기

보통 데이터는 ‘코드북’ 과 함께 제공된다. 코드북을 통해, 각각의 변수명이 무엇을 의미하는지 파악하고, 어떤 변수를 쓸지 생각할 수 있다.

``` r
welfare <- rename(welfare,
              sex = h10_g3,
              birth = h10_g4,
              marriage = h10_g10,
              religion = h10_g11,
              income = p1002_8aq1,
              code_job = h10_eco9,
              code_region = h10_reg7)
```

### 데이터 분석 절차

일단 어떤 '변수’를 가지고 어떤 ‘변수’ 를 파악할 것인지에 대해 생각해야 한다. 예를들면, '성별’에 따른 ‘월급’ 분석의 경우를 생각해보자.

#### 1. 변수 검토 및 전처리

##### a. 변수 검토하기

``` r
class(welfare$sex)  # 변수 타입 파악
```

    ## [1] "numeric"

``` r
table(welfare$sex)  # 변수 값 분포 파악
```

    ## 
    ##    1    2 
    ## 7578 9086

##### b. 전처리

``` r
# 이상치 확인
table(welfare$sex)
```

    ## 
    ##    1    2 
    ## 7578 9086

``` r
# 이상치 결측 처리
welfare$sex <- ifelse(welfare$sex == 9, NA, welfare$sex)
# 결측치 확인
table(is.na(welfare$sex))
```

    ## 
    ## FALSE 
    ## 16664

변수 값에 대해 알아보기 쉬운 이름을 주자.

``` r
# 성별 항목 이름 부여
welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)
```

    ## 
    ## female   male 
    ##   9086   7578

‘성별’ 변수에 관해 처리 했으니, 마찬가지로 ‘월급’ 변수에 대해서도 같은 처리를 해줘야 한다.

#### 2. 변수 간 관계 분석

##### a. 평균표 만들기

``` r
sex_income <- welfare %>%
    filter(!is.na(income)) %>%
    group_by(sex) %>%
    summarise(mean_income = mean(income))
sex_income
```

    ## # A tibble: 2 x 2
    ##   sex    mean_income
    ##   <chr>        <dbl>
    ## 1 female         162
    ## 2 male           312

##### b. 그래프 만들기

``` r
ggplot( data = sex_income, aes(x = sex, y = mean_income)) + geom_col()
```

![](readme_files/figure-markdown_github/unnamed-chunk-10-1.png)
