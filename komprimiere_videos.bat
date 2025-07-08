@echo off
REM Komprimiert alle MP4s im videos-Ordner mit ffmpeg (muss installiert sein)
cd /d %~dp0
cd videos
where ffmpeg >nul 2>nul
if errorlevel 1 (
  echo ffmpeg ist nicht installiert oder nicht im PATH!
  pause
  exit /b
)
for %%f in (*.mp4) do (
  if not exist "%%~nf_compressed.mp4" (
    echo Komprimiere %%f ...
    ffmpeg -i "%%f" -vcodec libx264 -crf 28 -preset fast -acodec aac -b:a 128k "%%~nf_compressed.mp4"
  ) else (
    echo Ueberspringe %%f (bereits komprimiert)
  )
)
echo Fertig! Komprimierte Videos liegen im videos-Ordner.
pause 