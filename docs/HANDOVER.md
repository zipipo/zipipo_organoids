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
| 1 | 인큐베이터 (옆면 박스) | ✅ 끝 | 오늘 작업 탭 통계 아래 `renderIncubator()`, `plateKind()`가 plate 글자를 well/dish/flask로 묶음, well plate는 well ÷ 칸 수 올림으로 장 수 |
| 2 | 이번 주 실험 정리 (분석 탭 맨 위) | ✅ 끝 | `buildThisWeek()`, 요일별 액션 블럭 + 지난주 대비 + 남은 예정. 작업량 추이 · 요일별을 그 아래로 올림 |
| 3 | 다이어리 (먼슬리 · 위클리) | ⬜ 안 함 | |
| 4b | LN2 탭: 조건 검색 · 사람별 · Pair · 위치 | ⬜ 안 함 | |
| 5 | Stock vial 드래그 → 엑셀 ver+1 다운로드 | ⬜ 안 함 | 제일 어려움, 4b 다음 |
| 6 | 홈 화면 펫 (다마고치) | ⬜ 안 함 | |

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

- 2026-11-06: 요구사항 정리, 방법 조사, LN2 Explorer ver 462 확인, 이 문서 작성. 코드 변경 없음.
