@echo off
SC stop "SysMain"
sc config "SysMain" start=disabled
del /f /s /q %SystemRoot%\Prefetch\*.*
timeout /t 5
