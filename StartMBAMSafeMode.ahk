; Run this script from the install directory.
coord=relative
Run %A_ScriptDir%\mbam.exe
sleep, 10000 ; Wait 10 seconds for program load
click 450, 510 ; scan now button
sleep, 30000 ; wait for update check
click 813, 561 ; update now button
sleep, 25000 ; wait for update check again for slower connections
click 813, 561 ; update now button again for slower connections
; portable version of ahk can be downloaded from ahkscript.org/download/
; can be run from command line with:
; \path\AutoHotKey.exe "StartMBAMSafeMode.ahk"
; Tested with 2.0.4.1028
