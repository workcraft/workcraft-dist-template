:: Enable command line extensions
VERIFY OTHER 2>NUL
SETLOCAL ENABLEEXTENSIONS
IF ERRORLEVEL 1 (
    ECHO "Cannot enable command line extensions."
    EXIT /B 1
)

:: Change to Workcraft home directory and put it into the WORKCRAFT_HOME variable
:: (CD does not support UNC paths (those started with \\), and therefore
:: PUSHD is used instead as it creates a network drive in case of UNC path)
SET WORKCRAFT_HOME=%~dp0
PUSHD "%WORKCRAFT_HOME%"

:: SET the JVM executable in JAVA_BIN variable (if not defined yet)
IF NOT DEFINED JAVA_BIN (
    IF NOT DEFINED JAVA_HOME (
        SET JAVA_BIN=javaw.exe
    ) ELSE (
        IF EXIST "%JAVA_HOME%\bin\javaw.exe" (
            SET "JAVA_BIN=%JAVA_HOME%\bin\javaw.exe"
        ) ELSE (
            SET "JAVA_BIN=%JAVA_HOME%\javaw.exe"
        )
    )
)

:: Add tools\GraphvizMinimal\ to the path so tools\Petrify\draw_astg can find dot.exe
SET "PATH=%PATH%;%WORKCRAFT_HOME%\tools\GraphvizMinimal\"

SET "CLASSPATH=%WORKCRAFT_HOME%\bin\*"

start "Workcraft" "%JAVA_BIN%" org.workcraft.Console %*

timeout 1 /nobreak

:: Release the network drives created by PUSHD and restore the current directory
POPD

ENDLOCAL
