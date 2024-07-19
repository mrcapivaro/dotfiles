Set WshShell = CreateObject("WScript.Shell")
homeDir = WshShell.ExpandEnvironmentStrings("%USERPROFILE%")
keymapper = homeDir & ".\scoop\shims\CM_FP_keymapper.exe"
keymapperd = homeDir & ".\scoop\shims\CM_FP_keymapperd.exe"
WshShell.Run keymapperd, 0, False
WshShell.Run keymapper, 0, False
Set WshShell = Nothing
