---


---

<h1 id="chap6.-데이터-정제">chap6. 데이터 정제</h1>
<h2 id="결측치-정제하기">1. 결측치 정제하기</h2>
<h3 id="결측치-확인">결측치 확인</h3>
<pre><code>table(is.na(df$score))
</code></pre>
<h3 id="결측치-제거">결측치 제거</h3>
<pre><code>df_nomiss &lt;- df %&gt;% filter(!is.na(score))
</code></pre>
<h3 id="여러-변수-동시에-결측치-제거">여러 변수 동시에 결측치 제거</h3>
<pre><code>df_nomiss &lt;- df %&gt;% filter(!is.na(score) $ !is.na(sex))
</code></pre>
<h3 id="함수의-결측치-제외-기능-이용하기">함수의 결측치 제외 기능 이용하기</h3>
<pre><code>mean(df$score, na.rm = T)
</code></pre>
<h2 id="이상치-정제하기">2. 이상치 정제하기</h2>
<h3 id="이상치-확인">이상치 확인</h3>
<pre><code>table(outlier$sex)
</code></pre>
<h3 id="결측-처리">결측 처리</h3>
<pre><code>outlier$sex &lt;- ifelse(outlier$sex == 3, NA, outlier$sex)
</code></pre>
<h3 id="boxplot으로-극단치-기준-찾기">boxplot으로 극단치 기준 찾기</h3>
<pre><code>boxplot(mpg$hwy)$stats
</code></pre>
<h3 id="극단치-결측-처리">극단치 결측 처리</h3>
<pre><code>mpg$hwy &lt;- ifelse(mpg$hwy &lt; 12 | mpg$hwy &gt; 37, NA, mpg$hwy)
</code></pre>

