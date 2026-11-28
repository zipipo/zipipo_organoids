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
| 10 | 우체통 | ✅ 끝 (2026-11-28 메일 연결) | 설정 › 우체통. 보내면 Firestore `mailbox`에 저장하고 `MAIL_HOOK`(유진 계정 Apps Script 웹 앱)으로도 보내 유진에게 메일이 감. Google 로그인한 사람만 보냄(이름 · 이메일 저장). 받은 편지는 읽기 허용된 사람(관리자)에게만 보임, 안 읽은 수는 사이드바 설정 옆 |
| 11 | 셀 카운터 | ✅ 끝 (11-28) | 사이드바 도구 › 셀 카운터 (`renderCnt`, 탭 `cnt`). 계산은 `cntCompute(st, purps)` 하나에 모음 |
| 14 | 칭찬 도장판(꺼 둠 `STAMP_ON`) · 사진 폴더 나누기 · 오늘 작업 실험 기록 · 세포 · 광장 한 창 | ✅ 끝 (11-28) | 아래 작업 기록 2026-11-28(5) |
| 12 | 라인별 Plate map → PPT | ✅ 끝 (11-28, 유진: 기록마다 · PPT 시간순) | 기록 표 Plate 칸 `lmapBtn` → `lmapOpen(logId)`, Figure `src:{lineId,logId}`, 라인 머리 「Map PPT n」 `lmapPpt`. 아래 설계안 그대로, PPT는 (나) 시간순만 |
| 13 | MC 주기 (종류별 · 라인별) | ✅ 끝 (11-28) | 설정 › MC 주기, `mcRuleOf(line)` → `mcDays` · `selectMcNeeded` · 배양 현황 숫자 · MC 버튼 색. 저장 `orgMcRule` ↔ prefs `mcr`, 라인 `mcW` · `mcD` |

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
- **화면에 구구절절 설명 글 넣지 않기** (11-28 유진: 보너스 뽑기 받는 법 긴 줄을 싫어함). 버튼 · 숫자만, 설명은 NEWS 한 줄 정도.

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
- presents: 세포(겹친 것만, 하루 1번). 받는 쪽이 열면 claimed. (꽃 보내기는 2026-11-16에 뺌)
- 랩 미션(2026-11-22부터, 예전 「이번 주 MC 150」 대신): `LAB_MISSIONS` 13개 중 매주 일 · 함께 · 놀이 하나씩 3개(`labMissionsOf(wk)`, 2026-01-05 기준 주 번호, 11-16 주 = mc · crew · pat). 목표 숫자는 `LAB_MISSIONS`의 need만 고치면 됨. players 문서에 이번 주 값 n · stock · seed · days · shot · poop · pat · feed · gift · visit · labWins 추가(규칙 변경 필요 없음). 깬 미션은 「주:미션id」로 각자 `petSt.labWins`에 모으고 광장에서 모두 것을 합침 → 그 주에 앱을 안 연 사람도 받음.

## 우체통 메일 알림 (2026-11-28, 유진: 써도 나한테 안 옴)

우체통 편지는 Firestore `mailbox`에만 쌓이고 메일은 원래 안 감. 받은 편지는 관리자 Google 계정으로 로그인해서 설정 › 우체통 아래 「받은 편지」에서만 보임 (아래 규칙이 들어가 있어야). 메일로도 받으려면:

1. 관리자 Google 계정으로 script.google.com → 새 프로젝트 → 아래 코드 붙여 넣기
```js
function doPost(e){
  var d = JSON.parse(e.postData.contents || '{}');
  var to = Session.getEffectiveUser().getEmail();   // 스크립트 주인(관리자) 메일로만
  MailApp.sendEmail(to, '[Cell Culture Log 우체통] ' + (d.kind||'') + ' · ' + (d.name||''),
    (d.text||'') + '\n\n보낸 사람: ' + (d.name||'') + ' <' + (d.email||'') + '>\n' + new Date(d.ts||Date.now()).toLocaleString('ko-KR'));
  return ContentService.createTextOutput('ok');
}
```
2. 배포 › 새 배포 › 유형 「웹 앱」, 실행 사용자 「나」, 액세스 「모든 사용자」 → 권한 허용 → 웹 앱 URL 복사
3. index.html `const MAIL_HOOK='';`에 그 URL을 넣고 푸시 (`mailHook`이 편지 보낼 때 같이 POST, text/plain · no-cors)
- 받는 주소는 스크립트 주인 메일로 고정이라 코드에 메일 주소가 안 들어감. URL만 알면 누구나 메일을 보낼 수 있으니 너무 많이 오면 배포를 끄면 됨.
- Firestore 규칙이 없어서 저장이 막혀도 메일이 가면 보낸 사람 화면엔 「보냈어요」.

## 라인 Plate map 설계안 (2026-11-28, 유진: plate figure처럼 등록 → 나중에 PPT, passage마다 바뀜)

- 맵은 라인에 하나를 계속 고치는 게 아니라 **기록(Seeding · Split · Reseeding)마다 한 장**으로 붙임: Figure에 `src:{lineId, logId}`만 더하면 지금 Figure 편집기 · PPT를 그대로 씀. P · d는 `figLn`이 그 날짜로 계산해서 자동.
- 배양 라인 카드 ▾ 기록 줄에 「Plate map」 → 그 라인 · 그 날짜 · 그 plate 규격으로 Figure를 만들어 엶. 이미 있으면 그걸 엶.
- 다음 Split을 저장하면 「Plate map 이어서 만들기 (P5 → P6)」 칩: 지난 맵을 복제해 날짜 · 기록만 바꿈 (조건 · 색 그대로, well 수가 달라지면 규격만 바꿔서 고침).
- PPT: (가) 현미경 사진 PPT에서 그 날짜 사진 장 앞에 그 날 맵 (지금 「PPT figure 같이 넣기」와 같은 자리), (나) 라인 하나의 맵을 시간순으로 모은 장.
- 유진에게 물을 것: 기록마다 vs 라인마다 하나, PPT (가) / (나) / 둘 다, well에 사진까지 이을지.

## 우체통 Firestore 규칙 (Firebase 콘솔 › Firestore › 규칙에 추가해야 동작)

```
match /mailbox/{id} {
  allow create: if request.auth != null && request.resource.data.uid == request.auth.uid;
  allow read, update, delete: if request.auth != null && request.auth.token.email == '관리자 Google 이메일';
}
```
- 2026-11-28: 메일 알림 `MAIL_HOOK` = Apps Script 웹 앱 「Cell Culture Log 우체통」(doPost가 MailApp으로 배포한 계정에 메일). no-cors text/plain POST.
- 관리자 이메일은 코드에 안 넣음 (규칙에만). 규칙이 없으면 보내기 할 때 「아직 우체통이 열리지 않았어요」.

## PPT 표 배치 (2026-11-23 유진 요청 → 2026-11-23(5) 구현, 아래는 설계 당시 기록)

**유진이 원하는 것**: HCC27 PF / Tumor-CAF 「for CM test」처럼 조건(CM · FM · MM) × well 1–3을 날짜별로 비교. 날짜는 **왼쪽 행**, 열 = 조건(묶음 머리) 아래 well 1 · 2 · 3. 배율은 나눠서 볼지(4x 장 · 10x 장 · 20x 장) 같이 볼지 고를 수 있게. 장마다 사진 크기 같게. 「Pre-처리」처럼 그날 한 일은 조건이 아니라 그 날짜에 붙어서 같은 조건 · well 열에 맞춰 보여야 함. 버튼은 늘리지 말 것.

**지금 문제** (실제 사진 93장, 이름 예: `261111_HCC27_PF_for-CM-test-CM_Pre-처리-well-1_p5_d3_4x.png`, `261113_HCC27_PF_for-CM-test-MM_well-3---cell-detached_p5_d5_4x.png`, `261108_HCC27_Tumor-CAF_for-CM-test-3rd_Pre-MC-FM-well-1_p5_d2_4x - 복사본.png`):
- 지금 쓰는 배치는 `pptPlanAuto`(index.html 7605행 근처, `pptPlanNamed`는 안 씀). 형제 실험(for-CM-test-CM/-FM/-MM) 묶기 · `Pre-xxx`를 날짜 쪽 메모로 빼기는 이미 함.
- 그런데 조건 문자열(`cond` = "CM well-1")이 한 덩어리라 조건 · well 2단 머리가 안 됨, 「cell detached」가 따로 조건이 되어 열이 늘어남.
- `pptAutoChoose`가 장 수가 가장 적은 배치(D/C/M 중 무엇을 행 · 열로)를 골라서 날짜가 왼쪽에 안 옴.
- 마지막 장에 사진 1장만 남으면 `fill:true`라 슬라이드를 꽉 채움(사진 크기 들쭉날쭉).
- 「- 복사본」이 붙은 파일은 배율 토큰이 `4x - 복사본`이라 배율을 못 읽음(`pptParse`).

**설계안** (`pptPlanAuto`의 실험(g)마다, 날짜가 2개 이상일 때만 새 경로, 1개면 기존 그대로):
1. `cond`를 낱말로 쪼갬(공백 · `-`). `well|w|dish|plate|spot|insert|flask` + 숫자 → well. 나머지 낱말은 실험 안 사진 수 기준 빈도로 나눔: `max(2, ceil(사진수×0.12))`번 이상 = 조건(CM · FM · MM), 그보다 적음 = 덜 나오는 메모(cell detached) → 날짜 행 쪽(그날 「cell detached」 행이 따로 생겨 같은 조건 · well 열에 들어감).
2. 행 = 날짜(+ Pre 메모 + 덜 나오는 메모), 열 = 조건 묶음(colGroups) × well(colLabels). 조건이 하나뿐이면 열 = 배율.
3. 배율: `pptCuts['msplit:'+g]` 1 = 배율마다 따로 장(제목 뒤 「4x」), 0 = 행을 날짜 × 배율로(`rowBreaks` · `joinRuns`, 기존 rd 2단 코드 참고). 기본: 조건 열이 4개 넘고 배율이 2개 이상이면 나눔. 토글은 새 버튼 말고 기존 `pptRowsCtl` 알약 안에 글자 하나(「배율 나눔/같이」).
4. 한 장 행 수: 열 수로 사진 폭 → 높이로 들어가는 날짜 수 계산, `pptRowsOf(g)`(− / +)가 있으면 그 값. 모든 장 · 모든 배율 장에 같은 열 집합 + `slotRows`(= 한 장 행 수)를 줘서 사진 크기 통일(드로어 `pptDrawMatrix`가 `slotRows`를 이미 지원, 빈 칸 null 지원, 한 칸 여러 장은 나란히).
5. 기존 경로 장들에도 `slotRows`를 줘서 마지막 장 1장 꽉 채움 막기.
6. `pptParse`에서 stem 끝 ` - 복사본`, ` (2)` 같은 복사 꼬리를 떼고 읽기.
7. 조건 순서: `pptOrd(g)` → `pptCondCmp`(대조군 먼저), well 숫자순, 조건 없는 묶음 맨 앞.
- 테스트: 위 93장 이름 목록(유진 메시지)을 빈 캔버스 파일로 만들어 `pptFiles`에 넣고 `pptPlanAll()` 결과 · 썸네일 캡처. CDN 막힘 → `npm pack`으로 pptxgenjs 받아 `page.route`.

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
- 2026-11-28: 유진 요청 10가지 (브랜치 `claude/practical-davinci-cu40cu`, main 반영은 유진 확인 뒤). 데모(?demo) 1440px · 390px에서 확인, 로그인 계정 동기화 · 실제 메일 발송은 확인 안 함.
  - PPT figure 편집 창: 바깥을 눌러도, Esc로도 안 닫힘. 「닫기」로만. 전역 Esc 핸들러에서 `#figModal` 뺌 (전에는 Esc가 `open`만 떼서 안 보이는데 `_figEdit`은 남는 상태가 됐음). Esc는 열린 색 고르기만 닫음.
  - 색 조합 `FIG_PALS` 9개 (기본 · 파스텔 · 바다 · 노을 · 숲 · 라벤더 · 차분한 · 색약 배려(Okabe-Ito) · 흑백). `figApplyPal`: Control · DMSO · Vehicle · 대조 등(`figIsCtrl`)은 ctrl 색, 숫자만 다른 같은 약(`figCondStem`)은 한 색 진하기(`figTintStep`, 낮은 농도 옅게), 라인 테두리는 rings 차례. 새 조건 · 라인도 고른 조합에서 다음 색(`figPalNext`, 농도 단계 바탕은 `pb`). 마지막에 고른 조합은 `orgFigPal`(새 plate 기본, 처음은 파스텔). 판 색 `pm.body` gray · white · tint. 색 고르기 창 맨 위에 흰색 · 연한 회색 5개 + 그 조합 색.
  - well 글자: 입력을 textarea로 (엔터 줄바꿈, Ctrl+Enter 쓰기, 치다 만 글자 `_figTxtDraft` 유지, 고른 칸 글자가 같으면 미리 채움). 그리기 `figWellLines`: 줄 나눔 그대로 + 낱말 줄바꿈, 크기는 기본의 72%(최소 11)까지만 줄이고 그래도 넘치면 폭을 원 지름 가까이 · 마지막 줄 …
  - 셀 카운터: cells/mL = 합 ÷ 칸 수 × 2 × 10⁴. Live · Dead 또는 Live · 전체 합계, 부피 mL/µL. 용도(기본 Stock 1×10⁶/vial · Pellet 1×10⁶/tube · Seeding 1×10⁵/well, 추가 · 순서 바꾸기 · 기본으로)는 `orgCntPurps` + 계정 prefs `cntp`로 동기화. 세포 수는 앞 숫자 칩 × 10ⁿ 칩 × 단위 칩. 위에서부터 떼어 가며 뜰 부피(µL 올림), 모자라면 빨강 + 몇 개까지, 「되는 만큼」, 남는 세포 · µL, 「글로 복사」. 시험: N161 (169/10, 4칸, 2 mL → 8.45×10⁵, 1.69×10⁶, 94.4%, Stock 2 × 5×10⁵ = 1,184 µL), N169 (21/7, 30 mL → 3.15×10⁶, 75.0%), 전체 합계 모드 · µL · 1칸 · 오류 · 부피 없음 · 표기 22개 모두 통과.
  - 연구노트 인쇄: 프로젝트 거르기 + 묶기 라인별(예전) · 날짜별(그날 배양 · 실험 한 표) · 프로젝트별(제목 아래 라인 표 + 실험) · 프로젝트 › 날짜. `noteBy` (`orgNoteBy`).
  - 랩 사람 세포 가르마: 살색(b) → 머리색을 32% 밝힌 색(새 칸 'h'). 혜민 · 한결 · 예원.
  - 세포 누르고 설정 → `petOpenSet(id)`: 그 세포를 고른 채 설정 › 세포, 그 칸으로 내려가 테두리 반짝. 산책 중이면 상세에 멈추기/움직이기 버튼.
  - 쓰다듬기 공정성: `petCatchUpScan` 도감이 광장 1등보다 3칸 넘게 뒤면 하루 1장, 15칸 넘게면 2장 보너스 뽑기 (`cu:날짜:n`). 광장 목록(`_plaza`/`orgPlazaCache`)이 있을 때만. 1등 · 다 채운 사람은 안 받음.
  - 우체통 메일: `MAIL_HOOK` 자리만 만듦 (위 「우체통 메일 알림」). → 같은 날 다른 세션이 main에 주소를 넣음(2ac2968), 합칠 때 `mailHook` 한 곳으로 정리 (Firestore가 막혀도 메일은 감).
  - NEWS id 2026-11-28 (5줄), 예전 항목은 old로.
- 2026-11-28(14): 무드 테마 15종 (유진: 그림 배경처럼 랜덤으로, 원래 것과 섞어서). `data-art="s-…"`: lemon · mint · lavender · peach · sky (가운데 번지는 빛), sunset · aurora (구석 여러 빛), grid (모눈), dots (점 노트), candy (사선 줄), kraft (크라프트 종이), white (흰 바탕 미니멀), blueprint (청사진 격자), matcha (말차), retro (굵은 테두리 + 그림자). 각자 --bg · --side · --psoft · --pri · --acc와 카드(.panel · .composer · .stats) 둥글기 · 그림자 · 테두리. 이 테마들은 그라데이션 금지 규칙의 예외(유진이 원함).
  - 돌리는 순서 `ART_MIX` = 그림 배경 `ART_ROTA` 37개 사이에 `ART_STYLES` 15개를 섞은 52개, 2026-11-18부터 하루 한 칸 (목록 길이가 바뀌어서 오늘 배경도 바뀜). 파스텔 테마에서만, 크리스마스 기간 고정은 그대로.
- 2026-11-28(13): 셀 카운터 폰 화면 줄임 + 저장 목록 (유진). 데모 390px에서 입력 · 결과 · 나누기 3줄이 한 화면(패널 약 840px).
  - 센 칸은 1 – 4칸만 (`CNT_SQ`, 예전 값이 4 넘으면 4). 패널 머리 없앰, 샘플 칸 → 칸 수 · Dead/전체 · 새로 세기 한 줄 → Live · Dead · 부피(mL/µL 칩) 세 칸. 결과는 큰 숫자 옆에 저장 · 복사, 값 4칸 한 줄. 폰에서 나누기 줄은 이름 · 세포 수 · × / 개수 · 되는 만큼 · 부피 두 줄. 안내 글(계산식, TB 설명) 뺌.
  - 저장 목록 (`cntHist`, localStorage `orgCntHist` + 계정 prefs `cnth`, 기기끼리 id로 합침, 최근 60개): 「저장」 누르면 샘플 · 칸 · 입력값 · 개수 있는 용도를 남김, 「불러오기」로 되돌림, ×로 지움. 센 값 1시간 자동 저장은 그대로.
- 2026-11-28(12): 유진 요청.
  - 셀 카운터: 「되는 만큼」은 다른 용도(위 · 아래 모두)에 쓰기로 한 세포를 뺀 나머지로 셈 (여러 줄 다 눌러도 안 모자람), 「개수 0으로」, 센 값(live · dead · 전체 · 부피 · 샘플)은 이 페이지에만 마지막으로 고친 뒤 1시간 자동 저장(`cntSt.ts`, `CNT_KEEP`), 부피는 1 mL 넘으면 「9 mL + 40 µL」(`cntVol`). 카운트를 실험 기록에 저장하는 건 만들었다가 유진이 싫다고 해서 뺌.
  - Media: 250 · 500 ml 병 (`mdCap` 15 · 50 · 250 · 500, `mdBottleSVG` 동글한 병 + 뚜껑 홈 + 웃는 라벨). 추가 칸 글자 「추가」.
  - Media 경고 「튜브가 모자라서 기록 n ml는 …」 → 「튜브 없이 쓴 기록 n ml [확인]」. 확인 = 배지에 `shortAck` 오늘 날짜, 그날까지의 못 뺀 양은 안 셈 (지금 남은 양 계산에는 원래 영향 없음).
- 2026-11-28(11): 셀 카운터 용도 개수 칸을 숫자 입력으로 (`.cnt-n`, − + 버튼은 그대로, Enter · 칸 밖 누르면 반영, 음수 · 빈칸은 0). 유진 요청.
- 2026-11-28(10): 사이드바 「세포 · 광장」 버튼 뺌 (유진: 원래 네모칸만). `plazaMiniSync`가 로그인 안 했거나 광장이 비어도 칸을 늘 보여 주고(내 대표 세포만이라도 걸음), 누르면 `hubOpen` (로그인 + 광장 열림이면 광장 탭, 아니면 내 세포 탭). main 반영.
- 2026-11-28(9): 환자_종류마다 이미 있는 폴더 고르기 (유진 요청, main 반영). 가짜 폴더 handle로 시험, 실제 PC 폴더 · Chrome 권한 창은 확인 안 함.
  - 이름 · 스케일바 저장 폴더 줄 아래, 지금 사진에 있는 환자_종류마다 「→ 자동 / 고른 폴더 이름 [폴더 고르기] [풀기]」 (`sbMapHTML`, `renderSbarList` 끝에서 다시 그림). 고른 폴더 handle은 IndexedDB `sbMap` {환자_종류(세부명 체크면 _세부명까지): handle}.
  - 저장(`sbarSaveAll`): 저장 폴더 권한 받은 바로 뒤 `sbMapReady`가 이번에 쓸 고른 폴더 권한을 차례로 받음. 받은 폴더는 그 안에 바로 저장, 못 받거나 없어진 폴더는 자동 폴더(저장 폴더/환자_종류)로 + 끝 알림에 이름. 「이미 저장한 사진 정리」도 고른 폴더가 있으면 그리로.
  - 같은 이름 파일은 예전처럼 덮어씀 (유진이 따로 정하지 않음).
  - 「환자_종류 폴더」 체크를 끄면 예전처럼 저장 폴더에 바로 (고른 폴더도 안 씀).
- 2026-11-28(8): 유진 요청, main 반영. 데모 오류 0.
  - 세포 멘트 새로 (`PET_TALK` 통째로 바꿈, 예전 멘트 없음). 시간(아침 · 점심 · 저녁 · 밤)과 요일(월 · 금 · 주말) 멘트 더함.
  - 사진 폴더: 날짜 폴더 없이 `환자_종류` 폴더 하나(`orgSbSort` lt | none), 「세부명까지」 체크면 `환자_종류_세부명` (`orgSbDetail`). 같은 폴더가 이미 있으면 그 안에 이어서, 파일 이름까지 같으면 덮어씀(예전과 같음). 「이미 저장한 사진 정리」도 같은 규칙.
  - 미니게임 (세포 · 광장 › 게임 탭): `GM_EPOCH 2026-11-28`부터 10일마다 세포 키우기(2048, 세포 그림 `GM_CHAIN`) → 피펫팅 리듬(4줄, D F J K, 30초) → 오염 잡기(48 well, 12개면 끝) → Split 타이밍(85%에 멈추기 8번). 최고 점수 `petSt.gm={key,best}` 동기화(같은 판이면 큰 쪽), 광장 문서 `gk` · `gb`로 같은 판 순위 10명. 게임 중엔 세포 창 오른쪽을 다시 그리지 않음, 탭 바꾸거나 창 닫으면 멈춤.
  - NEWS id 2026-11-28c: 예전 항목 · old 다 지우고 이번 내용 6줄 + 공지.
- 2026-11-28(7): 유진 요청. 데모 1440 · 390 오류 0.
  - 밥 기능 없앰: 「모두 밥 주기」(펫 메뉴 · 상세), 배부름 칸, 배고픔 말 · 쓰러짐(`petFainted`는 늘 false), `petFeed*` 지움, 랩 미션 「밥 당번」 뺌, 도장깨기 주먹밥(fed200)은 쓰다듬기 500번(patsAll)으로.
  - 꽃 · 응가 끝: `PET_FX_END='2026-12-05'`, `petFxOn()`. 그날부터 꽃 안 떨어지고 응가 안 생기며 남은 응가는 지움, 미션 「응가 대청소」는 그 주부터 뺌, 도장깨기 응가 · 꽃 세포는 못 받은 칸에 「끝」. 공지: NEWS id 2026-11-28b(7일), 맨 위 「공지 꽃 · 응가는 12/4(금)까지」(`NEWS.notice`, 끝나는 날 전까지만).
  - 랩 미션 글 줄임: 제목 「이번 주 미션 n/3」, 기간 · 몇 명 · 일/함께/놀이 칩 뺌, 아래는 「다음 선물 이름」 n / m 만.
  - 미션 목록이 줄어서(밥 뺌) 이번 주 놀이 미션이 바뀔 수 있음 (주 번호 % 목록 길이).
  - 설정은 시스템만: 모양 · 글씨체 · 홈 화면 · 새로 생긴 기능. MC 주기 → 배양 라인 종류 머리 칩(`mcRuleEdit`, 경고 · 지연 숫자 작은 창), LN2 이니셜 탭은 뺌(LN2 탭 안에서 묻고 고침), 세포 · 광장과 우체통은 사이드바 아래 버튼(`hubOpen`, `mailOpen` 작은 창, 안 읽은 수 `mailNavN`). 도장판은 켜면 세포 창 탭으로.
- 2026-11-28(6): 설정 › 세포 + 광장을 한 창 「세포」로 (유진 요청). 도장판은 기능만 두고 꺼 둠 (`STAMP_ON=false`, 유진: 이번엔 메인에 안 올림). 데모 1440 · 390, 로그인 화면은 mailUser · _plaza 가짜로 확인, 오류 0.
  - `hubOpen(tab)` = 예전 광장 창(`#plazaModal`)을 넓힘: 왼쪽 풀밭(로그인 + 광장 열림 + 사람 있을 때만, 없으면 오른쪽만 좁은 창), 오른쪽 탭 내 세포 · 도감 · 광장 (`_hubTab`, `hubRender`).
  - 내 세포: 별명 · 한 줄 상태(로그인 시) → 받은 선물 → 뽑기 → 내 세포 줄(`hubStripHTML`, 산책 중 먼저, 대표 표시) → 고른 세포 상세(+ 「광장 대표로」 버튼, 예전 대표 세포 격자는 뺌). 도감 탭: 도감 + 도장깨기, 누르면 내 세포 탭 그 세포(`petSelect`). 광장 탭: 미션 · 꾸미기 · 순위(`plazaHTML`은 목록만).
  - 이어 줌: `openSettings('pet'|'plaza')`, `renderSettings('pet')`, `petMenu`, `petOpenSet`, 선물 창 「만나러 가기」, `_petRefresh`, `plazaPanelRefresh`, `plazaOpen`이 모두 이 창으로. 설정 왼쪽 「세포 · 광장」은 설정을 닫고 이 창을 엶. 마지막 설정 탭이 pet이면 설정은 모양으로 열림.
  - 구구절절 줄임: 미션 칸 아래 깜짝 선물 · 보너스 설명 줄 → 「같이 깬 미션 n · 다음 「…」 n」, 미션마다 how 설명 뺌, 친화도 「쓰다듬기 n번 더 하면 … · Lv.3에 …」 → 「Lv.n까지 m」.
  - 도장판: `STAMP_ON` false면 설정 버튼 숨김 · 도장 세기 · 찍히는 모습 · 판 보너스 모두 안 함 (시작일도 안 정함). NEWS에서도 뺌.
- 2026-11-28(5): 유진 요청 4가지. 데모 1440px · 390px 오류 0. 실제 폴더 쓰기(showDirectoryPicker)는 메모리 가짜 폴더로만 시험, 소리 · 알림은 확인 안 함.
  - 오늘 작업 기록 입력 머리에 「+ 실험 기록」 (`expFromToday`): 입력 칸에 고른 라인 · 날짜(날짜 1개면 그 날)로 실험 기록 창.
  - 사진 폴더 나누기: 이름 · 스케일바 저장 폴더 줄에 「폴더 나누기」 select (`orgSbSort`: ld 라인 › 날짜(기본) · dl · l · d · none). `sbarSaveAll`이 라인 이름 붙은 사진을 `sbSubDir(root,[환자_종류[_세부명], YYMMDD])`로. 라인 안 고른 color-matched 폴더는 그대로. 다운로드 저장(폴더 API 없는 브라우저)은 예전처럼 평평하게.
  - 「이미 저장한 사진 정리」 `sbSortExisting`: 폴더를 골라 바로 안의 `YYMMDD_…` 사진을 같은 규칙 하위 폴더로 옮김(복사 → 원본 지움, 같은 이름이 이미 있으면 건드리지 않음). 라인은 앱 라인 · 사진용 샘플 이름 중 가장 긴 앞부분, 못 찾으면 앞 두 조각(HCC99_PF). 시험: 8개 중 6장 → 5개 폴더, random.png · notes.txt 그대로.
  - 칭찬 도장판 (설정 › 도장판): 배양 · 실험 기록을 남긴 날마다 도장(기록에서 바로 셈), 시작일 `petSt.stampStart`(동기화, 먼저 시작한 날). 10칸 = 한 판, 판마다 보너스 뽑기 `stamp:k`. 저장 직후 새 도장이면 찍히는 모습(`stampPop`, 「n / 10」), 앱 열 때는 조용히 셈(`orgStampSeen`). 도장 글자 8가지 날짜 해시.
  - 타이머도 만들었다가 유진이 안 쓴다고 해서 바로 뺌 (orgTimers 남은 값은 무시됨).
- 2026-11-28(4): 유진: 보너스 뽑기 설명 줄이 구구절절해서 싫음, 친화도 제한 없애서 다들 쓰다듬어 세포를 채울 수 있게.
  - 설정 › 세포 「오늘의 뽑기」 아래 `pd-how` 설명 줄(받는 법 · 따라잡기 몇 장)과 「보너스 뽑기 n장」 글자 뺌. 버튼 「보너스 n」만.
  - 친화도 하루 20번 제한(`PET_PAT_DAY`, `petPatLeft`, 「내일 또」 말풍선) 없앰. `petLvTicketScan`은 하루 1장 제한 없이 받을 Lv.5 · Lv.10 뽑기를 바로 전부 주고 토스트 「보너스 뽑기 n장」 한 번. 따라잡기(`petCatchUpScan`)는 그대로 두되 화면 글 없음.
  - 시험(?demo): 한 세포 200번 쓰다듬기 → pats 200, Lv.8, 다른 세포 Lv.10 → 보너스 3장 한 번에. 오류 0.
- 2026-11-28(3): MC 주기 종류별 (유진 요청, main 반영). 데모 1440px에서 확인, 로그인 계정 동기화는 확인 안 함.
  - `MC_DEF` {w:3, d:4}. `mcRules()` = localStorage `orgMcRule` {종류: {w, d}} ↔ 계정 prefs `mcr` (JSON 문자열, `_prefsOut` · 받을 때 덮어씀). `mcRuleOf(line)`: 라인 `mcW` · `mcD` → 종류 값 → 기본, 지연이 경고보다 작으면 경고로 맞춤.
  - `mcDays`: d < w → mc-ok, w ≤ d < 지연 → mc-warn, d ≥ 지연 → mc-due (기본값이면 예전과 같음: 0–2 · 3 · 4+). 돌려주는 값에 w · dl 더함. `selectMcNeeded`는 mc-ok가 아닌 라인 (= 경고일 이상). 배양 현황 숫자 칸 「MC 3일차」 → 「MC 할 날」.
  - 설정 › MC 주기 (`renderSettings('mc')`): 앱에 있는 종류마다 경고 · 지연 숫자 칸, 비우면 기본. 안내 글 없음. `mcRuleSet(type,k,v)` 저장 뒤 `updateUI`.
  - 라인 수정 「MC 주기 따로」 `elMcW` · `elMcD`, 비우면 필드 지움 (종류 값을 따름). placeholder는 지금 종류 값.
  - 시험(?demo): Tumor-org 2 · 3일로 바꾸니 HCC26 d2가 ok → warn, 「MC 할 날」 2 → 3. Cell line 4 · 5일: HepG2 마지막 MC를 옮겨 d3 warn → ok, d4 due → warn, d5 due 그대로. 라인 따로 10 · 12일 → d2 ok, 비우면 다시 종류 값. selectMcNeeded가 warn · due 라인만 고름.
- 2026-11-28(2): 라인 Plate map (유진: 맵은 기록마다, PPT는 시간순). 데모에서 HCC26 Seeded 11-08 → Split 11-14로 확인, .pptx는 CDN 막혀 못 뽑아 봄 (`figPpt` 그대로 씀).
  - 배양 라인 기록 표 Plate 칸: Seeding · Split · Reseeding · Thaw 줄에 「+ map」(점선), 맵이 있으면 「map」(채움). 누르면 `lmapOpen`: 있으면 열고, 없으면 그 라인의 바로 전 맵을 복제(조건 · 색 · well 유지, 규격은 그 기록 plate 글자, 넘는 well은 뺌, 메모 비움) 또는 새로(그 라인 1개 + Control, 마지막 고른 색 조합). 프로젝트는 라인 프로젝트.
  - P · d: `figLnF` 그 기록 기준, Split · Reseeding은 P+1 · d0, Seeding · Thaw는 P · d0. 제목 자동(예: HCC26 Tumor-org · P4).
  - 라인 머리 「Map PPT n」: 그 라인 맵을 날짜순으로 한 장씩 (`figPpt(ids, 파일 이름)`). 기록을 지우면 그 맵은 목록에서 빠짐 (figure 자체는 PPT figure 페이지에 남음).
  - 이 라인에 맵이 있는데 Split · Seeding을 저장하면 토스트 「Plate map도 이어서 만들까요? (P4 → P5)」 + 버튼 (`toast` opt.act 새로).
  - 확인 필요: Seeding 기록에 plate 글자가 없으면 라인의 지금 plate로 규격을 잡음 (예전 seeding이면 틀릴 수 있음, 편집 창에서 바꿈).

- 2026-11-26: 다음 Split 예상 (F1, 유진이 고름, main 반영 3031eb1). 데모에서 확인, 실제 데이터는 확인 안 함.
  - `splitPred(id)`: P+1 기록(`isPassageUp`) 날짜의 간격 중 2~40일만, 최근 3번 평균. Split이 1번뿐이면 첫 기록(seeding) → 첫 Split 간격. 마지막 Split + 평균 = 예상일, 지난번 비율은 마지막 Split details.
  - 배양 현황: 예상일이 3일 안이거나 지났고, 오늘 예정 · 안 끝난 Split 예정이 없으면 라인 이름 옆 `.sp-tag` 「Split ~11.28」 / 「Split 예상 +3일」. 누르면 `splitPlanFor` → 예정 작업 창(Split, 「1:3 예정」, 지난 날짜면 오늘). ▾ 펼친 최근 기록 위에 평균 간격 · 지난번 비율 · 예정에 넣기.
  - F2 Myco, F3 이상 표시는 유진이 안 하기로 함. NEWS id 2026-11-26.
- 2026-11-25: 바쁜 대학원생 입장 UX 점검 뒤 유진이 고른 4가지 (main 반영 3031eb1, 유진 요청). 데모(?demo) 390px · 1440px에서 확인, 로그인 계정 동기화는 확인 안 함.
  - 라인 찾기: 기록 입력의 `<select id="lineSelect">`는 숨기고(다른 코드가 쓰니 남김) `#lineFind` 검색 칸. 공백 · _ · - 무시하고 lineTag에 포함되면 목록(`lineFindRender`), ↑↓ · Enter · 누르기로 선택, 비워두고 누르면 진행 중 전체. 아래 「최근」 칩 3개(`renderLineRecent`, 최근 기록 seq 순, 이미 고른 것 · 완료 라인 뺌). 오늘 작업 탭에서도 / → `#lineFind`.
  - 저장 뒤 액션 · Plate 유지: `saveDailyLog`가 `resetLogPlate()` · `setAction('Media Change')`를 안 함. 라인 · 비율 · Well · vial · 메모만 비움. 배양 완료는 예전처럼 MC로 돌아감.
  - 오늘 아닌 날짜: `renderDateChips`에서 저장될 날짜(bulkDates 1개면 그것)가 오늘이 아니면 날짜 칸 · 저장 버튼에 --warn 테두리, 버튼 글자 「어제 11/24 날짜로 저장」 / 「날짜 n개로 저장」.
  - 폰 「n개 선택」 바(`#selFab`, 이제 div): MC · MA는 `fabAct`로 바로 저장, Split · Obs는 액션 골라 입력 칸으로, ⋯는 입력 칸으로. 오늘이 아니면 바 끝에 「어제」 표시.
  - MC 버튼 길게 눌러 어제로 기록(C3)은 유진이 안 하기로 함. NEWS id 2026-11-25에 4줄 추가.
- 2026-11-24(8): HE 사진 50장 (`261124_HE_C0-No1_Hepa1c1c7-5e6_s1_4x` 모양)으로 PPT 만들며 불편했던 5가지 (main 반영 b033199, 11-25 유진 요청). 실제 사진, 로그인한 계정 동기화는 확인 안 함.
  - 이름 자동 끊기: 개체 번호 `PPT_INDIV` (No1, #3, Mouse2, Ms1) 앞에서 끊음 (`pptIndivCut`, 셋째 말부터). HE 50장: 실험 11개 → 3개 (HE C0, C1, C2).
  - 「여기까지 실험 이름」: 숫자만 다른 이름은 같은 자리에서 끊음. 키 `~he c#` (`pptShapeKey`), 예전 정확한 키도 그대로 읽음.
  - 배율: 기본은 늘 「한 장에 같이」 (표 배치에서 열 5개 이상이면 나누던 자동 뺌). 실험 줄 배율 버튼을 처음 누르면 덱 전체 값(`msplit:*` = 1 또는 0)도 같이 정해져 다른 실험이 따라감, 그 뒤로는 누른 실험만. 이름을 다시 나눠 실험 이름이 바뀌어도 덱 값을 따라가서 풀리지 않음 (유진이 말한 「해제」는 이것으로 추정).
  - 골라 만든 장: 덱 맨 뒤에 고른 순서대로 (`pptPickPlan(th)`이 장을 돌려줌). 장 번호 (1/2)는 원래 장과 따로 셈. 고르기 화면 위 「모든 실험에 같이」 칩 (`pptPickByAll`): 20x 한 번이면 모든 실험의 20x.
  - 제목 통일: `pptDrawClassic` (한 조건 장, 사진 채우는 장)도 `pptTitle` (「11.24  HE C0」 22pt + 가는 줄). 4행 장 사진 시작 1.30 → 1.48 in (아래 끝 7.21 in), 회색 메모 칸 1.22 – 1.74 in.
  - 시험: HE 50장 → 3장 + 골라 만든 장 1장 (맨 뒤), 매일 well-1 4x · 10x · 20x 5일 → 세로 한 장, CM-test 54장 표 → 배율 같이 한 장, .pptx 쓰기 오류 없음. 실제 사진, 로그인 계정 동기화는 확인 안 함.
- 2026-11-24(7): 유진이 손본 PPT (`261124 Cell images (261108-261114).pptx`) 보고 고침 (main 반영 da44916, 유진 요청).
  - 사진 크기 고정 (랩 사람: 장마다 사진 비율이 다름): `pptDrawMatrix`에서 모든 장 `colW ≤ PPTC.w`, `≤ PPTC.h / 가장 긴 사진 비율`. 사진이 적어도 안 커지고, 9열 표처럼 안 들어갈 때만 줄어듦. 756장 사본: 748장 2.44 × 1.37 in, 8장 1.20 in (같은 칸 두 장이라 반으로 나눔, 그대로 둠).
  - 사진 골라 장 더 만들기: `pptCuts['pick:*']` = [{id, name, names: 파일 이름}]. `pptPickPlan`이 고른 사진만 `pptPlanAuto(sub, th, all)`로 배치해 원래 실험 장 바로 뒤에 넣음 (`p.pick`, 제목 뒤에 name). `pptPlanAuto` 셋째 인자는 이름 해석 기준 파일 (고른 것만으로 해석이 달라지지 않게). `pptNameInfo`, `pptToksOf`는 원래대로 되돌림. `pptPageKey`에 pick id. 고르기 화면 `pptPickHtml`: 실험마다 well, 배율, 날짜 칩은 거르기 (같은 줄 또는, 다른 줄 그리고), 사진 눌러 하나씩.
  - 표 글자: 조건 12 (굵게), well 10 (안 굵게), 날짜 9. 예전엔 셋 다 약 8 pt.
  - 회색 메모 칸: 글이 있을 때만 그림. 고치기 화면에서만 「메모를 쓰려면 누르기」 회색 글자.
  - 날짜 옆 메모 (Pre-수확 등) 색 `7C3AED` 보라 → `0E7490` 청록 (검은 배경 `67E8F9`).
  - 표 한 장 (유진: 줄여서 한 장): `pptTablePlan`에서 사진을 85%까지 줄이면 행이 다 들어가는 표(8행 이하)는 나누지 않고 한 장 (`squeeze`). 그 장만 작아지고 덱 전체 단위 맞춤(`cwFix`)에서 빠짐. well 1만 고른 4x 4행: 2.07 in, 아래 끝 7.100 in.
  - 같은 칸 두 번째 사진 (유진: 반으로 나누는 것 싫음): `pptPlanAuto`에서 같은 날짜, 조건, well, 배율 칸의 두 번째 이후 사진((2) 컷 등)은 `「실험  추가 사진」` 그룹으로 빼서 `pptPackPlan`으로 실험 뒤에 (특이사항 장과 같은 배치). 756장 사본: 98장, 756장 모두 2.44 × 1.37 in, 추가 사진 장 3장 (4장).
- 2026-11-24(6): 폴더째 올리기, 선물 알림, 쓰다듬기 막기, Lv.5 뽑기권 빠짐 (main 반영 da44916, 유진 요청). Firebase 실제 선물 주고받기는 확인 안 함.
  - `wireDrop(dropId, inputId, handle)`: PPT, 스케일바 올리기 칸 공통. 「폴더째 고르기」 (webkitdirectory input), 끌어다 놓은 폴더는 `dropEntries` + `entriesToFiles`로 하위 폴더까지 꺼냄. 사진 아닌 파일은 기존 handle에서 걸러짐.
  - 선물: `plazaInbox`가 토스트 대신 `plazaGotPop` 창 (세포 그림, 보낸 사람, 「만나러 가기」). `petSt.gotLog` 최근 20개, 설정 › 세포 맨 위에 2주 동안 `plazaGotHTML`.
  - 쓰다듬기: 랩 사람 하나가 밤새 쓰다듬어 Lv.5, Lv.10 보너스 뽑기로 도감을 다 채움. 세포마다 하루 `PET_PAT_DAY`=20번까지만 친화도 오름 (`o.pd`={d,n}, 동기화 필드에 넣음). 친화도 뽑기권은 `petLvTicketScan`이 하루 1장 (`petSt.lvTk`), 밀린 건 다음 날부터. 이미 채운 사람 데이터는 안 건드림.
  - Lv.5 뽑기권이 안 들어옴: `_petsIn`이 세포 기록을 들어온 값으로 덮어 pats가 옛 값으로 줄었다가 다시 Lv.5가 되면 알림만 뜨고 키는 이미 있어 안 들어왔음 (추정). `petOwnedMerge`로 pats, flowers는 큰 쪽. 다른 탭 저장(storage 이벤트)도 통째로 바꾸지 않고 `petStMergeTab`으로 뽑기권 키, pats 합침. 빠진 키는 `petLvTicketScan`이 다시 줌.
  - 시험: 폴더 13장 고르기, 가짜 폴더 entry 끌어다 놓기, 선물 창, 30번 쓰다듬기 → 20번만 오름, 뽑기권 하루 1장, 옛 값 합치기에서 pats 안 줄어듦. 페이지 오류 0. Firebase 실제 선물 주고받기는 확인 안 함.
- 2026-11-24(5): PPT 화면에 「이름 나누기」 추가. 유진 확인 후 (3) – (5) main 반영 (b0d10f2). 로그인한 계정 화면과 다른 기기 이어짐은 확인 필요.
  - 실험마다 이름을 말 단위 칩으로 보여 줌. 말을 누르면 여기까지 실험 이름, 조건, 특이사항, 날짜 옆 메모, 이름에서 빼기, 자동으로.
  - 저장: `pptCuts['words:*']` = {말: cond, spec, note, skip} 모든 실험에 적용, `pptCuts['wcut:*']` = {이름 앞부분: 1}. `savePptCuts`로 기억.
  - 자동 규칙: 실험 합치기는 끝이 대문자 2 – 4자일 때만 (for-CM-test와 for-CM-Assembloid는 안 합침). contamination, 오염, detachment, Post-…, Pre-fix-uSlide도 알아봄. 실험 이름 끝의 특이사항 말은 이름에서 뗌.
  - 시험: 가상 이름 13개로 버튼 전환, 새로고침 뒤 기억 확인. 756장 → 95장, 원본 94장 → 11장, 86장 → 9장 그대로.
- 2026-11-24(4): 사진 756장 (10/06 – 11/16) 기준으로 이름 해석 고침 (main 반영 b0d10f2).
  - 세포 종류: 끝을 뗀 이름이 「환자 + 세포」뿐이면 형제 실험으로 묶지 않음 (Tumor-org, Tumor-CAF 분리).
  - 특이사항: 빈도 추측을 없애고 `PPT_SPEC` (detached, contaminated, 부착잔여, dryed)만 인정. 실험마다 「특이사항」 장으로 모음.
  - well: A1, B3 같은 plate 칸이 한 실험에 3가지 이상이면 well로 읽음. W1 뒤 well-1은 한 번만 적음. well 번호 없는 사진은 겹치지 않으면 첫 well 줄에 넣고 글자는 안 붙임 (`noWell`).
  - 작업 단계 `PPT_STAGE` (hand-pick, split-전, split-dN, thaw-dN, reseeding-전)는 날짜 쪽 메모. 같은 날 메모가 다르면 열을 나눔.
  - `pptDensify`: 빈칸이 절반 이상이고 한 줄에 사진 3장 이상인 줄이 없는 장, 날짜 하나에 well만 늘어선 장은 사진 채우는 배치로.
  - 시험: 756장 → 95장, 사진 빠짐 없음, 세포 종류 섞인 장 없음, 가장 아래 7.026 in. 756장은 같은 이름의 작은 사본으로 시험. 원본 94장 → 11장, 86장 → 9장.
- 2026-11-24(3): detached 장 빈칸 없앰 (main 반영 b0d10f2).
  - `pptPackPlan`: detached 사진은 날짜 열, 배율 행을 쓰지 않고 왼쪽부터 채움 (한 줄 5장, 한 장에 3줄). `p.pack`이면 `pptDrawClassic`이 사진마다 위에 날짜, 왼쪽 위에 조건과 well (`p.packInfo`)을 그림.
  - 시험: 원본 94장 → 11장 (8번 detached 4장), 86장 → 9장, 사진 빠짐 없음, 가장 아래 7.026 in. 「같은 칸」, 「따로 장」 전환 확인.
- 2026-11-24(2): 유진 확인 후 수정, main 반영.
  - 회색 메모 칸: Log에서 가져오지 않음 (`pptClassicMemo` 지움). 3행 이하 장에 빈 칸을 두고 PPT나 슬라이드 고치기에서 직접 씀 (`p.memo`).
  - 하나뿐인 조건 (detached): 기본은 실험 바로 뒤 따로 장, 실험 줄에서 「같은 칸」을 고르면 예전처럼 같은 칸 + 사진 아래 글자 (`pptCuts['rare:실험']` = cell).
  - 버튼: 사진 위 작은 글자 버튼을 없애고 실험마다 이름 줄(`pptExpBar`)에 배치, 배율, 한 줄 사진, detached를 칠해진 버튼으로. 장마다 다른 값은 썸네일 아래 「이 장 배율 방향」.
  - 시험: 원본 94장 → 11장, 86장 → 9장, 사진 빠짐 없음, 가장 아래 7.026 in. 버튼을 눌러 전환 확인.

- 2026-11-24: PPT 기본 배치를 예전 덱 방식으로 (브랜치 `claude/ppt-classic-layout`). 기준 문서는 STAR `261124 Cell Culture Log PPT 레이아웃 요청.md`.
  - `pptClassicPlan` + `pptDrawClassic`: 한 장에 한 조건, 열 = 날짜 (최대 5), 행 = 배율. 사진 칸 2.44 × 1.38 in 고정 (16:9 원본은 비율을 지켜 2.44 × 1.37), 4행 장은 사진 시작 y 1.30 in, 메모 칸 없음, 7.03 in에서 끝남. 3행 이하는 y 2.25 in + 회색 메모 칸.
  - 행 나누기 `pptRowChunks`: 3행, 4행 장으로 나눠 2행 이하 장을 줄임. 실험 전체가 2행이거나 5행 (3 + 2)일 때만 2행 장이 남음.
  - 스위치: `pptCuts['mdir:실험|조건|well']` = h (배율 가로), `pptCuts['view:실험']` = table (조건 비교 표). 조건 비교 표는 사진 2.44 in 이하, 9열은 줄여서 한 장에. 아래 한계 7.10 in.
  - 이름 해석 `pptNormGroup`: Pre-24h의 시간은 조건으로, 끝 번호 1, 2는 rep으로, 숫자 10은 같은 실험에 `약이름 10ng`이 하나뿐일 때 같은 조건으로, 드문 말 (detached)은 사진 아래 글자로. `pptCuts['alias:실험']`은 직접 같은 뜻을 넣는 자리인데 화면 입력 칸은 아직 없음. 이름 조각 역할을 직접 정한 실험은 이 해석을 건너뜀.
  - 형제 실험: 끝이 CM, FM, MM처럼 대문자 2 – 4자면 끝을 뗀 이름 (Pre-split)이 따로 있어도 한 실험으로 묶음. 2nd, 3rd는 다른 실험.
  - 표에서 사진 하나뿐인 칸이 두 배로 나오던 것: 장 전체에서 반복 칸 수를 맞춤 (`kU`).
  - 같은 날짜, well, 배율에 일반 사진과 detached가 같이 있으면 그 칸을 반으로 나눠 1.20 in씩 넣음 (HCC27 8장). 사진 크기 고정과 같은 칸 규칙이 부딪히는 자리라 유진 확인 필요.
  - 시험: 실제 원본 HCC27 CM test 94장, HCC18 IFNg 86장을 앱에 넣어 .pptx로 뽑음. 10장, 9장, 사진 빠짐 없음, 가장 아래 7.026 in. 메모 칸은 시험용 라인, 기록으로만 확인했고 실제 Cell Culture Log 기록으로는 확인 필요.

- 2026-11-23(8): (5) – (7) main 반영(59ca580, 유진 요청).

- 2026-11-23(7): **PPT 이름 조각 역할** (유진 결정: 이름 조각마다 직접 고르기). 썸네일을 눌러 고치는 화면 맨 위 「이름 조각」(`pptRolesHtml`): 실험 이름 조각(well 빼고, Pre 메모 포함)마다 자동 · 행 · 열 · 장 나누기 · 무시(`pptSetRole`, `pptCuts['roles:'+실험]`, 계정 동기화). 시간(24h · 30min) · 농도(10ng · 5uM) 조각은 같은 모양끼리 같이 따라감(`#time` · `#dose`), 숫자 · 낱말은 조각마다. 역할을 하나라도 정하면 `pptTablePlan`이 날짜 1개여도 표로: 열 = 열 조각(+ 자동이면 자주 나오는 낱말) × well, 행 = 날짜 + 행 조각, 장 = 장 조각 값마다(제목 뒤 「24h」), 무시 = 같은 칸에 나란히. 「모두 자동」으로 되돌림. 확인: IFNg-2nd에 24h → 장, Pre → 행, 1 · 2 · IFNg → 무시 → 24h 장 · 48h 장, 행 = 날짜(+ Pre), 열 = Control · 10 · 10ng(날마다 이름이 「10」과 「IFNg-10ng」로 달라 열이 갈림). NEWS 2026-11-23b에 한 줄.

- 2026-11-23(6): PPT ① 「배율마다 따로 장」 체크(슬라이드 배치 창, `pptCuts['msplit:*']`, 체크를 바꾸면 실험별 값은 지움) + 썸네일 칸 「배율 나눔/같이」(표 장 · 예전 장 모두, `pptMsplitSet`: 실험 값 → 덱 전체 → 자동). 나눔이면 `pptPlanAuto`에서 실험을 배율별로 「제목  4x」 실험으로 쪼갬(`gBase`로 원래 실험 이름 기억). ② 표 장 행 이름(cell detached)이 넓은 칸을 차지해 빈 틈이 크던 것: 낱말마다 줄바꿈 + 8pt(`p.rlFs`). ③ `(2)` 두 번째 컷은 조건 낱말이 아니라 같은 칸에 나란히. 유진 전체 사진 목록(약 900장) 중 100장 표본으로 오류 없음 확인. **남은 문제(확인 필요)**: 이름 모양이 사람 · 실험마다 달라 자동 해석이 틀리는 실험이 있음 — `Pre-24h-10-1`(Pre 메모로 「Pre-24h」를 뗌, 10 · 1이 조건/반복인지 모름), `for-CM-Assembloid`와 `for-CM-test`가 형제 실험으로 묶임, `24h-IFNg-10ng-1`처럼 시간 · 농도 · 반복이 한 덩어리. 유진에게 「이름 조각을 직접 행 · 열 · 장으로 지정」하는 방식을 제안함(결정 대기).

- 2026-11-23(5): **PPT 표 배치 구현**- 2026-11-23(5): **PPT 표 배치 구현** (유진: 날짜는 왼쪽, 조건 아래 well 1 · 2 · 3, 사진 크기를 3 · 6 · 9장 단위로 통일). `pptTablePlan`(`pptPlanAuto`에서 실험마다 먼저 시도): 날짜 2개 이상 + 열(조건 × well) 2개 이상일 때. `pptCondSplit`로 조건 문자열을 낱말 · well로 쪼개고, 사진 수 12%(최소 2) 미만이면서 나오는 사진마다 자주 나오는 조건이 같이 붙은 낱말(cell detached · detached)은 「드문 메모」 → 그 날짜 밑 행. 행 = 날짜(묶음 칸: 날짜 / P · d / Pre 메모, 3줄) + 드문 메모 행, 열 = 조건 묶음 머리 × well(조건 없는 묶음은 머리 줄 없이 맨 앞). **한 줄 단위** `pptCuts['unit:'+실험]` 3 · 6 · 9(자동: 9장 안이면 들어가는 가장 작은 단위, 넘으면 줄 수 → 빈 자리 적은 쪽, CAF 12칸 = 6 + 6), 조건 묶음은 줄(band) 사이에서 안 쪼갬, 줄마다 따로 장(그 줄에 사진 있는 날짜만), 장은 날짜순. **배율** `pptCuts['msplit:'+실험]`(자동: 열 4개 넘고 배율 2개 이상이면 나눔, 제목 뒤 「4x」), 같이면 행 = 날짜 × 배율. 한 장 행 수는 사진 폭이 그대로 유지되는 만큼(`pptMatrixCW`로 재 봄), 날짜 묶음은 장 사이에서 안 쪼갬. **사진 크기 통일**: 드로어 `p.cwFix`(칸 폭 상한) + `minCols = 단위`, `pptPlanAll` 끝에서 표 장은 덱 전체 같은 단위끼리, 그 밖의 자동 장은 실험 안 같은 단위끼리 가장 작은 칸 폭에 맞춤(직접 고친 장은 뺌). 기존 경로 장에도 단위 · `slotRows`(마지막 장 1장 꽉 채움 막기). 썸네일 칸: 표 장은 「− 한 줄 n장 + · 배율 나눔/같이 · 자동」(`pptSetUnit` · `pptSetMsplit`), 다른 장은 예전 「한 장에 n행」. `pptStem`: 파일 이름 끝 「 - 복사본」「 - Copy」「 (2)」 떼고 읽음(`pptParse` · `pptPieces` · `pptPreToks` · `pptMagOf` · `pptAuxParse`). 확인: 유진 93장 이름으로 Playwright(PF 4x · 10x · 20x 각 1장, CAF 2장(11.08 FM · MM / 11.11 well 1–6), Tumor-org 1장, 배율 같이 · 한 줄 3장 토글), Assembloid 36칸 · IFNg 3조건 3날짜도 오류 없음. **확인 필요**: CAF 11.11 「Pre-수확 well 1–6」이 FM 1–3 · MM 4–6인지 이름에 없어서 따로 줄로 둠. 「복사본」과 원본이 같이 있으면 한 칸에 나란히 2장(그 칸만 작아짐). 실제 .pptx는 CDN이 막혀 이 환경에서 못 만들어 봄(썸네일 드로어는 같은 코드). NEWS 2026-11-23b.

- 2026-11-23(4): **PPT 「표」 배치 설계만 함, 코드 안 고침** (사용량 때문에 중단). 아래 「다음 할 일: PPT 표 배치」 보고 이어서.

- 2026-11-23(3): ① 광장 「세포 왕 순위」: players에 `cells`(가진 세포 n 합) 올림, 많은 순 1위 · 2위 …(같으면 같은 등수, 1위 왕관), 예전 버전 사람은 도감 + 도장깨기로 어림. ② **보너스 뽑기**: `petSt.tkKeys`(받을 일마다 키 하나) − `tkUsed`(쓴 수), 동기화는 키 합집합 · 쓴 수 max라 두 기기에서 두 번 받거나 쓴 게 되살아나지 않음. 받는 일: 랩 미션 하나 깰 때마다(`lab:주:id`, `labCheckWins`) · 하루 기록 5건(`work:날짜`) · 한 주 4일 들르기(`visit:주`) · 친화도 Lv.5 · Lv.10(`lv5:id`) · 깜짝 선물(`sp:주`). `petTicketScan` 4초 뒤 + 1분마다. `petGacha('ticket')`. 설정 › 세포 뽑기 칸에 「보너스 n」 버튼 + 받는 법 한 줄. ③ **깜짝 선물 시간**: `petSurpriseOf(주)` = 주 해시로 평일 하루 10–17시 중 2시간(모두 같음, 미리 안 보임). 그 사이 앱을 열어 두면 팝업 「깜짝 선물 시간!」 → 열어 보기 = 보너스 뽑기. 광장 미션 칸 아래 지난 뒤에만 「목 12–14시 · 받았어요/놓쳤어요」. NEWS 2026-11-23. (2)와 같이 main 반영.

- 2026-11-23(2): 세포 뽑기가 가끔 하루 2번 됨(랩 사람 제보). 원인 세 가지 막음. ① 같은 브라우저 창 두 개: `orgPets`가 창끼리 안 맞춰져서 다른 창은 옛 lastDraw로 또 뽑고, 옛 상태로 저장해 먼저 뽑은 세포까지 지울 수 있었음 → `storage` 이벤트로 `orgPets` 바뀌면 그 창 `petSt`도 바꿈, `petCanDraw`는 localStorage 값도 봄(`petLastDrawLS`). ② 동기화로 옛 lastDraw가 오면 덮어썼음 → `_petsIn`은 더 늦은 날짜만. ③ 폰에서 뽑고 동기화 전에 노트북에서 뽑기 → `petGacha`가 뽑기 직전 계정 문서의 `pets.lastDraw`를 한 번 읽음(`petDrawCloudCheck`, 3초 넘으면 그냥 진행), 이미 뽑았으면 알림. 연타 막기 `_pgBusy`. ③은 Firebase가 없는 테스트 환경이라 실제 두 기기로는 확인 못 함. main 반영 11-23.

- 2026-11-23: 다이어리 위클리에서 아직 안 온 날도 「쉬는 날」, 지난주 비교가 −57처럼 나옴(유진 캡처). 빈 날 글: 지난 날 = 쉬는 날 · 오늘 = 아직 기록 없음 · 앞날 = 비움. 지난주 비교: 이번 주면 지난주도 오늘 요일까지만 세서 비교(「지난주 월요일까지와 비교」), 아직 안 온 주는 증감 숨기고 「아직 오지 않은 주」. 분석 탭 `buildThisWeek` 증감도 같은 기준. (2026-11-22(6) 프로젝트 색과 같이 main 반영, b862c91)

- 2026-11-22(6): 프로젝트 색이 칙칙함(유진 캡처). 원인: `projColor`가 따로 둔 `PROJ_PAL`의 테두리용 중간 톤(#8FD0CF 등)을 칩 바탕으로 써서 탁했음. → 종류 색과 같은 `PAL`의 파스텔 12색(`AUTO_PAL`)을 씀. 이름 해시로 자리를 정하고 겹치면 다음 빈 색(이름순으로 정해서 기기마다 같음, `_pjColMap` 캐시). 프로젝트 없음은 회색. `PROJ_PAL` 지움. main 반영은 11-23.

- 2026-11-22(5): 친화도 이펙트(유진: 친화도별로 다양하게). `petFx(a, 조각들)`: 펫 가운데서 글자 · 동그라미 조각을 CSS 변수(--dx · --dy · --s · --r · --t · --d)로 흩뿌림(`.pfx`, `pfxGo` · `pfxRing`, 움직임 줄이기 설정이면 바로 사라짐). 쓰다듬기 `petPatFx`: Lv1–2 하트 하나(예전 그대로) · 3–4 하트+반짝 · 5–6 하트 둘+음표 · 7–8 하트+별 · 9 무지개 하트 · 10 금빛 반짝 고리. 레벨 업 `petLvFx`: 「Lv.n」 딱지 + Lv2 하트 셋 · 3 하트 원형 터짐 · 4 음표 · 5 꽃잎 · 6 비눗방울 · 7 별 터짐 · 8 금가루 + 왕관 · 9 무지개 고리 · 10 폭죽 세 번 + 반짝. 펫 층(`#petLayer`)은 오늘 작업 탭 · 펫 켬일 때만 보임. NEWS에 친화도 이펙트 · 한 줄 상태 동기화 더함. (4)와 함께 main 반영(유진 요청).

- 2026-11-22(4): 광장 한 줄 상태가 폰 · 노트북에서 엇갈림(유진). 원인: 한 줄 상태 · 광장 별명 · 대표 세포가 localStorage에만 있어서 기기마다 따로, players 문서는 나중에 올린 기기 값으로 덮임. → `prefs`에 pmsg · pnick · prep(빈 값도 올림, 지운 것도 맞춰짐), 받으면 localStorage에 쓰고 광장에 다시 올림 · 열린 입력 칸 맞춤(`_plazaFormSync`, 치는 중인 칸은 건드리지 않음). 한 줄 상태는 칠 때마다 저장, 0.9초 멈추면 광장 · 계정에 올림(`plazaSetMsg`). 처음 한 번은 두 기기 값 중 하나로 정해지고 그 뒤로는 같음.

- 2026-11-22(3): main 반영(aad126f).

- 2026-11-22(2): 버튼 줄임(유진: 잡다하게 버튼 생기면 안 됨). 촬영 순서 줄의 ↑ ↓ · 고치기 · 앞에 넣기 버튼 뺌 → **줄 이름을 누르면** 위 안내 칸에 배율 칩 · 저장 · 이 앞에 넣기 · ↑ ↓ · 닫기(`slEditStart`, 옮겨도 고르던 줄 따라감). 사진 창의 끼우기 · 빼기 버튼 뺌 → **라인 고르기 칸 맨 위 「순서 고치기」** 묶음에 「↓ 여기 빈 칸 끼우기」 「↑ 이 순서 빼기」(`sbSet`에서 `__push` · `__pull` → `sbShift`). 새 버튼은 0개.

- 2026-11-22: ① **랩 미션**(유진: MC 하나 깨면 마스코트 하나로 끝, 다양하게). 광장 패널 맨 위 「이번 주 랩 미션」 막대 3개(`labMissionHTML`). 일(MC 150 · Split 20 · Stock 30 vial · 새 라인 4 · 사진 80장) / 함께(기록한 사람 5명 · 3일 넘게 기록한 사람 3명 · 기록한 날 합 20 · 세포 선물 4번) / 놀이(응가 100 · 쓰다듬기 150 · 밥 80 · 들른 날 합 25). 놀이 횟수는 `petSt.wkc`(주가 바뀌면 0, 계정 동기화는 같은 주면 max). 달성 확인 `labCheckWins()`: 광장 불러올 때 · 그릴 때. 선물: 같이 깬 미션 1(랩 마스코트, 예전 `labDone` 주는 mc 1개로 옮김) · 3 피펫 요정 · 6 삼각 플라스크 · 10 페트리 접시 · 15 다같이 셋 · 25 랩 수호신, 한 주 3개 모두 = 올클리어 왕관(`labAllWeeks`). 광장 물품: 깃발 = 이번 주 미션 하나라도, 깃발 가랜드 3 · 마스코트 동상 8 · 협동 종 15(`k:'lab'`). **목표 숫자는 실제 랩 인원 · 기록량을 몰라서 추정값, 너무 쉽거나 어려우면 need만 조정.** ② **촬영 순서 중간 고치기**: 줄마다 번호 · ↑ ↓(`slMoveGroup`) · 고치기(`slEditStart` → 위 칸에서 라인 · 특이사항 바꾸고 배율 칩 고른 뒤 저장, 되돌리기) · 앞에 넣기(`slInsAt`: `_slIns` 자리에 `slPut`으로 차례로 끼움, 불러온 순서 사이면 그 날짜 따라감). 지우기 · 전체 삭제 · 창 열기 때 모드 끔. ③ **사진 이름 · 스케일바**: 순서가 채워진 뒤 사진마다 「↓ 끼우기」(이 사진 비우고 아래 라인 · 배율 · 특이사항을 한 칸씩 내림, 맨 끝이 밀려나면 알림) · 「↑ 빼기」(이 사진 순서 빼고 한 칸씩 올림), 같은 날짜 묶음 안에서만, 되돌리기(`sbShift`). toast 되돌리기는 이제 함수도 받음. NEWS 2026-11-22.

- 2026-11-20(5): 데이터 › 「오래된 기록 엑셀로 정리」(`openArchive` · `archBuild` · `archRun`). 3 · 6 · 12 · 24개월 전에 **배양 완료된 라인만**(진행 중인 라인은 passage · day 계산 때문에 그대로) 고르면 라인 · 기록 수 · 줄어드는 용량을 보여 줌. 엑셀(ExcelJS 4.4.0, cdnjs에서 쓸 때만 불러옴): 「요약」 탭(환자 · 종류 · 세부 · 시작 · 완료 · Passage · 기록 · Stock) + 종류마다 탭, 탭 안에서 라인마다 종류 색 머리줄(9칸 병합) + Date · Action · P · D · Plate · Ratio · Well · Stock · Memo 표(Action은 앱 색, P는 passage 색), 가로 인쇄 · 한 장 폭. 「엑셀 받고 앱에서 지우기」는 엑셀과 함께 되살릴 수 있는 원본 `…_백업.json`도 받고 lines · logs · stockChecks에서 지움(앱에 되살리기 기능은 아직 없음). 저장 공간 보기: 용량을 JSON 글자 수 대신 Firestore 문서 크기 규칙(`fsSize`)으로 셈, 브라우저 저장소 큰 항목 3개 표시. 확인: Playwright로 만들기 · 지우기, LibreOffice로 엑셀 열어 봄.

- 2026-11-20(4): 광장을 **장미 정원** 한 가지 분위기로 새로 그림(유진이 보낸 동숲 사진: 짙은 초록 잔디 · 분홍 장미 · 크림 돌 원형 광장 · 나무 데크 · 숲으로 감싼 가장자리 · 앞쪽 흙 절벽). 색은 `PZ` 팔레트만. 물품 그림 `plzArt`(16칸, 큰 나무 · 벚꽃나무 · 장미 아치 · 꽃집 · 퍼걸러 · 분수는 32칸 `PLZ_SZ`), 옛 `pmDrawItem` · `plzFloor` 지움. 안 어울리던 것 바꿈(id는 그대로, 이름 · 그림만): 풍차 → 나무 데크(바닥), 열기구 → 꽃집, 시계탑 → 정원 대문, 망원경 → 백합 화분, 미끄럼틀 → 통나무 울타리, 텐트 → 파라솔 테이블, 모래놀이터 → 촛대, 모닥불 → 새장 랜턴, 해바라기 → 튤립, 토끼집 → 그루터기 화분, 사과나무 → 꽃나무, 소나무 → 둥근 덤불, 무지개 아치 → 장미 아치, 돌길 → 꽃 타일. 돌 원형 광장(`PLZ_CIRCLES`) · 디딤돌 길(`PLZ_PATHS`)은 처음부터 깔림, 풀밭 장식은 장미 송이 · 꽃잎.

- 2026-11-20(3): 광장 디자인 다시(유진: 이것저것 갖다 놓은 느낌, 조화 X). 「한 장소」처럼 구조를 줌: `plzBase` 연한 체크무늬 잔디 + 위쪽 숲 가장자리, `PLZ_PATHS` 흙길이 늘 깔림(입구 → 분수 광장 → 다리 → 캠프, 광장 → 왼쪽 정원, 광장 → 아치) + 광장 자리 흙마당, 「돌길」 물품은 이제 흙길에 디딤돌을 박음. 물품마다 그림자. 풀밭 꽃은 길가 · 물품 발치에 모여 핌. 무작위 풀잎은 1/3만.

- 2026-11-20(2): 광장 정돈(유진: 조화롭지 않고 정신없음). 물품 한 칸을 바닥 칸의 0.62배(`s1`)로 작게 그려 사이사이 풀밭이 보이게, 큰 것(`PLZ_BIG` 2배)은 아치 · 풍차 · 벚꽃나무 · 시계탑 · 정자 · 분수 · 나무만. 색을 따뜻한 파스텔로 맞춤(회색 가로등 · 깃대 → 나무색, 빨간 지붕 · 우체통 → 연분홍, 보라 망원경 → 하늘색, 회색 돌 → 베이지). 풀밭 장식은 꽃 · 작은 버섯만, 개수 절반(최대 70). 시냇물 폭 13 → 10칸, 왼쪽 나무들 자리 다시.

- 2026-11-20: 도장깨기에서 받은 세포 이름 아래 뭘 해서 받았는지 작게(「응가 100」 「연속 작업 3일」, `.dex-why`). 예전엔 받으면 조건 글이 사라졌음.

- 2026-11-19(3): 광장에서 현미경 조형 · LN2 탱크 조형 뺌(유진: 광장에 웬 현미경) → 같은 조건으로 미끄럼틀(Split 25) · 해바라기 밭(Stock vial 40).

- 2026-11-19(2): 방문 세기(오늘부터): `petVisit()` 앱 열 때마다 `visitOpens`+1, 날이 바뀌면 `visitDays`+1, 30분 넘게 떠났다 오면 한 번 더. 계정 동기화(큰 값). 선물: 출석 도장(7일) · 단골손님(30일) · 터줏대감(100일) · 문 열쇠(100번) · 대문(500번). 광장: 모두의 방문한 날로 환영 매트(20) · 시계탑(100), 풀밭 장식도 방문 2일마다 하나. 광장 꾸미기 패널 글 줄임(유진: 말 너무 많음): 제목 · 카드 · 「보관함 n」만.

- 2026-11-19: ① 세포 친구: 새 도감 20종(DNA 나선 · 박테리오파지 · 짚신벌레 · 규조류 · 물곰 · 항체 · 리보솜 · 엽록체 · 바이러스 · 골지체 · 세포핵 · PCR 튜브 · 전기영동 젤 · 볼텍스 · 타이머 · 클린벤치 · 매트리젤 돔 · 셀 스트레이너 · 파라필름 · 랩 커피), 다음 단계 선물(황금 응가 = 응가 300, 응가 대마왕 = 1000, 꽃다발 = 꽃 100, 꽃 요정 = 300), 도감 80 · 90 숫자 친구(DG에 8 · 9 추가). 새싹 그림 다시(줄기 + 잎 두 장). ② 광장 꾸미기 11 → 36개, 동물의 숲처럼 구역 나눠 배치(`PLZ_SPOT`): 뒤 풍차 · 소나무 · 무지개 아치 · 벚꽃나무 · 망원경, 가운데 분수 + 가로등 2 · 벤치 2 + 입구 돌길, 오른쪽 굽이치는 시냇물(`PLZ_STREAM`) + 나무 다리 + 건너편 랩 코너 · 캠핑 · 연못, 왼쪽 정원 · 그네 · 모래놀이터 · 정자, 앞 표지판 · 꽃밭 · 우체통 · 토끼집 · 레모네이드 가게. 바닥 것(시냇물 · 돌길 · 연못 · 전구줄)은 `plzGround`. 끝없이 느는 풀밭 장식(`plzGrow`: MC 10 · Split 2 · Stock vial 2 · 일한 날 1마다 꽃 · 버섯 · 돌 하나, 최대 220). 설정 패널: 가까운 목표 6개만, 놓인 건 「보관함」(접힘), 카드에 「MC 15 달성」처럼 뭘 해서 생겼는지. ③ 다같이 춤추기 8종(흔들흔들 · 옆으로 착착 · 기차놀이(원 그리며 걷기) · 트위스트 · 파도타기 · 빙글빙글 · 콩콩 점프 · 둠칫둠칫), 같은 춤 연속 안 나옴, 춤 6 → 8초.

- 2026-11-18(5): 그림 배경 20종 추가 + **매일 바뀜**(4일 → 하루, 기준 2026-11-18 = 우주). 새 그림: 우주 · 무지개 · 비눗방울 · 꽃밭 · 딸기 · 구름 · 토끼 · 아이스크림 · 벚꽃 · 레몬 · 펭귄 · 열기구 · 버섯 · 마카롱 · 양 · 복숭아 · 비(우산 · 개구리) · 해바라기 · 선인장 · 해파리. 기존 그림과 같은 방식(오른쪽 아래 큰 그림 + 작은 무늬 반복, 단색 바탕, 얼굴은 같은 눈 · 볼터치). `ART_ROTA` 37종을 새 것 · 예전 것 섞어 돌림, 12/18–26 크리스마스 그대로. 화면에 안내 없음(비공개). SVG는 스크립트로 만들어 CSS에 넣음(약 100KB).

- 2026-11-18(4): ① LN2 종류 칩: **이름에 Tumor가 있으면 무조건 Tumor-org**(유진 규칙, 전에도 말함). `KIND_RULES`의 PHH-org · Hep-org · Chol-org는 `_kTumor()`(tumor 있고 Tumor margin 아님)면 빠짐 → 「HCC27 tumor | PHH-org」는 Tumor-org만. ver 470에서 YJ HCC27 PHH-org 13 → 11. 예전 분류(`MATCH_CATEGORIES`)는 원래 그렇게 되어 있었음. ② PPT 제목 - → 띄어쓰기는 체크 없이 늘 전부(종류 이름 예외도 없앰, `pptUndash`), 직접 고친 제목만 그대로. 화면에 안내 글 없음(유진: 사이트에 뭐 쓰지 말기).

- 2026-11-18(3): 유진 캡처 6가지. ① 이름·스케일바 [저장] 「A requested file or directory could not be found」: 기억해 둔 저장 폴더가 지워졌거나 옮겨지면 권한은 남아도 쓰기에서 NotFoundError → `sbDirAlive()`로 폴더가 있는지 먼저 보고 없으면 잊고 다시 고르게, 저장 중 파일 하나가 안 써지면(경로+이름이 Windows 260자 넘음 등, 확인 필요) 건너뛰고 끝에 못 쓴 파일 목록 + 짧은 경로 폴더로 바꾸라는 안내. 「시스템 파일이 포함되어 있어 열 수 없음」은 Chrome이 바탕화면 · 문서 맨 위 같은 폴더를 막는 것 → 그 안에 새 폴더를 만들어 고르면 됨. ② 촬영 순서: well 1 ~ well 10 고정 칩(`slRenderWellChips`, 최근 칩에는 안 쌓음). 파일 이름에는 `well-3`로 들어가고 PPT `pptParse`가 `well-3`도 well로 읽음(헤더엔 「well 3」). ③ LN2 HCC27 PHH-org 13개(YJ): ver 470 실제 파일로 하나씩 대조 → 맞게 셈(O3-I 11 + O3-C 2). 단 O3-C 「HCC27 tumor | PHH-org | p5」 2개는 Tumor-org와 PHH-org 양쪽에 들어가고, O3-I 4-8은 **Contam** 표시가 있는데 셈에 포함. 코드는 안 바꿈. ④ 사이드바 끝까지 내려도 인큐베이터 아래 12px가 설정 칸에 가려지던 것(`.side-incu` 아래 여백 26px). ⑤ 다이어리 · 이번 주: 정해진 묶음에 없는 액션은 「기타」 대신 칩에 적은 액션 이름(`_twGroup`, 순서 `_twOrder`). ⑥ PPT: 「제목 - → 띄어쓰기」 체크(PPT 만들기 창 · 미리보기, `pptCuts['dash:*']` 동기화, Tumor-org · PHH-org · Tumor-CAF 의 - 는 남김, 직접 고친 제목은 그대로). PPT 창 안내문이 없어진 ✄ 제목 자르기 · 배율×날짜 그리드를 말하고 있어서 지금 방식(자동 꽉 채우기 · 썸네일 눌러 다음 장 붙이기)으로 고침. 확인: Playwright로 칩 · 제목 바꾸기 · 사이드바 · ver 470 LN2 읽기. 실제 Windows 폴더 저장은 못 돌려 봄(확인 필요).

- 2026-11-18(2): 큰 광장(유진 휴대폰 캡처). ① 세포 끌어 옮기기(`pmDragInit`, 내 화면에서만): 누른 세포를 끌어 놓으면 8초 머물고(`e.hold`) 1.5초 동안 원래 걷던 자리로 걸어감. ② 휴대폰(광장 폭 560px 미만)은 세포 0.8배 · 글자 10px · 물품 배율 작게. 너무 붙은 세포는 살짝 밀어냄(짝꿍 · 춤출 때 빼고, 밀어낸 양은 부드럽게 따라감). ③ 이번 주 랩 목표 MC 60 → 150(수요일에 52/60이라).

- 2026-11-18: PPT 자동 배치 손봄(유진 캡처: CM-test에서 한 well의 4x · 10x · 20x가 줄 사이에서 끊기고 글자가 사진보다 큼). ① 배치 고를 때 행 · 열 수를 곱(날짜 4 × 배율 3 = 12)이 아니라 실제로 사진 있는 조합 수(8)로 셈(`cnt`) → CM-test가 줄 감기 대신 행 = 조건 × well, 열 = 날짜 × 배율로. ② 줄 감기(`wrap`)는 묶음(바깥 축 같은 칸들)을 쪼개지 않게 `p.bands`로 통째로 다음 줄에, 고를 때도 묶음 크기 이상인 k만(`cnt.groups`). ③ 「Pre-처리」「Pre-split」 같은 조각은 조건이 아니라 그날 찍은 때로 보고 날짜 머리에 붙임(같은 well끼리 줄이 맞게). ④ 꽉 채우기 장은 머리 글자 크기를 사진 폭에 맞춰(8–12pt, 묶음 이름은 칸 폭에 맞춰 줄임), 배율이 행 · 열 이름에 있으면 사진 위 4x 표시는 뺌(`noMagBadge`).

- 2026-11-17(15): 「P 올리지 않기」 체크 옆 결과 글자 뺌(유진: 잡다한 글 X).

- 2026-11-17(14): 광장 물품도 세포처럼 픽셀 그림(유진). `plzPixelize`: 18×18 칸에 한 칸 = 1점으로 그린 뒤 반투명 점 버리고, 바깥에 그 색을 어둡게 한 테두리(세포 `drawPet`와 같은 방식), `plzSprite` 캐시 → 정수 배율로 찍음(무지개 2배). 분수 아래 돌바닥도 픽셀 타원(`plzFloor`). 설정 › 광장 물품 칸 그림도 같은 그림.

- 2026-11-17(13): ① 기록 입력 Stock 헷갈림(유진): 칩 아래 「P+1」「P 유지」 글자 빼고(Split은 d0만), 체크는 「P 올리지 않기」(Pellet은 「P 올리기」) + 옆에 지금 결과(「P +1 · 바이알도 올라간 P로 적혀요」). 「vial P 자동/작업 전 P/P+1」 고르는 칸은 기록 · 수정 창 모두 뺌(예전 `stockPOff`는 읽기만, 수정 창에서 액션을 바꾸면 지움). ② 광장 꾸미기: 2026-11-17(`PLZ_START`)부터 센 기록만, 광장 프로필 칸 이름 `tot` → `deco`(from 함께 저장, 예전 누적값 무시), 기준을 낮춤(MC 15/40/80/150/400, Split 8/25, Stock vial 10/40, 일한 날 40). 물품을 2.4배(작은 광장 1.25배)로 키우고 방 꾸미기처럼 배치: 가운데 분수 + 돌바닥 타원, 뒤 무지개 · 깃발, 양옆 벤치 · 가로등, 왼쪽 나무, 오른쪽 현미경 · 탱크, 앞 입구 표지판 · 꽃밭 · 피크닉. ③ LN2 검색: 결과 맨 위 개수 요약(`renderCountSummary`: vial · HCC 수 · 종류 · 사람 · passage). 종류 칩을 고르면 환자(HCC)별 짝 표(`computeMatchTable(keys, byKind)`, 열 이름 `mLab`), 여러 종류면 다 가진 환자부터. 예전 분류 칩(cats)이 골라져 있으면 그걸로.

- 2026-11-17(12): Media 튜브 그림: size가 50이 아니면(40 ml로 저장된 튜브 등) 15 ml 모양으로 작게 그려지던 것 → `mdCap`(15 ml보다 크면 50 ml conical)로 그림 크기 · 채움 비율 · 「/50 ml」 표시. 저장된 size 값은 그대로(유진: 40 ml 튜브가 왜 작냐).

- 2026-11-17(11): 현미경 사진 PPT를 자동 꽉 채우기로(유진 제안 수락). `pptPlanAuto`가 `pptPlanNamed` 대신(예전 코드는 남김): 실험(제목)마다 날짜(date · P · d) · 조건(제목 자르기 조건 + well + extra) · 배율 세 축 중 2개 이상인 것을 행/열에 나눠 놓는 모든 경우 + 한 줄짜리는 여러 줄로 감기(`wrap`)를 따져 `pptAutoChoose`: 장 수 최소 → 사진 폭 최대(3cm 미만은 다른 배치가 없을 때만) → 날짜 · 배율은 열 쪽 우선. 실제로 사진 있는 조합만 행 · 열로, 2단이면 바깥은 묶음 줄(`colGroups`) · 행 묶음(`rowBreaks` + 「바깥\n안」). 장마다 행 수를 고르게. 「한 장에 n행 − / +」(`pptCuts['rows:'+실험]`, 배치는 그대로 두고 행 수만). 이름 끝만 다른 형제 실험(for-CM-test-CM/FM/MM)은 한 실험의 조건으로 묶음(끝을 뗀 이름이 따로 있으면 안 묶음: for-Neoantigen vs -2nd). `p.fill`이면 4열 폭 상한 없이 키우고 가로 가운데. 이름 해석: p 앞 「D3」을 day로 읽던 것(`pptStructAt`), A1 · D3 같은 plate 칸은 조건으로. UI에서 Data meeting 배치 · 열 개수 · 환자별 설정 · 마일스톤 · 제목 자르기 · 배치 고르기 · 한 줄에 n장 · well별/날짜별 묶기 · 다음 장 붙이기 뺌. 남긴 것: 검은 배경, 슬라이드 제목 넣기, Summary 장(환자 체크), 썸네일 눌러 고치기 · 되돌리기. 유진 사진 이름 목록(HCC18 IFNg · HCC27 CM-test · Assembloid 36칸 · HCC41 10 well · HCC37 PF)으로 확인.

- 2026-11-17(10): Stock 이름을 엑셀 STAR_ID 모양에 맞춤(유진: for 뒷부분 빼고 그 앞까지만). 엑셀 최근 줄은 「HCC39 / Tumor-org A / p1 / 26.11.03」, HCC 환자 PHH-org는 「Adj(N) PHH-org」. `stockDetail`(세부명에서 for 이후 삭제) · `stockType`(HCC + PHH-org → Adj(N) PHH-org)로 LN2 넣을 바이알 이름 · 박스 칸 글자 · 오늘 작업 Stock 후처리 이름. Split P유지는 지금처럼 P · d 그대로(유진: d는 그날 것), 해동 새 라인은 d0부터(원래 그렇게 됨).

- 2026-11-17(9): ① 광장 물품을 위쪽 한 줄 → 풀밭 안 고정 자리(`PLZ_SPOT`, x 0–1 · 바닥선 y 0–1): 무지개 아치 가운데 뒤(크게), 분수 가운데, 벤치 분수 옆, 가로등, 나무 왼쪽 구석, 현미경 · LN2 탱크 오른쪽, 표지판 · 꽃밭 왼쪽 앞, 피크닉 매트 · 깃발 오른쪽 앞. y 순으로 그림, 세포 뒤에. 큰 광장은 칸 1.5배. ② 점검: Stock 기록을 지우거나 날짜를 바꾸면 Stock 후처리 · LN2 넣을 바이알에 유령 항목이 남던 것 → `stockCleanup`(그 날 vial 기록이 더 없고 아직 LN2 · DB 체크 전이면 지움), 날짜를 옮기면 항목 날짜도 같이, vial 수를 0으로 고치면 지움, 휴지통에서 되살리면 다시 생김. 데모 데이터로 7개 탭 버튼 약 350개 눌러 보기: 오류 없음.

- 2026-11-17(8): 광장 꾸미기(유진: 모두 같이 쓰는 광장, 물품은 정해진 자리). 따로 저장 · 규칙 추가 없이 광장 프로필(`players/{uid}`)에 내 누적 기록 `tot:{mc,split,stock,days}`(`plazaMyTot`, Seeding · 완료 기록 빼고, stock은 vial 합)를 같이 올리고, `plazaLabTot`로 모두 더해 `PLZ_ITEMS` 기준을 넘으면 그림. 물품 11개(표지판 MC30 · 벤치 MC100 · 꽃밭 Split30 · 가로등 MC250 · 나무 Stock vial 40 · 분수 MC500 · 현미경 Split120 · LN2 탱크 Stock vial 150 · 피크닉 매트 일한 날 300 · 무지개 아치 MC1500 · 이번 주 목표 깃발). 자리는 물품마다 고정, 풀밭 위쪽 줄 왼쪽부터 같은 간격(`pmDrawLab`, 작은 광장은 칸 크기를 줄여 맞춤). 설정 › 광장에 「광장 꾸미기」 칸(`plazaDecoHTML`): 물품 그림 · 진행 · 다음 물품. 업데이트 뒤 각자 앱을 한 번 열어야 그 사람 기록이 더해짐. Firestore 규칙이 players 문서 필드를 막고 있으면 tot가 안 올라감(그때는 규칙 확인).

- 2026-11-17(7): ① 한결쌤 「HG 아무리 쳐도 안 됨」 · 바이알 연동 안 됨 · 해동 → 새 라인 「앱과 연결이 안 돼요」 · 기록 탭 로딩: 모두 (5)①의 같은 원인. LN2 탭에서 새로고침하면 첫 `setTab`(5618행 근처) 오류로 스크립트가 거기서 멈춰 `window.cclLn2`(8404행 근처) · `_lateReady` 등 뒤쪽 코드가 안 만들어짐 → 이니셜 저장 · Stock 가져오기 · 해동이 조용히 실패, 기록 탭은 `_lateReady`가 없어 안 그려짐. 기록 탭 그리기 자체는 라인 60 · 기록 3600개로 30ms 이하. ② LN2 Stock 넣기: 바이알을 고르면 「Cell information」 패널(`stCiPanelHTML`): 자동으로 찾은 줄 + 이름(STAR_ID 첫 줄)이 같은 줄 고르기(`ST.ciLink[원래 칸 키]=행`), 사용날짜 · 위치 · Information · 비고를 고치면 `ST.ciEd[행][칸]`, 내려받을 때 자동 해동 · 이동 값 뒤에 덮어씀. 해동한 바로 뒤에도 그 줄을 띄워 둠(`ST.ciShow`). 「해동 · 새 라인 등록」(`stOpenLine` → `cclLn2.thaw`, 여러 개면 첫 바이알로), 바뀐 칸 목록의 해동 줄마다 「새 라인 등록」. 되돌리기에 ciEd · ciLink 포함.

- 2026-11-17(6): 한결쌤 「J열」 = 박스의 J행. Black-LINE 4 HG 4-A 아래(시트 13행)에 빈 「J」 글자만 남아 있어 9×9 박스가 A–J 10행으로 읽히고, Stock 넣기에서 없는 J행에 바이알을 넣을 수 있었음. `parseBigLine` 끝에서 빈 끝 행을 max(9, 열 수)까지 잘라냄(예전엔 10행 넘을 때만).

- 2026-11-17(5): 잔오류 + LN2 박스 고치기 + passage 체크.
  ① LN2 탭에서 새로고침하면 빈 화면: 첫 `setTab('ln2')`가 `<template id="ln2Tpl">`(스크립트 뒤쪽)보다 먼저 불려 null 오류 → 그 오류가 첫 스크립트까지 멈추게 했음. `openLn2`가 템플릿이 없으면 DOMContentLoaded 뒤에 띄움.
  ② 창 여러 개: 창마다 데이터를 메모리에 따로 들고 있어 뒤에 저장한 창이 덮어쓸 수 있었음. `storage` 이벤트(`LS_SYNC` 키)로 다른 창이 바꾸면 0.4초 뒤 `lsPullOtherTab` → `applySyncData`, 가려진 창은 다시 볼 때. (file:// 에선 storage 이벤트가 안 와서 테스트는 http 주소로)
  ③ 사진 저장이 가끔 안 되던 것: 확인 창을 띄운 뒤에 폴더 권한을 물어서, 확인 창을 오래 보면 사용자 동작이 만료돼 권한 요청이 조용히 실패 → 아무것도 안 하고 끝. 폴더부터 받고(`sbGetDir`) 확인 창. 실패면 「한 번 더 눌러 주세요」(`_sbDirErr`).
  ④ 기록 액션 이름: 저장 값은 그대로(Split / Split (passage 유지) / Stock (p+1) / Stock (passage 유지) / Pellet …), 화면 칩은 Split · Stock · Pellet 하나씩 + 「passage 유지 (P+0)」 체크(`setPKeep`, Pellet은 「passage 올리기 (P+1)」). 목록에는 `actLabel`로 기본이면 이름만, 아니면 「Stock · P유지」. `isPassageUp`은 '유지'가 들어가면 false(Split (passage 유지) 때문). Reseeding은 그대로. Split 기록에도 Stock vial 칸.
  ⑤ Stock 바이알 P: 기록 P는 작업 직전 P라서 LN2 · Stock 후처리에 한 단계 낮게 뜨던 것 → `stockVialP(lg)` = P + (P를 올리는 액션이면 1). 기록 창 Stock vial 옆 「vial P 자동 / 작업 전 P / P+1」(`lg.stockPOff`)로 직접 고를 수 있음. 같은 날 P 올리는 기록이 둘 이상이면(`stockPWarn`) 「P 확인」 표시. 기록을 고쳐 vial 수를 넣으면 `stockSyncFromLog`로 Stock 후처리 목록도 생김. 앱 Stock 기록이 바뀌면 열린 LN2 창 다시 그림(`ln2Notify`).
  ⑥ LN2 Stock 넣기 박스: 원래 바이알도 끌어서 옮기기(잡은 칸이 놓은 칸으로), 칸 눌러 여러 개 고르기 · 빈 칸에서 끌면 네모로 고르기 → 같은 모양 그대로 옮기기, 다른 박스로는 고른 뒤 그 박스 빈 칸 누르기, 「해동 · 빼기」, 한 칸 고르면 글자 고치기, 되돌리기/다시(Ctrl+Z/Y, `ST.hist`). 상태는 `ST.ed[시트|박스|행|열]={text,from,thaw}`, 내려받을 때 원본 XML 칸을 통째로 옮겨 서식 유지, 빈 칸은 박스의 빈 칸 서식으로. Cell information은 「위치」의 칸 번호(B-7, B-8)나 박스 + STAR_ID 글자(거의 같아야)로 줄을 찾아 위치에서 칸 빼기/바꾸기 · (n vial) 다시 세기, 사용날짜에 「HG 1 vial B-7 (26.11.17)\n: 1 vial 남음」(앞 내용 있으면 \n-\n 뒤에). 못 찾으면 목록에 「cell information 줄 못 찾음」.
  ⑦ 파일 이름에 붙은 「 (1)」 지움. 한결쌤 파일로 ver_471 · 날짜 · 이니셜 바뀌는 것, 바이알 연동되는 것 확인(Stock 기록에 vial 수가 있어야 뜸). J열(사용날짜) 문제는 재현 못 함 → 유진에게 어떻게 이상한지 물어봄.

- 2026-11-17(4): ① 새 라인 창 프로젝트 칸 안내 글에 유진 프로젝트 이름(「Neoantigen, 이원화 교수님 Project 6」)이 박혀 모두에게 보이던 것 → 일반 문구로. ② 프로젝트 관리 창(`#projMgr`, 배양 라인 탭 폴더 아이콘): 만들기 · 이름 바꾸기(그 프로젝트 라인 전부) · 지우기(라인은 「프로젝트 없음」). 미리 만든 프로젝트는 `orgProjects` → 계정 `prefs.projects`로 동기화, 사람마다 따로. `projectsAll` = 저장 목록 + 내 라인 프로젝트. ③ 새 기능 알림창 자동으로 안 띄움(유진, 당분간). 설정 왼쪽 아래 「새로 생긴 기능」으로만. NEWS 내용은 계속 고쳐 둠.

- 2026-11-17(3): 날짜를 행으로 바꾸면 왼쪽만 차서(유진), 「다음 장 붙이기」 뒤 기본을 well별 묶음으로(`pptEdSwapGroup`): 위 묶음 줄 = well, 그 아래 열 = 날짜(두 줄: 날짜 / P · d), 행 = 배율 → 같은 well 시간 변화가 옆으로, 같은 배율은 한 줄, 가로를 꽉 채움. 툴바 버튼은 「well별로 묶기 ↔ 날짜별로 묶기」 하나(`e.byWell`). `pptEdDatesToRows`는 코드만 남김(버튼 없음).

- 2026-11-17(2): PPT 슬라이드 고치기 「날짜를 행으로」(`pptEdDatesToRows`, `pptEdToRows`): 날짜 줄로 묶인 열(날짜 × well) → 행 = 날짜 × 배율(날짜 묶음 + 세로 선), 열 = well. 그 날 안 찍은 배율 행은 뺌. 날짜가 2개 이상인 장에 버튼, 「다음 장 붙이기」 뒤에는 자동으로 바꿈(유진: 같은 well 비교라 날짜가 행).

- 2026-11-17: ① Media: 다 쓴 튜브(0 ml)는 보관함에서 숨김(계산엔 남음). ② 큰 광장 별명 바꾸면 풀밭 이름표 · 내 카드에 바로. ③ 세포 「모두 밥 주기」(`petFeedAll`, 팝업 · 설정). ④ 기분 칸 대신 친화도(`PET_LV`, 쓰다듬기 수 o.pats로 Lv.1–10: 0·6·15·30·50·80·120·170·240·320), Lv.3 볼 하트 · Lv.5 리본 · Lv.8 왕관 · Lv.10 반짝(`drawPet` st.lv, 없으면 내 세포 Lv). 레벨 오르면 알림. 광장에 `repLv` 올려 다른 사람 세포도 그 사람 레벨로. hap 값은 안 보이게만 남김. ⑤ 사진 이름 · 스케일바 「이름순 정렬」(`sbSortByName`, 날짜 묶음 안에서 파일 이름 번호순). ⑥ 압축 없는 8bit TIFF는 미리보기용 점만 바로 읽음(작업자 `fastPrev`, 2×2 평균): 30장 2.8초 → 1.0초(테스트 PC). 압축 TIFF · 원본 저장은 예전처럼 전체 해독. ⑦ 배양 라인 탭 「종류 / 프로젝트」 묶기(오늘 작업 배양 현황과 같은 `_boardBy`), 라인 머리 프로젝트 칩(`setLineProject`). ⑧ PPT 슬라이드 고치기: 「+ 열 · + 행」 · 「같은 실험 다른 장」 사진 줄 빼고 「다음 장 붙이기」(`pptEdMerge`): 같은 실험 다음 장을 이 장에. 열(날짜 줄 포함)이 같으면 아래로, 다르면 옆으로 이어 붙이고 같은 날짜 줄은 하나로. 합친 뒤 제목 (n/m) · 날짜 범위 다시. 안내 글 한 줄로. NEWS 2026-11-17.

- 2026-11-16(11): 다같이 춤추기를 가운데로 모여서 추게(유진). 1.6초 동안 가운데 둥근 대형(`pmRing`, uid 순서로 한 바퀴, 사람 수에 따라 원 크기)으로 걸어가고 → 6초 가운데를 보며 같은 춤 → 1.6초 동안 지금 있어야 할 자리로 걸어 돌아감(끝나고 순간 이동 없음). 춤 동안 짝꿍 손잡기는 쉼. 시작 자리는 화면마다 따로 저장(작은 · 큰 광장 크기가 달라서 `dn._st[cvId]`). NEWS 문구도 고침.

- 2026-11-16(10): 휴대폰에서 「배양 현황」 제목이 세로로 쪼개지던 것 고침(머리 줄이 넘치면 버튼은 다음 줄로, 높이 자동). 배양 현황 머리에 「전체 선택」(`selectAllActive`, 진행 중 라인 모두). 다 골라져 있으면 숨고 「n개 선택 해제」만. 원래는 종류 · 프로젝트 이름 줄을 눌러 그 묶음만 고르는 방식이었음.

- 2026-11-16(9): 휴대폰에서 메뉴(사이드바) 안 작은 광장을 누르면 메뉴가 그대로 열려 있던 것 → 광장을 누르면 메뉴 닫고 큰 광장만(`.pm-box` 클릭 시 `closeSide`, `plazaOpen` 시작에서도 `closeSide`).

- 2026-11-16(8): 큰 광장 오른쪽 「광장에 나 보이기」 켜고 끄기 없앰(유진: 광장엔 무조건 보냄). `_plazaOff`는 늘 false, 예전에 꺼 둔 `orgPlazaOff`도 지움. `plazaSetOff`는 남았지만 부르는 곳 없음.

- 2026-11-16(7): 광장 세포가 미끄러지듯 빨리 움직이던 것(7초마다 아무 데나 새 목적지 + 가속 곡선 + 느린 다리). 사람마다 느리게 굽이치는 길(`pmPath`, 사인파 둘 · 2–3분 주기)을 따라 걷게 바꿈. 7초 칸 중 앞 60%만 길 위 시간이 흐르고 나머지는 서서 행동. 다리는 280ms마다(`_pm.frame` 140ms). 잰 값: 큰 광장 걷는 중 평균 10px/s · 최대 22, 작은 광장 최대 5px/s, 순간 이동 0. `pmWay` 없앰. 여전히 (사람 id · 시각)만으로 정해져 화면 · PC끼리 같은 자리.

- 2026-11-16(6): ① 설정 › 세포 카드 그림이 비던 버그: 카드 canvas id `pmCv` · class `pm-hd`가 광장 미니와 겹쳐 `getElementById('pmCv')`가 광장 canvas를 잡고, 광장 `.pm-hd` CSS(초록 띠)가 카드 머리를 덮음 → 카드 쪽만 `petDetCv` · `.pd-hd`로 바꿈(광장 쪽 그대로). ② 광장 자리 통일: 화면마다 따로 랜덤이던 움직임을 「세계」 하나로(`pmWorld`): 위치 = (사람 id · 날짜 · 시각) 시드로 정한 0–1 좌표(`pmRand`, `pmState`: 7초 칸마다 다음 자리로 걷고 남은 시간엔 쉬기 · 폴짝 · 춤 · 낮잠 · 인사; `pmPairs`: 42초마다 짝꿍), 각 화면은 자기 크기로 늘려 그림 → 작은 광장 · 큰 광장 · 다른 사람 PC가 같은 장면(시계가 맞으면). 짝꿍 아닌 세포끼리는 0–1 좌표에서 살짝 떨어뜨림. 풀 · 꽃 자리도 날짜 시드. 예전 `pmPick` · `pmPair` · `pairT` 없앰. ③ 큰 광장 머리 「다같이 춤추기」(`plazaDance`, `_pmDance`): 이 화면 광장의 세포 모두 같은 춤(좌우 흔들기 · 점프 · 빙글 돌기 · 웨이브 중 랜덤) · 같은 박자(260ms)로 6.5초, 춤 시작 때 자리에서 추고 끝나면 다시 걷기. 다른 사람 화면까지는 안 퍼짐(그러려면 Firestore에 춤 신호를 써야 함). NEWS 2026-11-16b.

- 2026-11-16(5): 그림 배경을 매주 월요일 → 4일마다 바꿈(`weeklyArt`, 2026-11-02부터 4일씩 `ART_ROTA` 한 칸; 11/14–17 연필, 11/18–21 가을, 11/22–25 도토리 …). 크리스마스(12/18–26) 고정은 그대로. 켜 둔 채 날이 바뀌어도 10분마다 확인해서 바꿈.

- 2026-11-16(4): 광장 풀밭에서 한 줄 상태(`msg`)를 세포 머리 위 말풍선으로(흰 둥근 칸 + 아래 꼬리, 풀밭 밖으로 안 나가게). 큰 광장은 모두, 작은 광장은 이름표가 보이는 세포만. 내 상태를 바꾸면 바로 반영(`plazaMiniSync`).

- 2026-11-16(3): 메인 광장이 새로고침 뒤 늦게 뜨던 것(로그인 확인 ~1초 + 목록 받기 + 넣어 둔 1.5–3초 대기). 받은 광장 목록을 `orgPlazaCache`({uid,list})에 저장해 두고 페이지 열리자마자 그걸로 먼저 그림(`plazaCache`), 로그인 확인되면 바로 새 목록. 로그아웃이면 캐시 지우고 숨김. 대기 시간 뺌.

- 2026-11-16(2): 광장을 설정에서 빼고, 메인 작은 광장을 누르면 큰 광장 창(`plazaOpen`, `#plazaModal`): 왼쪽 큰 풀밭(모두 이름표, 세포 크게), 오른쪽 내 별명 · 한 줄 상태 · 대표 세포 · 나 보이기 · 랩 목표 · 함께 쓰는 사람(`plazaPanelRefresh` = 예전 `plazaHTML` + `plazaLoad`). 그리는 코드는 무대 두 개가 같이 씀(`_pmMini` · `_pmBig`, `pmWith`, `pmTick`, `pmSetEnts`; sp 세포 크기 · k 배율 · fs 이름표 글씨). 설정 › 광장 버튼은 늘 숨김, `openSettings('plaza')`는 큰 광장으로. Esc · 바깥 · × 로 닫힘. Firestore 규칙은 유진이 넣음(우체통 관리자 = 유진 계정, 규칙에만).

- 2026-11-16: 광장 · 다이어리. ① 랩 협동 목표 이번 주 MC 300 → 60(`LAB_GOAL`, 유진 「well당 60회」를 주당 랩 전체 60회로 읽음, 확인 필요). ② 설정 › 광장에 「광장 대표 세포」 고르기(`orgPlazaRep`, `plazaRep`, players 문서에 `repName` 추가). ③ 광장 목록 맨 위에 내 카드(「나」), 카드 이름은 「세포 이름 (별명)」, 「받은 꽃」 대신 이번 주 MC. ④ 꽃 보내기 뺌(버튼 · `plazaSend` flower 막음), 세포 보내기는 남김. ⑤ 메인 화면 사이드바 인큐베이터 위 작은 풀밭 광장(`#plazaMini`, `plazaMiniSync` · `plazaMiniTick`): 나 + 광장에 나온 사람(최대 11명)의 대표 세포가 돌아다님. 걷기 · 쉬기 · 폴짝 · 춤 · 낮잠(z) · 인사, 가끔 둘이 손잡고 같이 걷기(하트). 이름표 「쿠뽀 (YJ)」는 나 + 한 명씩 돌아가며, 마우스 올리면 모두. 누르면 설정 › 광장. 로그인 · 광장 열림 · 「나 보이기」일 때만, 5분마다 새로. ⑥ 다이어리 「실험 찾기」 칸(`_dyQ`, `dySearchRender`): 이름 · 내용으로 실험 기록 찾기, 「Aliquot 2번 (마지막 11/12)」 요약, 누르면 그 주 위클리.

- 2026-11-14(21): ① 붓으로 칠하기 뺌(유진: 끌어서 고르고 칠하기면 됨). `figPick` = 바로 `figAssign`(고른 칸 없으면 알림), 붓 관련 변수 · 함수는 비활성으로 남김. ② Figure 편집 창 위 탭 끌어 순서 바꾸기(`figTabDrop`): plate끼리 = plate 순서, Schedule ↔ Plate = 그림 위아래 순서(`f.plateFirst`, Schedule이 맨 앞 아니면 Plate map 먼저), 메모는 늘 끝. Schedule 안 줄(라인) 탭도 끌어 순서 바꾸기(tracks 순서 = 그림 줄 순서). 놓을 자리에 파란 세로줄. 새 기능 안내 3번 문구도 고침.

- 2026-11-14(20): ① 완료 라인 기록 보기(archDetailModal)에서 기록을 누르면 기록 창이 그 뒤에 열리던 것 → `openLogModal`이 logModal을 body 맨 뒤로 옮겨 위에 뜨게. ② 「새로 생긴 기능」 창을 아이콘 · 연한 칸 없이 「1. 이름 설명」 번호 목록으로(진한 글씨), 내용을 11/14 업데이트 6개로 바꿈(`NEWS.id` 2026-11-14 → 「다시 보지 않기」 했던 사람도 5일 동안 다시 보임). items 형식이 [아이콘, 글] → [굵은 이름, 설명]으로 바뀜.

- 2026-11-14(19): 실험 기록 창 단순하게(유진: 드롭다운 · 양식 일단 없애고 자유롭게). 이름 자동완성 목록 · 실험별 칸(`EXP_TPL` 깔기) · 「+ 칸 추가」 화면에서 뺌 → 날짜 · 실험 이름 · 라인(선택) · 내용(자유, 여러 줄). 「지난 기록 불러오기」(`expPastHtml`, 이름 · 내용으로 찾기, 최근 30개) 누르면 이름 · 내용(라인 비었으면 라인도) 가져옴, 날짜는 그대로. 예전에 칸으로 적은 기록은 열면 내용 앞줄 「칸: 값」으로 옮겨짐. 위클리 줄은 칸이 없으면 내용 첫 줄(`expShort`). `EXP_TPL` · `expSetName` 코드는 남겨 둠(다시 쓸 때).

- 2026-11-14(18): 다이어리 「+ 실험 기록」 버튼을 회색 기본 버튼에서 연보라(#EFEBFA · 글자 #4B3F86 · 테두리 #CFC6EC)로. 다이어리 · 타임라인의 실험 기록 표시 색과 맞춤.

- 2026-11-14(17): 오늘 작업 액션 칩에 「배양 완료」(`ACTIONS`의 'Finish (완료)'). 고른 라인을 저장하면 확인 뒤 타임라인 「배양 완료」 버튼과 같은 처리(isCompleted · finishDate · finishDayStr · Finish 기록, 메모 비우면 「실험 종료」, 날짜 여럿이면 마지막 날, 되돌리기 알림). `saveDailyLog` 앞부분에서 따로 처리.

- 2026-11-14(16): PPT 만들기 「PPT figure 같이 넣기」 썸네일에 돋보기(`.pf-zoom`): 누르면 figure를 크게 그려 띄움(`figZoom`), 바깥 · Esc · × 로 닫힘(PPT 만들기 창은 그대로).

- 2026-11-14(15): 환자 요약 슬라이드 제목 「HCC38 요약」 → 「HCC38 Summary」, 부제 「Summary · 대표 사진 …」, 환자별 설정 표 칸 이름 「Summary 장」.

- 2026-11-14(14): 슬라이드 고치기 위 「다 고쳤어요 / 저장」 버튼 뺌. 고치는 중에 아래 「닫기」(또는 창 바깥 누르기)를 누르면 그 장만 닫고 슬라이드 목록으로, 그 썸네일로 스크롤(`closePptLay`). 목록에서 「닫기」는 창 닫기. 목록 위 뒤로 · 앞으로 줄도 뺌(고치는 장 툴바 · Ctrl+Z/Y만).

- 2026-11-14(13): 행이 한 줄(4x만)인 장도 기본은 한 줄에 전부(유진). 자동으로 3장씩 감던 것 · 날짜별 줄 나눔(`bands`) 자동 생성은 뺌(그리기 쪽 `p.bands` 처리는 남김). 고치는 장 「한 줄에」 = 전부(기본) · 2–10장.

- 2026-11-14(12): PPT 고치기 「뒤로 · 앞으로」를 오른쪽 끝(맨 오른쪽)으로, 글자 대신 휘어진 화살표 아이콘(`i-undo` · `i-redo`, `pptHistBtns`), 마우스 올리면 「되돌리기 (Ctrl+Z) / 다시 하기 (Ctrl+Y)」.

- 2026-11-14(11): PPT 배치 창 옵션 줄이기(유진: 너무 잡다함). 「환자별 설정」 표 하나(`pptPtRowsHtml`): 환자마다 한 줄 = 제목 · 열 개수 · 배치 · 요약 장(넣기 + 「실험 n/m」 접기) · 하루뿐인 실험 한 장에. 따로 있던 「환자 요약 슬라이드」 · 「요약에 넣을 실험」 줄들 · 「한 날짜뿐인 실험」 줄은 표 안으로. 마일스톤은 접힌 한 줄(`pptMsHtml`, 고른 액션 이름만 보임). 설명 글 2줄 뺌.

- 2026-11-14(10): PPT figure 프로젝트로 나누기(`f.project`, 계정 동기화). 편집 창 머리 「프로젝트」 칸(전에 쓴 이름 자동완성), PPT figure 페이지 위 칩(전체 · 프로젝트별 · 미분류, 개수) 거르기(`_figProj`, `figInProj`), 고른 figure 한꺼번에 「프로젝트 지정」(`figProjMany`, 비우면 미분류), 카드에 보라 태그. 「전체 선택」은 지금 보이는 프로젝트 것만. PPT 만들기 figure 목록에도 같은 칩(고른 프로젝트 밖은 아래 접힘으로).

- 2026-11-14(9): PPT 만들기의 「PPT figure 같이 넣기」 목록 정리(유진: 한 번 넣은 figure가 계속 남음). 최근 2주 안에 고친 figure만 펼치고, 그보다 오래된 것 · 숨긴 것은 「이전 · 숨긴 figure n개」에 접음(이번에 고른 건 늘 위). 줄마다 「숨기기 / 다시 보이기」(`f.hideInPpt`), PPT로 만들면 「11/14 PPT에 넣음」(`f.pptAt`, `figMarkPpt`, 사진 PPT · PPT figure 페이지 PPT 둘 다). 둘 다 figure에 저장돼 계정 동기화. figure 자체는 안 지움.

- 2026-11-14(8): PPT 슬라이드 고치기 추가. ① 글자 고칠 때 Enter = 줄바꿈(행 이름 「날짜 / P d / 처리 전」), 저장은 칸 밖 누르기 · Ctrl(⌘)+Enter, Esc 취소(`pptEdText`). ② 날짜를 행으로 쓴 장에서 한 날짜에 배율이 여러 행이면 날짜 · P d를 그 행들 묶은 칸에 한 번 + 오른쪽 세로 선, 행 이름은 배율만(`pptRowGroups`, 그리기만 바꿈 · 데이터는 그대로). 묶음 이름(`rgrp`) · 첫 행 배율을 따로 고쳐도 나머지는 남음. ③ 뒤로 · 앞으로(`pptHist`, Ctrl+Z / Ctrl+Y · Ctrl+Shift+Z): 그릴 때마다 pptEdits · pptCuts · pptLay를 찍어(사진은 id로) 바뀌면 쌓음, 60번까지, 배치 창 열 때 비움. ④ 고치는 장 「한 줄에 [자동 · 2–10장 · 전부]」(`pptEdWrap`, `e.wrapSet`): 4x만 있어 3장씩 감던 장을 5장 한 줄로 등. 확인: Playwright(가짜 사진)로 묶음 그리기 · 줄바꿈 고치기 · 뒤로/앞으로 · 한 줄 전부.

- 2026-11-14(7): PPT 사진 배치 고침(유진 캡처 5건). ① 열 값 칩 순서 끌기: 칩 위에 정확히 안 놓으면 맨 뒤로 가던 것 → 손 위치로 「어느 칩 앞」 정함(`pptNvBefore`), 끄는 동안 파란 세로줄 표시, 칩 조금 크게. ② 「+ 열」만으로는 의미가 없어서: 같은 실험이 여러 장이면 고치는 장 아래 「같은 실험 다른 장」 사진 줄(`.pl-other`) → 끌어 넣으면 그 장에서 빠지고 이 장으로 옮겨짐(빈 장은 없어짐). ③ 행이 한 줄(4x만)이라 3장씩 감을 때 날짜가 중간에 잘리던 것 → 날짜를 열로면 날짜마다 새 줄(`p.bands`, 한 날짜 6장 넘으면 그 안에서만 나눔). 열을 옮기거나 더하면 `bands`는 버림. ④ 여러 줄로 감았는데 날짜 머리글이 다 같으면 맨 위에 한 번만(`oneHead`). ⑤ 이름이 `well-1`이면 `-`로 나뉘어 모든 열에 같은 「well」이 부제로 빠지고 숫자만 남던 것 → 숫자 바로 앞 글자는 열 이름에 남김(`keepPre`, 부제에서도 뺌). ⑥ `HCC41_Tumor-org_well-1_…`처럼 종류 뒤에 well-N 하나만 있으면 세부 라인 이름으로 읽혀 well마다 다른 실험이 되던 것(요약 1/2 · 2/2, 긴 합친 제목) → `PPT_WELLISH`면 조건으로. 확인: Playwright로 가짜 사진(HCC28 · HCC41 · HCC18 이름)으로 배치 · 칩 끌기 · 다른 장 사진 옮기기. 실제 현미경 사진 · 내보낸 PPT는 안 봄.

- 2026-11-14(6): 「실험 기록」 새로 만듦(유진 요청: 배양 말고 qPCR · RNA extraction · Aliquot · Plate coating 같은 그날 실험). 배양 기록(logs)과 따로 `exps` [{id,date,name,lineIds,fields:[{k,v}],memo,printed}] → P · d 계산에 안 섞임. 계정 동기화(SYNC_ARR) · 백업 · 복원에 넣음. 입력: 다이어리 위 「+ 실험 기록」, 위클리 날짜마다 「+」(그 날짜로) → 창(`expOpen`): 날짜 · 실험 이름(자동완성) · 라인(선택, 여러 개) · 실험별 칸 · 메모(여러 줄). 이름을 고르면 칸을 깔아 줌(`EXP_TPL`: Aliquot = 시약 · 농도 · Lot · 양 × 개수 · 보관 등 8개, 목록에 없는 이름은 마지막으로 같은 이름으로 쓴 기록의 칸). 칸 값도 전에 쓴 값 자동완성(Lot 등). 「+ 칸 추가」, 칸 이름 고치기 가능. 보이는 곳: 먼슬리(보라 네모 점 + 굵은 이름), 위클리(굵은 이름 + 라인 · 앞 칸 2개, 누르면 고치기), 라인 타임라인 표(라인 고른 실험만, 날짜 · 이름 · 칸 값, P · d 없음), 연구노트 인쇄(목록 위 「실험 기록」 · 인쇄 맨 앞에 날짜순 표, 인쇄 뒤 「인쇄됨」 표시). 확인: Playwright로 위클리 + → RNA extraction 칸 깔림 → 라인 · 값 · 메모 저장 → 위클리 · 먼슬리 · 타임라인 · 인쇄 영역. 휴대폰 화면 · 실제 인쇄는 아직 안 봄.

- 2026-11-14(5): Plate map 범례 · 자동 제목에서 day 뺌, passage(P5)만(유진: 맵이라 day는 필요 없음). `figLn`에 `p` 더함. 일정 쪽 P · d는 그대로.

- 2026-11-14(4): 일정 항목 메모를 여러 줄로(엔터 = 줄바꿈, textarea 최대 6줄로 늘어남). 그림에서도 엔터 줄 그대로 · 줄마다 폭 맞춰 다시 줄바꿈(최대 8줄). 메모가 길면 줄 높이가 모자라 점선 테두리 · 다음 줄과 겹치던 것 고침(`T.bot`).

- 2026-11-14(3): 일정 줄 Day 0 기준(유진: 라인을 골랐으면 실제 seeding된 날이 Day 0). 라인 있는 줄은 Day 0 = 그 라인의 지금 d0(`line.startDate`, `figLineZero`). 기록을 고르고 빼도 Day 0이 안 바뀜(예전엔 고른 것 중 맨 앞 날짜라 누를 때마다 바뀌어 헷갈렸음). 예전 passage 실험이면 목록의 Seeding · Split · Reseeding 줄에 있는 「Day 0」 단추로 그날을 Day 0으로(`t.zero`), 「지금 d0으로」로 되돌림. 라인을 바꾸면 `t.zero` 지움. 라인 없는 줄은 예전처럼.

- 2026-11-14(2): Plate 편집을 실제 작업 순서로(유진: 라인부터 정해야지). ① Plate 규격 ② 라인(어느 well에 seeding) ③ 조건(처리) ④ 글자. well 고르기는 단계에서 빼고 위에 붙는 「고른 칸」 줄(`.fg-selbar`, 스크롤해도 보임). 「붓」(`_figBrush`, `figPick`): 고른 칸 없이 라인 · 조건을 누르면 들고 있다가 그림에서 끌거나 A / 1을 누르는 대로 바로 칠함, 같은 걸 다시 누르거나 「내려놓기」로 끝. 고른 칸이 있으면 예전처럼 바로 칠함. 라인은 한 번만: plate · 일정을 새로 넣을 때 Figure에 이미 들어간 라인을 먼저 가져옴(`figKnownLines`). 빈 일정 안내 글이 plate와 겹치던 것 고침. 확인: Playwright로 일정 라인 → plate 라인 따라옴, 붓으로 A1–B3 끌어 칠하기, 붓 들고 4열 누르기 = 열 조건.

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
