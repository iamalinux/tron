; Run this before MBAM so that MBAM is the active window.
coord=relative
Run %A_ScriptDir%\mbam.exe
sleep, 2000 ; Wait 2 seconds for program load
click 450, 510 ; scan now button
sleep, 7000 ; wait for update check
click 813, 541 ; update now button
; portable version of ahk can be downloaded from ahkscript.org/download/
; can be run from command line with:
; \path\AutoHotKey.exe "StartMBAMSafeMode.ahk"
; Tested with 2.0.4.1028
