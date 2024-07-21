Set WshShell = CreateObject("WScript.Shell")

homeDir = WshShell.ExpandEnvironmentStrings("%USERPROFILE%")
keymapper = homeDir & "\scoop\shims\keymapper.exe"
keymapperd = homeDir & "\scoop\shims\keymapperd.exe"

WshShell.Run keymapperd, 0, True
WshShell.Run keymapper, 0, True

Set WshShell = Nothing
