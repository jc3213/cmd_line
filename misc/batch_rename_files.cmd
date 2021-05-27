@ECHO OFF
IF "%~N1"=="" EXIT
SETLOCAL EnableDelayedExpansion
PUSHD %~DPN1
SET Seek=1
:SeekFiles
IF "%Index%"=="" SET Index=1-9
FOR /F "TOKENS=*" %%A IN (
    'DIR /B /A-D'
) DO (
    FOR /F "TOKENS=%Index% DELIMS=-_.()" %%B IN (
        "%%A"
    ) DO (
        IF %Seek% EQU 1 (
            ECHO %%A
            CALL :ListIndex %%B %%C %%D %%E %%F %%G %%H %%I %%J && GOTO :EOF
        ) ELSE IF %Seek% GTR 1 (
            CALL :Filename "%%A" "%%B"
        )
    )
)
PAUSE
EXIT
:ListIndex
IF "%1"=="" GOTO :SeekIndex
ECHO %1| FINDSTR /R /C:"^[0-9][0-9]*$" > NUL && SET Symbol=** || SET Symbol=
ECHO %Seek%  ^>^>        %1    %Symbol%
SET /A Seek=%Seek%+1
CALL :ListIndex %2 %3 %4 %5 %6 %7 %8
:SeekIndex
SET /P Index=Which one?     
GOTO :SeekFiles
:Filename
SET String=#%~2
SET Length=0
FOR %%K IN (
    4096 2048 1024 512 256 128 64 32 16 8 4 2 1
) DO (
    IF "!String:~%%K,1!" NEQ "" (
        SET /A Length+=%%K
        SET String=!String:~%%K!
    )
)
IF %Length% EQU 1 (
    SET Prefix=000%~2
) ELSE IF %Length% EQU 2 (
    SET Prefix=00%~2
) ELSE IF %Length% EQU 3 (
    SET Prefix=0%~2
) ELSE (
    SET Prefix=%2
)
ECHO %~1        %~2        %Prefix%%~X1
REN %1 %Prefix%%~X1
EXIT /B