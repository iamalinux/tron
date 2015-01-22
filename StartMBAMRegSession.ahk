; Run this script from the install directory.
coord=relative
Run %A_ScriptDir%\mbam.exe
MouseMove, 1, 1 ; Exit screensaver
sleep, 10000 ; Wait 10 seconds for program load
click 634, 486 ; scan now button
sleep, 20000 ; wait for update check
click 813, 531 ; update now button
; portable version of ahk can be downloaded from ahkscript.org/download/
; can be run from command line with:
; \path\AutoHotKey.exe "StartMBAMRegSession.ahk"
; Tested with 2.0.4.1028
