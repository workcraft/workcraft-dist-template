# Change to Workcraft home directory and put it into the WORKCRAFT_HOME variable
# (Set-Location does not support UNC paths (those started with \\); and therefore
# Push-Location is used instead as it creates a network drive in case of UNC path)
$WORKCRAFT_HOME=$PSScriptRoot
Push-Location $WORKCRAFT_HOME

# SET the JVM executable in JAVA_BIN variable (if not defined yet)
if (! (Get-Variable 'JAVA_BIN' -Scope Global -ErrorAction 'Ignore')) {
    if (! (Get-Variable 'JAVA_HOME' -Scope Global -ErrorAction 'Ignore')) {
        $JAVA_BIN="javaw.exe"
    } else {
        if (Test-Path $JAVA_HOME\bin\javaw.exe) {
            $JAVA_BIN="$JAVA_HOME\bin\javaw.exe"
        } else {
             $JAVA_BIN="$JAVA_HOME\javaw.exe"
        }
    }
}

# Add tools\GraphvizMinimal\ to the path so tools\Petrify\draw_astg can find dot.exe
$env:Path += ";$WORKCRAFT_HOME\tools\GraphvizMinimal\"

Start-Process $JAVA_BIN -ArgumentList "-classpath $WORKCRAFT_HOME\bin\*", 'org.workcraft.Console', "$args" -Wait

# Release the network drives created by Push-Location and restore the current directory
Pop-Location
