Set Shell = CreateObject("WScript.Shell")

homeDir = Shell.ExpandEnvironmentStrings("%USERPROFILE%")
keymapper = homeDir & "\scoop\shims\keymapper.exe"
keymapperd = homeDir & "\scoop\shims\keymapperd.exe"

Shell.Run keymapperd, 0, True
Shell.Run keymapper, 0, True

Set Shell = Nothing
