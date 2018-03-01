---


---

<h1 id="chap10.-텍스트-마이닝">Chap10. 텍스트 마이닝</h1>
<h2 id="텍스트-마이닝-준비하기">텍스트 마이닝 준비하기</h2>
<ol>
<li>패키지 준비하기<pre class=" language-r"><code class="prism  language-r">install.packages<span class="token punctuation">(</span><span class="token string">"rJava"</span><span class="token punctuation">)</span>
install.packages<span class="token punctuation">(</span><span class="token string">"momoise"</span><span class="token punctuation">)</span>
install.packages<span class="token punctuation">(</span><span class="token string">"KoNLP"</span><span class="token punctuation">)</span>

library<span class="token punctuation">(</span>KoNLP<span class="token punctuation">)</span>
library<span class="token punctuation">(</span>dplyr<span class="token punctuation">)</span>
</code></pre>
</li>
<li>사전 설정하기<pre class=" language-r"><code class="prism  language-r">useNIADic<span class="token punctuation">(</span><span class="token punctuation">)</span>
</code></pre>
</li>
<li>데이터 준비하기<pre class=" language-r"><code class="prism  language-r">txt <span class="token operator">&lt;-</span> readLines<span class="token punctuation">(</span><span class="token string">"hiphop.txt"</span><span class="token punctuation">)</span>
head<span class="token punctuation">(</span>txt<span class="token punctuation">)</span>
</code></pre>
</li>
<li>특수문자 제거하기<pre class=" language-r"><code class="prism  language-r">install.packages<span class="token punctuation">(</span><span class="token string">"stringr"</span><span class="token punctuation">)</span>
library<span class="token punctuation">(</span>stringr<span class="token punctuation">)</span>
txt <span class="token operator">&lt;-</span> str_replace_all<span class="token punctuation">(</span>txt<span class="token punctuation">,</span> <span class="token string">"\\W"</span><span class="token punctuation">,</span> <span class="token string">" "</span><span class="token punctuation">)</span>
</code></pre>
</li>
</ol>
<h2 id="가장-많이-사용된-단어-알아보기">가장 많이 사용된 단어 알아보기</h2>
<ol>
<li>명사 추출하기<pre class=" language-r"><code class="prism  language-r"><span class="token comment"># 가사에서 명사 추출</span>
nouns <span class="token operator">&lt;-</span> extractNoun<span class="token punctuation">(</span>txt<span class="token punctuation">)</span>
<span class="token comment"># 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성</span>
wordcount <span class="token operator">&lt;-</span> table<span class="token punctuation">(</span>unlist<span class="token punctuation">(</span>nouns<span class="token punctuation">)</span><span class="token punctuation">)</span>
<span class="token comment"># 데이터 프레임으로 변환</span>
df_word <span class="token operator">&lt;-</span> as.data.frame<span class="token punctuation">(</span>wordcount<span class="token punctuation">,</span> stringsAsFactors <span class="token operator">=</span> F<span class="token punctuation">)</span>
<span class="token comment"># 변수명 수정</span>
df_word <span class="token operator">&lt;-</span> rename<span class="token punctuation">(</span>df_word<span class="token punctuation">,</span> 
                word <span class="token operator">=</span> Var1<span class="token punctuation">,</span>
                freq <span class="token operator">=</span> Freq<span class="token punctuation">)</span>
<span class="token comment"># 두 글자 이상 단어 추출</span>
df_word <span class="token operator">&lt;-</span> filter<span class="token punctuation">(</span>df_word<span class="token punctuation">,</span> nchar<span class="token punctuation">(</span>word<span class="token punctuation">)</span> <span class="token operator">&gt;=</span> <span class="token number">2</span><span class="token punctuation">)</span>
</code></pre>
</li>
<li>단어 빈도표 만들기<pre class=" language-r"><code class="prism  language-r"><span class="token comment"># 상위 20개 단어 추출</span>
top_20 <span class="token operator">&lt;-</span> df_word <span class="token percent-operator operator">%&gt;%</span>
arrange<span class="token punctuation">(</span>desc<span class="token punctuation">(</span>freq<span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token percent-operator operator">%&gt;%</span>
head<span class="token punctuation">(</span><span class="token number">20</span><span class="token punctuation">)</span>
top_20
</code></pre>
</li>
</ol>
<h2 id="워드-클라우드-만들기">워드 클라우드 만들기</h2>
<ol>
<li>워드 클라우드 패키지 설치<pre class=" language-r"><code class="prism  language-r">install.packages<span class="token punctuation">(</span><span class="token string">"wordcloud"</span><span class="token punctuation">)</span>

library<span class="token punctuation">(</span>wordcloud<span class="token punctuation">)</span>
library<span class="token punctuation">(</span>RColorBrewer<span class="token punctuation">)</span>
</code></pre>
</li>
<li>색상표 만들기<pre class=" language-r"><code class="prism  language-r"><span class="token comment"># Dark2 색상 목록에서 8개 생상 추출</span>
pal <span class="token operator">&lt;-</span> brewer.pal<span class="token punctuation">(</span><span class="token number">8</span><span class="token punctuation">,</span> <span class="token string">"Dark2"</span><span class="token punctuation">)</span>
</code></pre>
</li>
<li>워드 클라우드 만들기<pre class=" language-r"><code class="prism  language-r"><span class="token comment"># 난수 고정</span>
set.seed<span class="token punctuation">(</span><span class="token number">1234</span><span class="token punctuation">)</span>
<span class="token comment"># 워드 클라우드 만들기</span>
wordcloud<span class="token punctuation">(</span>words <span class="token operator">=</span> df_word<span class="token operator">$</span>word<span class="token punctuation">,</span>
      freq <span class="token operator">=</span> df_word<span class="token operator">$</span>freq<span class="token punctuation">,</span>
      min.freq <span class="token operator">=</span> <span class="token number">2</span><span class="token punctuation">,</span>
      max.words <span class="token operator">=</span> <span class="token number">200</span><span class="token punctuation">,</span>
      random.order <span class="token operator">=</span> F<span class="token punctuation">,</span>
      rot.per <span class="token operator">=</span> .<span class="token number">1</span><span class="token punctuation">,</span>
      scale <span class="token operator">=</span> c<span class="token punctuation">(</span><span class="token number">4</span><span class="token punctuation">,</span> <span class="token number">0.3</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
      colors <span class="token operator">=</span> pal<span class="token punctuation">)</span>
</code></pre>
<img src="https://github.com/heumsi/studying-on-R/blob/master/img/textMining.png?raw=true" alt="enter image description here"></li>
</ol>

