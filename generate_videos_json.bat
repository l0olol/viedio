@echo off
REM Fügt alle neuen MP4s im videos-Ordner zu videos.json hinzu, ohne Duplikate, und behält Kategorien vorhandener Videos
cd /d %~dp0
cd videos
setlocal enabledelayedexpansion
if exist ..\videos.json (
  copy ..\videos.json old_videos.json >nul
) else (
  echo []> old_videos.json
)
set "json=["
for %%f in (*.mp4) do (
  set found=0
  for /f "usebackq tokens=*" %%l in (old_videos.json) do (
    echo %%l | findstr /C:"\"filename\": \"%%f\"" >nul && set found=1
  )
  if !found! equ 0 (
    set "json=!json!{\"filename\": \"%%f\", \"categories\": [] },"
  )
)
for /f "usebackq tokens=*" %%l in (old_videos.json) do (
  echo %%l | findstr /C:'{"filename":' >nul && (
    set "json=!json!%%l,"
  )
)
set "json=!json:~0,-1!]"
(echo !json!) > ..\videos.json
del old_videos.json
endlocal
echo Fertig! videos.json wurde aktualisiert (neue Videos hinzugefügt, Kategorien erhalten).
pause 