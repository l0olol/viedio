@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0images"
del ..\images.json >nul 2>&1
echo [ > ..\images.json
set first=1
for /d %%d in (*) do (
    if exist "%%d\*" (
        if !first! equ 0 echo , >> ..\images.json
        set first=0
        echo   { "title": "%%d", "images": [ >> ..\images.json
        set imgfirst=1
        for %%f in ("%%d\*.jpg" "%%d\*.jpeg" "%%d\*.png" "%%d\*.gif" "%%d\*.webp" "%%d\*.bmp" "%%d\*.svg" "%%d\*.pdf") do (
            if exist "%%f" (
                if !imgfirst! equ 0 echo , >> ..\images.json
                set imgfirst=0
                echo     "%%~nxf" >> ..\images.json
            )
        )
        echo   ] } >> ..\images.json
    )
)
echo ] >> ..\images.json
cd ..
endlocal 