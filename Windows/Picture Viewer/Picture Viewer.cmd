@echo off
call :associate "bmp" "Bitmap"
call :associate "dib" "Bitmap"
call :associate "gif" "Gif"
call :associate "jfif" "JFIF"
call :associate "jpe" "Jpeg"
call :associate "jpeg" "Jpeg"
call :associate "jpg" "Jpeg"
call :associate "png" "Png"
call :associate "tiff" "Tiff"
call :associate "tif" "Tiff"
call :associate "wdp" "Wdp"
call :openwith "Bitmap" "-3056" "%%SystemRoot%%\System32\imageres.dll,-70"
call :openwith "JFIF" "-3055" "%%SystemRoot%%\System32\imageres.dll,-72"
call :openwith "Jpeg" "-3055" "%%SystemRoot%%\System32\imageres.dll,-72"
call :openwith "Png" "-3057" "%%SystemRoot%%\System32\imageres.dll,-71"
call :openwith "Tiff" "-3058" "%%SystemRoot%%\System32\imageres.dll,-122"
call :openwith "Wdp" "%%SystemRoot%%\System32\wmphoto.dll,-400"
goto :back
:associate
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".%~1" /t "REG_SZ" /d "PhotoViewer.FileAssoc.%~2" /f
exit /b
:openwith
reg add "HKCR\PhotoViewer.FileAssoc.%~1" /v "ImageOptionFlags" /t "REG_DWORD" /d "0x00000001" /f
reg add "HKCR\PhotoViewer.FileAssoc.%~1\DefaultIcon" /ve /t "REG_SZ" /d "%~3" /f
reg add "HKCR\PhotoViewer.FileAssoc.%~1\shell\open\command" /ve /t "REG_EXPAND_SZ" /d "%%SystemRoot%%\System32\rundll32.exe \"%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll\", ImageView_Fullscreen %%1" /f
reg add "HKCR\PhotoViewer.FileAssoc.%~1\shell\open\DropTarget" /v "Clsid" /t  "REG_SZ" /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
if %~1 neq Wdp reg add "HKCR\PhotoViewer.FileAssoc.%~1" /v "FriendlyTypeName" /t "REG_EXPAND_SZ" /d "@%%ProgramFiles%%\Windows Photo Viewer\PhotoViewer.dll,-3055" /f
call :%~1 2>nul
exit /b
:JFIF
reg add "HKCR\PhotoViewer.FileAssoc.%~1" /v "EditFlags" /t "REG_DWORD" /d "0x00010000" /f
reg add "HKCR\PhotoViewer.FileAssoc.%~1\shell\open" /v "MuiVerb" /t "REG_EXPAND_SZ" /d "%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f
exit /b
:Jpeg
reg add "HKCR\PhotoViewer.FileAssoc.%~1" /v "EditFlags" /t "REG_DWORD" /d "0x00010000" /f
reg add "HKCR\PhotoViewer.FileAssoc.%~1\shell\open" /v "MuiVerb" /t "REG_EXPAND_SZ" /d "%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f
exit /b
:Tiff
reg add "HKCR\PhotoViewer.FileAssoc.%~1\shell\open" /v "MuiVerb" /t "REG_EXPAND_SZ" /d "%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f
exit /b
:Wdp
reg add "HKCR\PhotoViewer.FileAssoc.%~1" /v "EditFlags" /t "REG_DWORD" /d "0x00010000" /f
reg add "HKCR\PhotoViewer.FileAssoc.%~1\shell\open" /v "MuiVerb" /t "REG_EXPAND_SZ" /d "%%ProgramFiles%%\Windows Photo Viewer\photoviewer.dll,-3043" /f
exit /b
:back
timeout /t 5
