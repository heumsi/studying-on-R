# 패키지 설치
install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")

# 패키지 로드
library(KoNLP)
library(dplyr)

useNIADic() # 형태소 사전 사용


##### 10-1. 힙합 가사 텍스트 마이닝 #####

# 데이터 불러오기
txt <- readLines("hiphop.txt")
head(txt)

# 특수문자 제거하기
install.packages("stringr")
library(stringr)

txt <- str_replace_all(txt, "\\W", " ")

# 명사 추출하기
extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한")

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

# 상위 20개 단어 추출
top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)
top_20

# 워드 클라우드 패키지 설치
install.packages("wordcloud")

library(wordcloud)
library(RColorBrewer)

# Dark2 색상 목록에서 8개 생상 추출
pal <- brewer.pal(8, "Dark2")

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

# Blues 색상 목록으로 변경
pal <- brewer.pal(9, "Blues")[5:9]
set.seed(1234)

wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 2,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(4, 0.3),
          colors = pal)




##### 10-2. 국정원 트윗 텍스트 마이닝 #####
# 데이터 로드
twitter <- read.csv("twitter.csv",
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = "UTF-8")

# 변수명 수정
twitter <- rename(twitter,
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용)

# 특수문자 제거
twitter$tw <- str_replace_all(twitter$tw, "\\W", " ")
head(twitter$tw)

# 단어 빈도표 만들기
nouns <- extractNoun(twitter$tw)
wordcount <- table(unlist(nouns))
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

# 두 글자 이상 단어만 추출
df_word <- filter(df_word, nchar(word) >= 2)

# 상위 20개 추출
top20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)
top20

# 단어 빈도 막대 그래프 만들기
library(ggplot2)
order <- arrange(top20, freq)$word

ggplot(data = top20, aes(x = word, y = freq)) +
  ylim(0, 2500) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limit = order) +
  geom_text(aes(label = freq), hjust = -0.3)


# 워드 클라우드 만들기
pal <- brewer.pal(8, "Dark2")
set.seed(1234)

wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 10,
          maxwords = 200,
          random.order = F,
          rot.per = .1,
          scale = c(6, 0.2),
          colors = pal)

pal <- brewer.pal(9, "Blues")[5:9]
set.seed(1234)

wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 10,
          maxwords = 200,
          random.order = F,
          rot.per = .1,
          scale = c(6, 0.2),
          colors = pal)
