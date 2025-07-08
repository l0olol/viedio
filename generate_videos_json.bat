@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0videos"
del ..\videos.json >nul 2>&1
echo [ > ..\videos.json
set first=1
for %%f in (*.mp4 *.webm *.ogg) do (
    if exist "%%f" (
        if !first! equ 0 echo , >> ..\videos.json
        set first=0
        echo   { "filename": "%%f", "name": "%%~nf", "categories": [] } >> ..\videos.json
    )
)
echo ] >> ..\videos.json
cd ..
endlocal 