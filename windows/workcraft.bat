@ECHO OFF

:: Enable command line extensions
VERIFY OTHER 2>NUL
SETLOCAL ENABLEEXTENSIONS
IF ERRORLEVEL 1 (
    ECHO Cannot enable command line extensions.
    PAUSE
    EXIT /B 1
)

:: Change to Workcraft home directory and put it into the WORKCRAFT_HOME variable
:: Note that CD does not support UNC paths (those started with \\). Therefore
:: PUSHD should be used instead as it creates a network drive in case of UNC path.
SET "WORKCRAFT_HOME=%~dp0"
PUSHD "%WORKCRAFT_HOME%"

:: SET the JVM executable in JAVA_BIN variable (if not defined yet)
IF NOT DEFINED JAVA_BIN (
    IF NOT DEFINED JAVA_HOME (
        SET "JAVA_BIN=javaw.exe"
    ) ELSE (
        IF EXIST "%JAVA_HOME%\bin\javaw.exe" (
            SET "JAVA_BIN=%JAVA_HOME%\bin\javaw.exe"
        ) ELSE (
            SET "JAVA_BIN=%JAVA_HOME%\javaw.exe"
        )
    )
)

:: Check presence of Java binary
WHERE /Q "%JAVA_BIN%"
IF ERRORLEVEL 1 (
    ECHO Cannot find Java binary %JAVA_BIN%.
    PAUSE
    EXIT /B 1
)

:: Check correctness of Java version
FOR /F tokens^=2-3^ delims^=.-_^" %%j IN ('%JAVA_BIN% -fullversion 2^>^&1') DO SET "JAVA_VERSION=%%j.%%k"
IF NOT "%JAVA_VERSION%" == "1.8" (
    ECHO Java 1.8 is required, but version %JAVA_VERSION% is found.
    PAUSE
    EXIT /B 1
)

:: Add tools\GraphvizMinimal\ to the path so tools\Petrify\draw_astg can find dot.exe
SET "PATH=%PATH%;%WORKCRAFT_HOME%\tools\GraphvizMinimal\"

SET "CLASSPATH=%WORKCRAFT_HOME%\bin\*"

START "Workcraft" "%JAVA_BIN%" org.workcraft.Console %*

TIMEOUT 1 /NOBREAK

:: Rreleases the network drives created by PUSHD restores the current directory
POPD

ENDLOCAL
