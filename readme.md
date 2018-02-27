---


---

<h1 id="studying-on-r">Studying on R</h1>
<h2 id="r-공부-중">2018.02.21 ~ R, 공부 중</h2>
<ul>
<li>R 공부 입문을 하며, 현재 ‘Do it 쉽게 배우는 R 데이터 분석 - 김영우’ 로 공부하고 있습니다.</li>
<li>김영우님의 Github에 공유된 내용만 허락을 받고 올렸습니다.</li>
<li>김영우님의 Github 주소 : <a href="https://github.com/youngwoos/Doit_R">https://github.com/youngwoos/Doit_R</a></li>
</ul>
<h2 id="대용량-파일-100mb-이상-push-하는-법">대용량 파일 (100mb 이상) push 하는 법</h2>
<p>공부 중, 사용하는 데이터인 Koweps_hpc10_2015_beta1.sav 를 올려야 하는데, 이게 100mb 이상이라 github origin master 로 push가 안된다. 그래서 아래와 같이 해결했다.</p>
<ol>
<li>rsa key 발행 및 ssh 설정</li>
</ol>
<ul>
<li><a href="https://git-scm.com/book/ko/v2/Git-%EC%84%9C%EB%B2%84-SSH-%EA%B3%B5%EA%B0%9C%ED%82%A4-%EB%A7%8C%EB%93%A4%EA%B8%B0#_generate_ssh_key">https://git-scm.com/book/ko/v2/Git-서버-SSH-공개키-만들기#_generate_ssh_key</a></li>
<li><a href="https://git-scm.com/book/ko/v2/GitHub-%EA%B3%84%EC%A0%95-%EB%A7%8C%EB%93%A4%EA%B3%A0-%EC%84%A4%EC%A0%95%ED%95%98%EA%B8%B0">https://git-scm.com/book/ko/v2/GitHub-계정-만들고-설정하기</a></li>
</ul>
<ol start="2">
<li>git-lfs 설치 및  bfg-repo-cleaner 실행</li>
</ol>
<ul>
<li><a href="https://medium.com/@stargt/github%EC%97%90-100mb-%EC%9D%B4%EC%83%81%EC%9D%98-%ED%8C%8C%EC%9D%BC%EC%9D%84-%EC%98%AC%EB%A6%AC%EB%8A%94-%EB%B0%A9%EB%B2%95-9d9e6e3b94ef">https://medium.com/@stargt/github에-100mb-이상의-파일을-올리는-방법-9d9e6e3b94ef</a></li>
<li><a href="https://rtyley.github.io/bfg-repo-cleaner/">https://rtyley.github.io/bfg-repo-cleaner/</a></li>
</ul>
<ol start="3">
<li>git push origin master 재시도</li>
</ol>
<p>처음하면 생각보다 번거로운데, 위 순대로 하나씩 하면 된다.</p>

