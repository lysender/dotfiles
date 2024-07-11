# cmder startup tabs

```
cmd /k "%ConEmuDir%\..\init.bat" -new_console:d:D:\Files\workspaces -new_console:t:"ping"

cmd /k "%ConEmuDir%\..\init.bat" -new_console:d:D:\Files\workspaces\project-1 -new_console:t:"project-1"

cmd /k "%ConEmuDir%\..\init.bat" -new_console:d:D:\Files\workspaces\project-2 -new_console:t:"project-2"

cmd /k "%ConEmuDir%\..\init.bat" -new_console:d:D:\Files\workspaces\project-3 -new_console:t:"project-3"

cmd /k "%ConEmuDir%\..\init.bat" -new_console:d:D:\Files\workspaces -new_console:t:"misc"
```

Change the command startup to pass the parameter:

```
ConEmu64.exe -run {MyTabs}
```

