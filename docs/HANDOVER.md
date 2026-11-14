# 인수인계 · Cell Culture Log 기능 추가 6개 (2026-11-06 시작)

> 다른 Claude 계정이 이어서 할 때: **이 파일부터 읽고**, 작업이 끝나면 아래 「진행 상황」 표와 「작업 기록」을 고친 뒤 커밋·푸시.
> 같은 내용 요약이 Notion 「🤖 Claude 작업 기록」(BICS STAR LAB 아래) 맨 위에도 있음.

- 저장소: `zipipo/zipipo_organoids`, 앱은 `index.html` 한 파일 (Cell Culture Log, Firebase 동기화 + localStorage)
- 작업 브랜치: `claude/beautiful-curie-6lto4e`
- LN2 Explorer 원본: `tools/ln2/LN2_Tank_Explorer.html` (유진이 올린 파일 그대로)
- LN2 엑셀 최신: `LN2_tank_STARLAB_ver_462_2026.11.05_YJ.xlsx` (환자 정보가 있어 저장소에 안 올림 → 유진에게 다시 받기)

## 진행 상황

| # | 기능 | 상태 | 메모 |
|---|------|------|------|
| 0 | 요구사항 정리 · 방법 조사 · 인수인계 | ✅ 끝 | 이 문서 |
| 4a | LN2 Explorer가 최신 엑셀(ver 462)을 맞게 읽는지 확인 | ✅ 끝 | 아래 「4번 확인 결과」 |
| 1 | 인큐베이터 (옆면 박스) | ✅ 끝 | **사이드바 왼쪽 아래**(테마 설정 위), 테마 색 변수로 파스텔 단색 (그라데이션 없음) `renderIncubator()`, 「○○의 인큐베이터」 닉네임은 이름 누르면 바꿈(localStorage `orgNick`, 동기화 안 함), `plateKind()`가 plate 글자를 well/dish/flask로 묶음, well plate는 well ÷ 칸 수 올림으로 장 수 |
| 2 | 이번 주 실험 정리 (분석 탭 맨 위) | ✅ 끝 | `buildThisWeek()`, 요일별 액션 블럭 + 지난주 대비 + 남은 예정. 작업량 추이 · 요일별을 그 아래로 올림 |
| 3 | 다이어리 (먼슬리 · 위클리) | ✅ 끝 | 사이드바 「다이어리」 탭, `renderDiary()`. 먼슬리 날짜 누르면 그 주 위클리. 손글씨 폰트 Gaegu (Google Fonts, 다이어리 열 때 불러옴). 메모는 기록 memo만 |
| 4b | LN2 탭: 조건 검색 · 사람별 · Pair · 위치 | ✅ 끝 | 사이드바 「도구 › LN2 탱크」. Explorer는 index.html 맨 아래 `<template id="ln2Tpl">` 안 (iframe srcdoc). 사람 · 종류 · 날짜 · 최대 passage 조건, 내 것만(이니셜), 카드마다 📍 위치 + 「박스에서 보기」 미니 지도, 마지막 파일 IndexedDB 기억, 파일 바꾸기 |
| 5 | Stock vial 드래그 → 엑셀 ver+1 다운로드 | ✅ 끝 | LN2 탱크 › 「🧊 Stock 넣기」. 앱 Stock 기록(vial 수)을 cryovial 그림으로, 시트 · 박스 골라 빈 칸에 드래그(또는 눌러서 고르고 칸 누르기). Cell information 줄 자동 채움(Full name · Catalog는 예전 줄에서 추정, 고칠 수 있음). JSZip으로 칸 XML만 고침 → openpyxl로 원본과 비교해 바뀐 칸 말고 값 · 서식 · 병합 같음 확인. 파일 이름 ver+1 · 오늘 날짜 · 이니셜. 내려받으면 앱 Stock 후처리 LN2 · DB 체크, 새 파일로 다시 불러옴 |
| 6 | 홈 화면 펫 (다마고치) | ✅ 끝 | **50종**(세포 · 오가노이드, `PET_KINDS` + `petGrid` 모양 함수, 원래 8종 포함), **하루 1번 뽑기**(희귀도 ★1~3, 아직 없는 친구 우선), 도감은 못 만난 칸 「?」(비공개), 여러 마리 키우기 · 산책 최대 3마리. **화면 네 모서리를 따라 걷기**(`petPos(s)` 둘레 좌표), 누르면 메뉴(멈추기/움직이기 · 밥 주기 · 쓰다듬기 · 설정), 끌어서 옮기기(가까운 가장자리에 붙음), 눈 천천히 깜빡 · 가끔 점프, 똥 3시간에 1번, 꽃 1시간에 1번쯤. 상태 localStorage `orgPets` (동기화 안 함) |
| 7 | 설정 창 (Claude 설정처럼 왼쪽 탭) | ✅ 끝 | 사이드바 「설정」 → 모양(파스텔 · 다크 · 모노) · 글씨체(손글씨 7종 + 귀여운 네모 5종(나눔스퀘어라운드 · 티머니 둥근바람 · 해바라기 · 동글 · 주아) + 숨은 예쁜 글씨체 7종(스타일리시 · 오르빗 · 싱글데이 · 고운바탕 · 디필레이아 · 그랜디플로라 · 갈무리). 나눔손글씨 펜 · 교보 · 카페24 · 도현은 유진이 싫어함, 넣지 않기, 카드 미리보기) · 홈 화면(Incubator · 펫 보이기) · 펫 · LN2(이니셜) · 우체통 |
| 8 | 그림 배경 매주 자동 | ✅ 끝 | `weeklyArt()`: 2026-01-05 기준 주 번호로 `ART_ROTA` 17종 돌림(2026-11-07에 달팽이 · 나무 · 클로버 · 연필 · 도토리 · 만두 · 지구 추가), 2026-11-02 주 = 바다부터 시작, 12/18~26 크리스마스. 파스텔 테마에서만. **고르는 UI 없음, 이번 주/다음 주도 화면에 안 보여줌(비공개)** |
| 9 | 업데이트 안내 팝업 | ✅ 끝 | `NEWS` (id · date · days:5 · items). 5일 동안 열 때마다, 「다시 보지 않기」면 그 id는 안 뜸. 새 기능 올릴 때 NEWS만 바꾸기. 설정 › 새로 생긴 기능으로 다시 보기 |
| 10 | 우체통 | 🟡 코드 끝, **Firestore 규칙 필요** | 설정 › 우체통. Google 로그인한 사람만 보냄(이름 · 이메일 저장). 받은 편지는 읽기 허용된 사람(관리자)에게만 보임, 안 읽은 수는 사이드바 설정 옆 |

추천 순서: **2 → 1 → 3 → 4b → 5 → 6** (2·1·3은 기존 데이터만 쓰면 돼서 빠름. 5는 4b의 엑셀 읽기 위에 얹음. 6은 독립적이라 아무 때나).

---

## 유진이 원하는 것 (원문 요약)

1. **인큐베이터** — 귀여운 인큐베이터 그림. plate 종류별로 옆으로 나란히, 위로 차곡차곡 쌓여서 지금 몇 장 키우는지 한눈에.
2. **이번 주 실험 정리** — 작업 분석 탭 맨 위로. 월요일에 split 몇 종류… 처럼 요일마다 블럭이 쌓이는 모양. 더 의미 있는 주간 정리.
3. **다이어리** — 연구노트 인쇄용은 그대로 두고, 다이어리처럼 보는 화면 하나 더. 먼슬리 · 위클리. 실험 정리 페이지도 다이어리 느낌.
4. **LN2 tank** — 기존 Explorer가 최신 파일도 맞게 읽는지 확인 (✅). 앱 도구에 넣고, 자유 검색 + 조건 검색. 사람마다 키우는 게 다름 (YJ는 거의 HCC, 다른 사람은 다른 종류). Pair 찾기 등 기존 기능 유지. 박스에서 계산한 위치까지.
5. **Stock 넣기** — 내가 stock한 것(바이알 수 포함)을 cryovial 그림으로 → 원하는 박스 칸에 드래그 → Cell information 칸 쓰기 (이름은 자동). 원본 엑셀 디자인 그대로 다운로드, 파일 이름 버전 +1, 이니셜(YJ)은 한 번 저장해두면 계속.
6. **펫** — 홈 화면에 작은 픽셀아트 펫이 뚜벅뚜벅 돌아다님. 응가, 꽃 선물, 생활. 랜덤 뽑기로 펫 고르기 (세포가 걸어다니는 느낌 등). 쓰다듬기.

---

## 앱 구조 메모 (index.html)

- **LN2 Explorer 고칠 때**: index.html 맨 아래 `<template id="ln2Tpl">` 안을 고침 (`tools/ln2/LN2_Tank_Explorer.html`은 처음 받은 원본, 참고용). 앱 데이터는 Explorer에서 `parent.cclLn2` (getInitials · setInitials · getStocks · markDone)로 읽음.
- 테스트: CDN이 막힌 환경이면 `npm pack xlsx@0.18.5`, `npm pack jszip@3.10.1` 받아 Playwright `page.route`로 넣기 (catch-all abort 라우트를 **먼저** 등록해야 나중 라우트가 이김). `?demo`로 예시 데이터.
- 분석 · 다이어리 렌더는 스크립트 끝의 `window._lateReady` 뒤에만 (첫 로딩 때 TDZ 오류 막음).

- 탭: `setTab('today'|'tl'|'ana'|'arch')`, 탭별 표시는 CSS `body[data-tab=…] .pane[data-pane=…]`. 사이드바 버튼 1153줄 근처, 모바일 하단 탭 1327줄 근처.
- 데이터: `lines` (배양 라인), `logs` (기록: date, action, passage, plate, finalWells, stocks, memo …), `plans`. 저장은 `saveData()` → `cloudPushDebounced()`.
- 새로 저장할 설정이 있으면 기존처럼 `localStorage.setItem('org…')` + `cloudPushDebounced()` 패턴을 따르고, 동기화 대상(`localSync()`)에 넣을지 판단.
- 도움 함수: `latestPlate(l)`, `latestWell(l)`, `lineTag(l)`, `calcDayStr(l, date)`, `isPassageUp(action)`, `ACTIONS`, `typeColors` (종류별 색).
- 분석 탭: `renderAnalytics()` (6595줄 근처) — 패널을 `P(제목, 본문, 'ana-full')`로 쌓음. 맨 앞에 넣으면 맨 위에 보임.
- 연구노트 인쇄: `openNoteModal()`, `renderNoteList()` (6169줄 근처).
- 외부 스크립트는 CDN (cdnjs). 이 클라우드 환경은 CDN이 막혀 있어 테스트 때 `npm pack xlsx@0.18.5` 받아 Playwright `page.route`로 대신 넣음.

## 기능별 방법

### 1. 인큐베이터
- 데이터: 배양 중인 라인(`!isCompleted`)마다 `latestPlate(l)`, `latestWell(l)` → plate 종류(6/12/24/48/96 well, dish, flask …)별로 묶어 장 수 계산 (well 수 ÷ plate당 well, 올림).
- 화면: 인라인 SVG/CSS. 인큐베이터 문(유리창) 안에 선반, 종류별로 한 열, 위로 plate를 쌓음. plate 색 = 라인 종류 색(`typeColors`). 마우스 올리면 라인 이름 · P · d.
- 위치: 오늘 작업 탭 위쪽 또는 대시보드 카드. 한 장짜리라 다른 기능과 안 겹침.

### 2. 이번 주 실험 정리
- `renderAnalytics()` 맨 앞에 `P('이번 주', buildThisWeek(), 'ana-full')`.
- 월~일 7칸, 각 칸에 그날 기록을 액션별(Split, MC, Stock, Thaw …)로 블럭 쌓기 (블럭 하나 = 라인 하나, 색 = 라인 종류). 이전/다음 주 버튼.
- 아래 요약: 이번 주 split n개 라인 · stock 바이알 n개 · 총 well 변화 · 지난주 대비, 다음 주 split 예상(`buildNextSplit` 재사용), `plans`의 이번 주 예정.

### 3. 다이어리
- 새 화면(탭 또는 모달) 「다이어리」: 먼슬리(달력 칸마다 그날 액션 스티커 + 메모 한 줄) / 위클리(왼쪽 7일 칸, 오른쪽 메모 칸) 전환.
- 종이 질감 배경, 손글씨 느낌 폰트(Google Fonts, 예: Gaegu · Nanum Pen Script), 마스킹테이프 · 스티커 장식. 인쇄용(`openNoteModal`)은 건드리지 않음.
- 하루 메모를 따로 쓰게 할지 결정 필요 (아래 「정할 것」).

### 4b. LN2 탭
- `tools/ln2/LN2_Tank_Explorer.html`의 파싱 코드(`parseBigLine`, `findHeader`, `parseCellInfo`, `buildEntries`, `classifyEntry`, `extractHCC`, `computeMatchTable` …)를 index.html의 새 탭으로 옮김. 기존 요약 · 검색·매칭 · 박스별 보기 · 점검 내역 · PNG/PPT 내보내기 유지.
- 추가: 조건 검색 칩 — 사람(시트 이름의 이니셜 YW · DY · JH · HG · SY · HM · YJ + cell information의 「stock한 사람」), 종류(organoid, CAF, PF, cell line, tissue …), 환자 번호, passage 범위, 날짜 범위, Tumor/Adj(N)/margin. 「내 것만」 기본값 = 저장된 이니셜.
- 위치: 결과마다 `Black-LINE3 · 3-C 박스 · B행 4번` 처럼 탱크-LINE-박스-행-칸, 박스 미니맵에 표시.
- 엑셀은 매번 올리면 IndexedDB에 마지막 파일 보관 (다시 열 때 자동).

### 5. Stock vial 드래그 → 엑셀
- 바이알 목록: `logs` 중 Stock 액션 + `stocks`(바이알 수)에서, 아직 넣지 않은 것만. 바이알 수만큼 cryovial 그림.
- 박스 칸에 드래그 → 칸 글자 자동: 박스 칸 형식 `HCC39 T-B CAF p1\nthaw to 100pi\n26.11.02` (이름 / passage / 날짜 YY.MM.DD, 필요하면 메모 줄).
- Cell information 한 줄 자동 채움: STAR_ID(=박스 글자), Full name, Date, Passage, from, Catalog number(From), Information, 위치(`Orange-LINE3-C\nTumor-org_YJ 1\nB-4 (1 vial)`), stock한 사람(이니셜). 모르는 칸만 사용자가 씀.
- **원본 디자인 유지 방법**: SheetJS 무료판은 저장할 때 서식이 사라지므로 쓰지 않음. 엑셀(zip)을 JSZip으로 열어 `xl/worksheets/sheetN.xml`의 해당 `<c>`만 바꿈 — 이 파일은 sharedStrings 없이 inlineStr로 저장돼 있어 `<c r="E5" s="원래 스타일" t="inlineStr"><is><t xml:space="preserve">…</t></is></c>`로 넣으면 됨. Cell information 새 줄은 바로 윗줄의 `s` 스타일을 복사하고 `<dimension>` 갱신. 칸 줄바꿈은 `\n` 그대로.
- 파일 이름: `LN2_tank_STARLAB_ver_(\d+)_(YYYY.MM.DD)_(이니셜).xlsx` → 버전 +1, 날짜 = 오늘, 이니셜 = 저장값 (예: ver_463_2026.11.06_YJ).
- 확인: 다운로드한 파일을 openpyxl로 열어 바꾼 칸 말고는 원본과 같은지(셀 값 · 스타일 · 병합) 비교 테스트.

### 6. 펫
- 픽셀아트는 이미지 파일 없이 코드로 (작은 2차원 배열 → canvas, 또는 CSS box-shadow). 후보: 걸어다니는 세포, 오가노이드, 간세포, 분열하는 세포, 미토콘드리아, 피펫, 플라스크 친구 등 6~8종. 「뽑기」 버튼으로 랜덤.
- 행동: 2~4프레임 걷기, 가끔 멈춤 · 졸기 · 응가(클릭하면 치움) · 꽃 들고 와서 주기 · 클릭/드래그로 쓰다듬기(하트). 배고픔/기분 같은 상태는 localStorage.
- 크기 작게(약 32~48px), 화면 아래쪽에서만 움직이고 버튼을 가리지 않게 `pointer-events` 조심. 끄기 옵션. `prefers-reduced-motion`이면 덜 움직임.
- 특정 게임 캐릭터를 따라 만들지 않고 직접 디자인.

## 4번 확인 결과 (2026-11-06)

- Explorer에 ver 462 엑셀을 넣으면 오류 없이 읽음: **vial 3,056개, 박스 102개, LINE 10개, 사용날짜 매칭 926건**.
- 따로 셈한 값과 LINE별 개수 같음 (LINE 1 638, 2 300, 4 538, 5 74, 6 467, O1 41, O2 31, O3 384, O4 0). LINE 3은 박스가 12개(3-K 포함)라 583개 — Explorer가 맞게 셈.
- Explorer가 알아서 고친 것 5건: LINE 1 AB21~AE21 박스 밖 값 4개는 개수에서 빠짐; LINE 3 3-E · 3-F · 3-G 제목 병합 범위 어긋남; LINE 4 서식 잔여물로 16,381열.
- 엑셀 원본 특이사항: 「Black-LINE 3 JH」 시트에 `3-F` 라벨이 두 번(N3, A69) 있음 → 원본 확인 필요 (A69 쪽이 3-F? 다른 글자?).
- Cell information 「stock한 사람」: YW 222, JH 219, GY 139, YJ 91, HG 76, DY 45, HM 23, SY 18, HJ 14, AY 3 (+ 빈칸 26, 여러 명 표기 몇 개).

## 디자인 규칙 (유진 요청)

- **이모지 금지** (아이폰 기본 이모지 X). 아이콘은 `<svg class="ic"><use href="#i-…"/></svg>` 선 아이콘 (index.html 위쪽 `<symbol id="i-…">`에 추가). 아이폰에서 이모지로 바뀌는 기호(⚙ ⚠ ✂ ♥ ❄)도 쓰지 않기.
- 「반짝이 별(✦)」 아이콘은 쓰지 않기 (배경 그림 속 반짝이는 그대로 둠).
- 그라데이션 없이 파스텔 단색 (그림 배경의 「오묘한 파스텔」만 예외: 번지는 빛 그림). 색은 테마 변수(--bg --sur --psoft --pri --bd)로.
- 홈 화면은 복잡하지 않게: 꾸미기 · 설정은 설정 창 안으로.

## 광장 (2026-11-15부터 열림: `PLAZA_OPEN`, 그 전엔 설정 탭 · 프로필 · 선물 · 랩 마스코트 칸 모두 숨김)

## 광장 Firestore 규칙 (설정 › 광장이 동작하려면 Firebase 콘솔 › Firestore › 규칙에 추가)

```
match /players/{uid} {
  allow read: if request.auth != null;
  allow write: if request.auth != null && request.auth.uid == uid;
}
match /presents/{id} {
  allow create: if request.auth != null && request.resource.data.from == request.auth.uid;
  allow read: if request.auth != null && (resource.data.to == request.auth.uid || resource.data.from == request.auth.uid);
  allow update: if request.auth != null && resource.data.to == request.auth.uid
    && request.resource.data.diff(resource.data).affectedKeys().hasOnly(['claimed','claimedAt']);
}
```
- players: 별명 · 대표 세포 · 도감 수 · 도장깨기 · 이번 주 MC/Split 수만. 배양 기록 · 라인 이름 없음. 「광장에 나 보이기」 끄면 문서 삭제.
- presents: 꽃(하루 3번) · 세포(겹친 것만, 하루 1번). 받는 쪽이 열면 claimed.
- 랩 협동 목표: 이번 주(월요일부터) players의 mc 합이 300 넘으면 각자 「랩 마스코트」 도장깨기.

## 우체통 Firestore 규칙 (Firebase 콘솔 › Firestore › 규칙에 추가해야 동작)

```
match /mailbox/{id} {
  allow create: if request.auth != null && request.resource.data.uid == request.auth.uid;
  allow read, update, delete: if request.auth != null && request.auth.token.email == '관리자 Google 이메일';
}
```
- 관리자 이메일은 코드에 안 넣음 (규칙에만). 규칙이 없으면 보내기 할 때 「아직 우체통이 열리지 않았어요」.

## 유진이 정한 것 (2026-11-06)

- LN2 Explorer는 Cell Culture Log에 **합침**. 사이드바 「도구」(연구노트 인쇄 있는 곳)에 버튼 하나 추가해서 엶.
- 인큐베이터는 **옆면만**, 단순한 박스 모양으로 (선반에 plate가 옆으로 쌓인 단면).
- 다이어리 하루 메모는 **따로 안 씀** → 기존 기록(memo)만 보여줌.
- 바이알 드래그는 **올린 엑셀마다 박스 그리드를 불러와서** 거기에 드래그.
- 3 · 4 · 6번은 계획대로.

## 정할 것 (유진에게 물어볼 것)

3. 인큐베이터에 plate 종류가 이 앱에 어떻게 적혀 있는지 (예: "24 well", "6well", "100pi") — 실제 데이터에서 확인 후 묶는 규칙 정함.
4. Stock 바이알이 LN2에 이미 들어갔는지 표시할 방법 (앱 기록에 "LN2 위치" 저장).
5. 3-F 라벨 중복.

## 작업 기록

- 2026-11-14: PPT figure 편집 창 다듬기(유진 요청). ① Experiment Schedule: 줄(라인)마다 탭(`_figTrk`, `figTrkTab`), 고른 줄은 미리보기에 파란 점선 테두리(미리보기에서 줄을 눌러도 그 탭으로). Day 0을 줄마다 날짜로 정함(`t.zero`, 안 정하면 예전 전체 `sc.zero` → 전체 맨 앞 날짜). 줄끼리는 Day 0 자리를 맞춰 그림(날짜가 아니라 Day 기준 축). 직접 넣기는 날짜 대신 Day 숫자 → 날짜 계산(`figDayAdd`). ② Plate: 번호 단계 하나로(① Plate ② 고르기 ③ 조건 ④ 라인 ⑤ 글자), 따로 있던 「행 · 열 이름」 접기 칸 뺌. 행 글자(A) · 열 번호(1)를 누르면 그 줄을 고른 상태(`_figAxis`) → 조건 = 가로 · 세로 조건(`pl.rowC` · `pl.colC`, 줄 이름 옆에 색 점), 글자 = 줄 이름(`rowLab` · `colLab`). well 색은 well 조건 > 열 조건 > 행 조건(`figWellCond`). 「+ 농도 시리즈」는 「새 조건」 입력칸에 합침(쉼표로 여러 개면 한 색 진하기 차이), 「라인 빼기」는 같은 라인 · 조건을 한 번 더 누르면 빠지게. 고치는 plate도 점선 테두리. 아래 「한 장 기준 최대」 안내 글 뺌(넘으면 알림만). ③ 복사 · PNG에 고른 well 점선이 같이 찍히던 것 고침(`figRender(f,scale,live)`). 확인: Playwright로 일정 탭 · Day 추가 · 열 조건 · 행 이름 · 미리보기 클릭. PPT 내보내기는 이번에 따로 안 열어 봄.

- 2026-11-12(4): 사진 이름 · 스케일바 저장 중 「저장 취소」 버튼(`sbCancelSave`, 진행 화면 `#sbCancelBtn`). 쓰던 사진 한 장까지만 끝내고 멈춤, 이미 저장된 파일은 그대로 두고 사진 목록도 그대로. 취소하면 촬영 순서 자동 보관(`archiveShotOrderFromSbFiles`)은 안 함.

- 2026-11-12(3): 사진 이름 · 스케일바 창: 날짜 묶음 머리줄에 「순서 취소」(`sbClearGroupOrder`) 추가. 그 묶음 사진의 라인 · 특이사항 · 고른 순서(setId)만 비움, 사진 · 날짜 · 배율 · 색 보정은 그대로. 라인이 채워진 묶음에만 보임.

- 2026-11-12(2): PPT 사진 크기 통일(유진 요청). 사진은 원본 비율 그대로, 1 – 4열 장은 왼쪽(날짜 행 이름) · 위(날짜 줄, 열 이름)에 무엇을 쓰든 항상 같은 폭 약 7.3cm(`pptDrawMatrix`의 `W0`), 5열부터 열 수에 맞춰 줄어듦. 제목 바로 아래 · 왼쪽 위부터 채움(가운데 정렬 뺌). 사진 영역 여백 좌우 0.9cm(`PPTG.gridX`) · 아래 0.45cm. 환자별 열 개수를 정하면 그 열 수 기준 크기.

- 2026-11-12: PPT 슬라이드 배치를 personal meeting 자료(260921 · 261002 · 261030) 형식에 맞춤. ① 제목 = 「10.20 – 10.28  HCC39 Tumor-org C」 22pt + 아래 줄, 사진 시작 3.3cm, 좌우 여백 1.65cm (`PPTG`, `pptTitle`). ② 조건 없는 사진(예전 `kind:'grid'`)도 `matrix`로 그림(`pptGridPage`): 같은 날짜 열은 날짜 줄 하나로 묶고 열 이름은 well · 번호만. `pptDrawGrid` 삭제. ③ 미리보기 썸네일을 누르면 그 장을 바로 고침(`pptEdits[p.key]`, `pptEdStart` · `pptEdDropOn`, 그리기 함수가 `D.zone()`으로 끌 수 있는 칸을 같이 냄): 사진 끌어 옮기기 · 바꾸기 · Shift로 나란히, 열 · 날짜 묶음 · 행 끌기, 글자 눌러 고치기, × 빼기, + 열 · + 행, 안 넣은 사진 칸. 고친 것은 올린 사진이 그대로인 동안만 유지(세션), 열 순서만 `pptCuts['ord:제목']`으로 저장 · 동기화. ④ 고치는 장 위에 실험 배치 칩(날짜 · 조건을 슬라이드 나누기 / 열 / 행으로, 값 끌어 순서) = 규칙 없는 사진 배치 칩과 같은 방식(`pptExpChipsHtml`). ⑤ 제목 넣기/빼기(전체 `title:*`, 환자 `title:HCC37`, 장마다), 환자별 열 개수 `cols:HCC37` · 배치. 확인: Playwright로 끌기 · 고치기 · 내보내기 → LibreOffice로 열어 봄. 실제 현미경 사진 · PowerPoint에서는 아직 안 봄(확인 필요). 터치(휴대폰)는 사진 누르고 칸 누르기로만 옮겨짐.

- 2026-11-07(6) 전체 점검: PC(1366×768) · 휴대폰(iPhone 13)에서 모든 탭 · 다이어리 먼슬리/위클리 · 분석 패널 · Tree · 설정 6탭 · 글씨체/크기/테마 · 펫 · 새 기능 안내 · PPT 배치 3종 · 동기화 합치기 · CSV · LN2(ver 462 실제 파일: 검색 · 박스 · 요약 · Stock 넣기 → ver 463 내려받기) 돌려서 오류 0건. 내려받은 엑셀은 넣은 칸 1개 + Cell information 새 줄 말고 원본과 같음. LN2 엑셀은 이제 브라우저에 저장 안 함(새로고침 = 다시 올리기).

- 2026-11-07(5): 다이어리 · 작업 분석을 사이드바 「기록」 하나로 합침(제목 옆 [다이어리][분석], `recTab()` 마지막 본 쪽 `orgRecTab`), 사이드바 236→268px, 인큐베이터 plate 조금 크게. 인큐베이터 큰 창은 읽기 힘들다고 해서 뺌. 글씨체 · 글씨 크기 · 이니셜 · 내 라인은 `prefs`로 계정 동기화.

- 2026-11-07(4): PPT 「Data meeting 배치」(배치 미리보기 맨 위): 조건별(`mode 'cond'`, 조건마다 한 장 · 열 = 날짜) / 날짜별(`'page'`) / 자동. 조건이 이름에 든 사진은 환자 · 종류까지만 제목으로 자동 자름(pptCuts 값 'dm', 자동으로 돌리면 지움). 글씨체를 고딕 · 둥근 · 명조 · 또박 손글씨 · 귀여운 손글씨로 나누고 7종 뺌, 온글잎 의연(`noonfonts_2105/Uiyeun.woff`) 추가. 스스로넷 · 그리운 묘은또박은 주소 못 찾음.

- 2026-11-07(3): 분기 칩 깔끔하게(테두리 없이 이름만) · 「기록 n건」 뺌. Tree: Split한 날 나눈 라인은 앞 passage 칸에서 두 갈래로, MC 횟수 뺌. 작업 분석: 이번 주는 요일마다 한 줄 글로만, 나머지 패널은 접힘(`orgAnaOpen`에 기억). 다이어리 손글씨 = 온글잎 류뚱체(`2405-2/Ownglyph_ryuttung-Rg.woff2`), Week 제목 작게. LN2 Stock 넣기: cryovial 주황, Information = `Total: n vials`, Full name 추정은 종류 핵심 낱말로 한 번 더, 넣을 바이알 이름 고치기, 이니셜은 계정 동기화(`prefs.ini`).

- 2026-11-07(2): 손글씨에 온글잎 7종 추가(박다현 · 위씨리스트 · 콘콘 · 류뤼 · 은별 · 김콩해 · 데일리옥자, 새 눈누 저장소는 `projectnoonnu/2411-3`처럼 noonfonts_ 없이), 쿠키런 · 메이플스토리 뺌. 실제 ver 462 엑셀로 Stock 넣기 → 내려받기 확인: ver_463 파일, 바뀐 곳은 넣은 칸 1개 + Cell information 새 줄뿐(openpyxl 비교, 병합 · 서식 같음). 휴대폰에서 Stock 넣기 칸이 화면 밖으로 밀리던 것 고침.

- 2026-11-07: 글씨체를 눈누 폰트로 바꿈(깔끔한 · 손글씨 · 귀여운, `NN(repo,file)` = jsDelivr → GitHub raw 순서, 못 불러오면 카드 숨김), 설정 창 휴대폰 크기 · X 겹침 수정, 설정 설명 문구 정리. 다이어리 손글씨 = 어비 세현체, 먼슬리는 액션별 한 줄(휴대폰은 점), 위클리는 액션별 한 줄로 묶음. 작업 분석: MC · MA를 「Media Change」 하나로(이번 주 칸에 MC는 한 칸), 요일별 · 작업 캘린더 패널 뺌. Tree: passage마다 한 칸(Split 등에서 다음 칸, 분기는 그 passage 뒤). 펫: 계정 동기화(`pets`, 위치 · 기분 제외), 산책 최대 5마리, 펫 층을 상단바 위로(z 160), 응가는 3시간마다 쌓임(펫마다 최대 9). LN2: 탭 순서 Stock 넣기 → 검색 → 박스 → 요약(점검 내역은 요약 아래 접힘), 검색 조건 간결화(HCC 매칭 카테고리 · LINE · 박스 · 최소 vial 숨김), 넣을 바이알 = 오늘 작업 「Stock 후처리」(stockChecks) 그대로.

- 2026-11-06: 요구사항 정리, 방법 조사, LN2 Explorer ver 462 확인, 이 문서 작성. 코드 변경 없음.
