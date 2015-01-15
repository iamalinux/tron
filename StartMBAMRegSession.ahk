; Run this before MBAM so that MBAM is the active window.
coord=relative
sleep, 20000 ; Wait 20 seconds for install to complete
click 634, 486 ; scan now button
sleep, 7000 ; wait for update check
click 813, 541 ; update now button
; portable version of ahk can be downloaded from ahkscript.org/download/
; can be run from command line with:
; \path\AutoHotKey.exe "StartMBAMRegSession.ahk"
; Tested with 2.0.4.1028
