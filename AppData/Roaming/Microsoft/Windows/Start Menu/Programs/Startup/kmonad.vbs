Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "$HOME\\.config\\kmonad\\service.bat", 0, False
Set WshShell = Nothing
