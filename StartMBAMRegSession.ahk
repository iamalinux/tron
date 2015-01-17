; Run this script from the install directory.
coord=relative
Run %A_ScriptDir%\mbam.exe
sleep, 10000 ; Wait 10 seconds for program load
click 634, 486 ; scan now button
sleep, 10000 ; wait for update check
click 813, 541 ; update now button
sleep, 4000 ; wait for update check again
click 813, 541 ; update now button
sleep, 4000 ; wait for update check again
click 813, 541 ; update now button
sleep, 4000 ; wait for update check again
click 813, 541 ; update now button
sleep, 4000 ; wait for update check again
click 813, 541 ; update now button
; portable version of ahk can be downloaded from ahkscript.org/download/
; can be run from command line with:
; \path\AutoHotKey.exe "StartMBAMRegSession.ahk"
; Tested with 2.0.4.1028
