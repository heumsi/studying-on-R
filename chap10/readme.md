
# title: Chap10. 텍스트 마이닝

### 텍스트 마이닝 준비하기

#### 1. 패키지 준비하기
```{r}
install.packages("rJava")
install.packages("momoise")
install.packages("KoNLP")
library(KoNLP)
library(dplyr)
```

#### 2. 사전 설정하기
```{r}
useNIADic()
```

#### 3. 데이터 준비하기
```{r}
txt <- readLines("../hiphop.txt")
head(txt)
```

#### 4. 특수문자 제거하기
```{r}
install.packages("stringr", repos = "http://cran.us.r-project.org")
library(stringr)
txt <- str_replace_all(txt, "\\W", " ")
```

### 가장 많이 사용된 단어 알아보기

#### 1. 명사 추출하기

```{r}
# 가사에서 명사 추출
nouns <- extractNoun(txt)
# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))
# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
# 변수명 수정
df_word <- rename(df_word, 
                word = Var1,
                freq = Freq)
# 두 글자 이상 단어 추출
df_word <- filter(df_word, nchar(word) >= 2)
```

#### 2. 단어 빈도표 만들기
```{r}
# 이상치 확인
# 상위 20개 단어 추출
top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)
top_20
```

### 워드 클라우드 만들기

#### 1. 워드 클라우드 패키지 설치
```{r}
install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)
```

#### 2. 색상표 만들기
```{r}
# Dark2 색상 목록에서 8개 생상 추출
pal <- brewer.pal(8, "Dark2")
```

#### 3. 워드 클라우드 만들기
```{r}
# 난수 고정
set.seed(1234)
# 워드 클라우드 만들기
wordcloud(words = df_word$word,
      freq = df_word$freq,
      min.freq = 2,
      max.words = 200,
      random.order = F,
      rot.per = .1,
      scale = c(4, 0.3),
      colors = pal)
```

![enter image description here](https://github.com/heumsi/studying-on-R/blob/master/img/textMining.png?raw=true)