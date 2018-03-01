---


---

<h1 id="chap9.-데이터-분석-프로젝트">Chap9. 데이터 분석 프로젝트</h1>
<h2 id="데이터-분석-준비하기">데이터 분석 준비하기</h2>
<ol>
<li>
<p>데이터 준비하기</p>
<pre class=" language-r"><code class="prism  language-r">Koweps_hpc10_2015_beta.sav
</code></pre>
</li>
<li>
<p>패키지 설치 및 로드하기</p>
<pre class=" language-r"><code class="prism  language-r">install.package<span class="token punctuation">(</span><span class="token string">"foreign"</span><span class="token punctuation">)</span>

library<span class="token punctuation">(</span>foreign<span class="token punctuation">)</span>	<span class="token comment"># SPSS 파일 불러오기</span>
library<span class="token punctuation">(</span>dply<span class="token punctuation">)</span>		<span class="token comment"># 전처리</span>
library<span class="token punctuation">(</span>ggplot2<span class="token punctuation">)</span>	<span class="token comment"># 시각화</span>
library<span class="token punctuation">(</span>readxl<span class="token punctuation">)</span>		<span class="token comment"># 엑셀 파일 불러오기</span>
</code></pre>
</li>
<li>
<p>데이터 불러오기</p>
<pre class=" language-r"><code class="prism  language-r">raw_welfare <span class="token operator">&lt;-</span> read.spss<span class="token punctuation">(</span>file <span class="token operator">=</span> <span class="token string">"Koweps_hpc10_2015_beta.sav"</span><span class="token punctuation">,</span> to.data.frame <span class="token operator">=</span> T<span class="token punctuation">)</span>
welfare <span class="token operator">&lt;-</span> raw_welfare
</code></pre>
<p>이때 주의할 부분은, read 할 file 의 경로가 R studio project 파일 기준이라는 점이다. file을 열 수 없다고 나오면, 꼭 data file을 프로젝트 최상위 폴더에 두고 다시 해보자.</p>
</li>
<li>
<p>데이터 검토하기</p>
<pre class=" language-r"><code class="prism  language-r">head<span class="token punctuation">(</span>welfare<span class="token punctuation">)</span>
tail<span class="token punctuation">(</span>welfare<span class="token punctuation">)</span>
View<span class="token punctuation">(</span>welfare<span class="token punctuation">)</span>
dim<span class="token punctuation">(</span>welfare<span class="token punctuation">)</span>
str<span class="token punctuation">(</span>welfare<span class="token punctuation">)</span>
summary<span class="token punctuation">(</span>welfare<span class="token punctuation">)</span>
</code></pre>
</li>
<li>
<p>변수명 바꾸기<br>
보통 데이터는 ‘코드북’ 과 함께 제공된다. 코드북을 통해,  각각의 변수명이 무엇을 의미하는지 파악하고, 어떤 변수를 쓸지 생각할 수 있다.</p>
<pre class=" language-r"><code class="prism  language-r">welfare <span class="token operator">&lt;-</span> rename<span class="token punctuation">(</span>welfare<span class="token punctuation">,</span>
              sex <span class="token operator">=</span> h10_g3<span class="token punctuation">,</span>
              birth <span class="token operator">=</span> h10_g4<span class="token punctuation">,</span>
              marriage <span class="token operator">=</span> h10_g10<span class="token punctuation">,</span>
              religion <span class="token operator">=</span> h10_g11<span class="token punctuation">,</span>
              income <span class="token operator">=</span> p1002_8aq1<span class="token punctuation">,</span>
              code_job <span class="token operator">=</span> h10_eco9<span class="token punctuation">,</span>
              code_region <span class="token operator">=</span> h10_reg7<span class="token punctuation">)</span>
</code></pre>
</li>
</ol>
<h2 id="데이터-분석-절차">데이터 분석 절차</h2>
<p>일단 어떤 '변수’를 가지고 어떤 ‘변수’ 를 파악할 것인지에 대해 생각해야 한다. 예를들면, '성별’에 따른 ‘월급’ 분석의 경우를 생각해보자.</p>
<ol>
<li>
<p>변수 검토 및 전처리<br>
a. 변수 검토하기</p>
<pre class=" language-r"><code class="prism  language-r">	class<span class="token punctuation">(</span>welfare<span class="token operator">$</span>sex<span class="token punctuation">)</span>	<span class="token comment"># 변수 타입 파악</span>
	table<span class="token punctuation">(</span>welfare<span class="token operator">$</span>sex<span class="token punctuation">)</span>	<span class="token comment"># 변수 값 분포 파악</span>
	<span class="token comment">##</span>
	<span class="token comment">## "numeric"</span>
	<span class="token comment">## 	   1    2</span>
	<span class="token comment">##	7578 9086</span>
</code></pre>
<p>b. 전처리</p>
<pre class=" language-r"><code class="prism  language-r"><span class="token comment"># 이상치 확인</span>
table<span class="token punctuation">(</span>welfare<span class="token operator">$</span>sex<span class="token punctuation">)</span>
<span class="token comment"># 이상치 결측 처리</span>
welfare<span class="token operator">$</span>sex <span class="token operator">&lt;-</span> ifelse<span class="token punctuation">(</span>welfare<span class="token operator">$</span>sex <span class="token operator">==</span> <span class="token number">9</span><span class="token punctuation">,</span> <span class="token keyword">NA</span><span class="token punctuation">,</span> welfare<span class="token operator">$</span>sex<span class="token punctuation">)</span>
<span class="token comment"># 결측치 확인</span>
table<span class="token punctuation">(</span>is.na<span class="token punctuation">(</span>welfare<span class="token operator">$</span>sex<span class="token punctuation">)</span><span class="token punctuation">)</span>

<span class="token comment">##</span>
<span class="token comment">## FALSE</span>
<span class="token comment">## 16664</span>
</code></pre>
<p>변수 값에 대해 알아보기 쉬운 이름을 주자.</p>
<pre class=" language-r"><code class="prism  language-r"><span class="token comment"># 성별 항목 이름 부여</span>
welfare<span class="token operator">$</span>sex <span class="token operator">&lt;-</span> ifelse<span class="token punctuation">(</span>welfare<span class="token operator">$</span>sex <span class="token operator">==</span> <span class="token number">1</span><span class="token punctuation">,</span> <span class="token string">"male"</span><span class="token punctuation">,</span> <span class="token string">"female"</span><span class="token punctuation">)</span>
table<span class="token punctuation">(</span>welfare<span class="token operator">$</span>sex<span class="token punctuation">)</span>

<span class="token comment">##</span>
<span class="token comment">## female male</span>
<span class="token comment">## 9086   7578</span>
</code></pre>
</li>
</ol>
<p>‘성별’ 변수에 관해 처리 했으니, 마찬가지로 ‘월급’ 변수에 대해서도 같은 처리를 해줘야 한다.</p>
<ol start="2">
<li>변수 간 관계 분석<br>
a. 평군표 만들기<pre class=" language-r"><code class="prism  language-r">sex_income <span class="token operator">&lt;-</span> welfare <span class="token percent-operator operator">%&gt;%</span>
	filter<span class="token punctuation">(</span><span class="token operator">!</span>is.na<span class="token punctuation">(</span>income<span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token percent-operator operator">%&gt;%</span>
	group_by<span class="token punctuation">(</span>sex<span class="token punctuation">)</span> <span class="token percent-operator operator">%&gt;%</span>
	summarise<span class="token punctuation">(</span>mean_income <span class="token operator">=</span> mean<span class="token punctuation">(</span>income<span class="token punctuation">)</span><span class="token punctuation">)</span>
sex_income

<span class="token comment">##</span>
<span class="token comment">## 	 sex  mean_income</span>
<span class="token comment">##  &lt;chr&gt;	    &lt;dbl&gt;</span>
<span class="token comment">## female	 163.2471</span>
<span class="token comment">##	 male	 312.2932</span>
</code></pre>
b. 그래프 만들기<pre class=" language-r"><code class="prism  language-r">ggplot<span class="token punctuation">(</span> data <span class="token operator">=</span> sex_income<span class="token punctuation">,</span> aes<span class="token punctuation">(</span>x <span class="token operator">=</span> sex<span class="token punctuation">,</span> y <span class="token operator">=</span> mean_income<span class="token punctuation">)</span><span class="token punctuation">)</span> <span class="token operator">+</span> geom_col<span class="token punctuation">(</span><span class="token punctuation">)</span>
</code></pre>
</li>
</ol>

