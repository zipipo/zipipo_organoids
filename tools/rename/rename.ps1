# 파일 이름 통일 (Cell Culture Log 현미경 사진용)
#   이름통일.bat 을 더블클릭하거나, 사진 폴더를 이름통일.bat 위로 끌어다 놓으면 실행돼요.
#   rules.txt 의 규칙대로 바뀔 이름을 먼저 보여 주고, Y 를 입력해야 실제로 바꿔요.
#   바꾼 기록은 log_날짜시간.csv 로 남고, 그 csv 를 이름통일.bat 위로 끌어다 놓으면 되돌려요.
param([string]$Target)
$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [Text.Encoding]::UTF8
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$exts = '.png','.jpg','.jpeg','.tif','.tiff','.bmp'

# 대소문자만 다른 이름(Windows는 같은 이름으로 봄)도 바뀌게: 임시 이름을 거쳐서 바꿈
function Move-Name($folder, $from, $to) {
  $src = Join-Path $folder $from
  if ($from -ieq $to) {
    $tmp = '__rename_tmp__' + [guid]::NewGuid().ToString('N') + [IO.Path]::GetExtension($from)
    Rename-Item -LiteralPath $src -NewName $tmp
    Rename-Item -LiteralPath (Join-Path $folder $tmp) -NewName $to
  } else { Rename-Item -LiteralPath $src -NewName $to }
}

# ── 되돌리기: log csv 를 받은 경우 ──
if ($Target -and $Target.ToLower().EndsWith('.csv')) {
  $rows = @(Import-Csv -LiteralPath $Target -Encoding UTF8)
  Write-Host ""
  Write-Host "되돌릴 파일 $($rows.Count)개 ($Target)"
  $ans = Read-Host "Y 를 입력하면 원래 이름으로 되돌려요 (그 밖 = 취소)"
  if ($ans -ne 'Y' -and $ans -ne 'y') { Write-Host '취소했어요.'; return }
  [array]::Reverse($rows)
  $ok = 0
  foreach ($r in $rows) {
    $cur = Join-Path $r.Folder $r.New; $old = Join-Path $r.Folder $r.Old
    if (-not (Test-Path -LiteralPath $cur)) { Write-Host "  [건너뜀] 없음: $($r.New)" -ForegroundColor Yellow; continue }
    if ((Test-Path -LiteralPath $old) -and -not ($r.Old -ieq $r.New)) { Write-Host "  [건너뜀] 원래 이름이 이미 있음: $($r.Old)" -ForegroundColor Yellow; continue }
    Move-Name $r.Folder $r.New $r.Old; $ok++
  }
  Write-Host "되돌림 $ok 개 완료."
  return
}

# ── 폴더 정하기 ──
$folder = $Target
if (-not $folder) {
  $folder = Read-Host "사진 폴더 경로를 붙여넣고 엔터 (그냥 엔터 = D:\DCIM\Pictures)"
  if (-not $folder) { $folder = 'D:\DCIM\Pictures' }
}
$folder = $folder.Trim('"').Trim()
if (-not (Test-Path -LiteralPath $folder -PathType Container)) { Write-Host "폴더가 없어요: $folder" -ForegroundColor Red; return }

# ── 규칙 읽기: 바꿀말 => 새말 ──
$rulesPath = Join-Path $here 'rules.txt'
if (-not (Test-Path -LiteralPath $rulesPath)) { Write-Host "rules.txt 가 이 파일 옆에 있어야 해요." -ForegroundColor Red; return }
$rules = @()
foreach ($line in Get-Content -LiteralPath $rulesPath -Encoding UTF8) {
  $t = $line.Trim()
  if (-not $t -or $t.StartsWith('#')) { continue }
  $i = $t.IndexOf('=>')
  if ($i -lt 1) { Write-Host "  [규칙 무시] => 가 없음: $t" -ForegroundColor Yellow; continue }
  $rules += ,@($t.Substring(0, $i).Trim(), $t.Substring($i + 2).Trim())
}
if (-not $rules.Count) { Write-Host "rules.txt 에 규칙이 없어요." -ForegroundColor Red; return }
Write-Host ""
Write-Host "폴더: $folder"
Write-Host "규칙 $($rules.Count)개"
foreach ($r in $rules) { Write-Host "  $($r[0])  =>  $($r[1])" }

# ── 바뀔 이름 계산 (대소문자 구분, 위 규칙부터 차례로) ──
$files = @(Get-ChildItem -LiteralPath $folder -File | Where-Object { $exts -contains $_.Extension.ToLower() })
$plan = @(); $taken = @{}
foreach ($f in $files) { $taken[$f.Name.ToLower()] = $true }
foreach ($f in $files) {
  $new = $f.Name
  foreach ($r in $rules) { $new = $new.Replace($r[0], $r[1]) }
  if ($new -ceq $f.Name) { continue }
  $bad = ($new.IndexOfAny([IO.Path]::GetInvalidFileNameChars()) -ge 0)
  $clash = (-not ($new -ieq $f.Name)) -and $taken.ContainsKey($new.ToLower())
  $plan += [pscustomobject]@{ Old = $f.Name; New = $new; Skip = ($bad -or $clash); Why = $(if ($bad) { '못 쓰는 글자' } elseif ($clash) { '같은 이름이 이미 있음' } else { '' }) }
  if (-not $bad -and -not $clash) { $taken[$new.ToLower()] = $true }
}
Write-Host ""
if (-not $plan.Count) { Write-Host "바뀔 파일이 없어요. (사진 $($files.Count)장 확인)"; return }
foreach ($p in $plan) {
  if ($p.Skip) { Write-Host "  [건너뜀: $($p.Why)] $($p.Old)" -ForegroundColor Yellow }
  else { Write-Host "  $($p.Old)"; Write-Host "    -> $($p.New)" -ForegroundColor Green }
}
$go = @($plan | Where-Object { -not $_.Skip })
Write-Host ""
Write-Host "바꿀 파일 $($go.Count)개 / 건너뜀 $(($plan.Count) - $go.Count)개 (전체 사진 $($files.Count)장)"
if (-not $go.Count) { return }
$ans = Read-Host "Y 를 입력하면 실제로 바꿔요 (그 밖 = 취소)"
if ($ans -ne 'Y' -and $ans -ne 'y') { Write-Host '취소했어요. 아무것도 안 바꿨어요.'; return }

# ── 바꾸고 기록 남기기 ──
$log = Join-Path $here ('log_' + (Get-Date -Format 'yyyyMMdd_HHmmss') + '.csv')
$done = @()
foreach ($p in $go) {
  try { Move-Name $folder $p.Old $p.New; $done += [pscustomobject]@{ Folder = $folder; Old = $p.Old; New = $p.New } }
  catch { Write-Host "  [실패] $($p.Old): $($_.Exception.Message)" -ForegroundColor Red }
}
if ($done.Count) { $done | Export-Csv -LiteralPath $log -Encoding UTF8 -NoTypeInformation }
Write-Host ""
Write-Host "바꿈 $($done.Count)개 완료."
if ($done.Count) { Write-Host "되돌리려면 이 파일을 이름통일.bat 위로 끌어다 놓으세요: $log" }
