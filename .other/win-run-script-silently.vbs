Set WshShell = CreateObject("WScript.Shell")
homeDir = WshShell.ExpandEnvironmentStrings("%USERPROFILE%")
batchScript = homeDir & "\.config\kmonad\service.bat"
WshShell.Run batchScript, 0, False
Set WshShell = Nothing
