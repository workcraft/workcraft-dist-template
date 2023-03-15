@ECHO ON

:: Enable command line extensions
VERIFY OTHER 2>NUL
SETLOCAL ENABLEEXTENSIONS
IF ERRORLEVEL 1 (
    ECHO Cannot enable command line extensions.
    PAUSE
    EXIT /B 1
)

:: Remember the current working directory
SET "CURRENT_DIR=%cd%"

:: Change to Workcraft home directory and put it into the WORKCRAFT_HOME variable
:: Note that CD does not support UNC paths (those started with \\). Therefore
:: PUSHD should be used instead as it creates a network drive in case of UNC path.
SET "WORKCRAFT_HOME=%~dp0"
PUSHD "%WORKCRAFT_HOME%"

:: Use bundled JRE as the first priority (if present and not overridden)
IF NOT DEFINED WORKCRAFT_USE_NATIVE_JAVA (
    IF EXIST "%WORKCRAFT_HOME%\jre\bin\javaw.exe" (
        SET "JAVA_BIN=%WORKCRAFT_HOME%\jre\bin\javaw.exe"
    )
)

:: Set the JVM executable in JAVA_BIN variable (if not defined yet)
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

:: Add tools\GraphvizMinimal\ to the path so tools\PetrifyTools\petrify.exe can find dot.exe
SET "PATH=%PATH%;%WORKCRAFT_HOME%\tools\GraphvizMinimal\"

SET "CLASSPATH=%WORKCRAFT_HOME%\bin\*"

START "Workcraft" "%JAVA_BIN%" org.workcraft.Console -dir:"%CURRENT_DIR%" %*

TIMEOUT 1 /NOBREAK

:: Releases the network drives created by PUSHD restores the current directory
POPD

ENDLOCAL
