Fork Description: Start mbam, scan, and update through AHK click actions.


Status: Debugging


Please read this and the bat script from lines 1040-1076 to understand what needs to be done before testing these files.


The ahk scripts are in Linux/Mac format and must be converted to Windows format before use.  This can be done with Notepad++, edit, EOL Conversion, Windows, file, save.  The ahk files must be in the correct directory to work.  The 32bit AutoHotKey must be downloaded from http://ahkscript.org/download/ahk-u32.zip and unzipped with the scripts as well.  See step 2 below for a visual description of what needs to be done.

Setup

1. Unzip tron.

2. Place scripts in the mbam directory

        \tron

            \resources

                \stage_3_disinfect

                    \mbam

                        AutoHotKey.exe

                        Malwarebytesinstaller

                        StartMBAMRegSession.ahk

                        StartMBAMSafeMode.ahk

3. Modify bat file accordingly.

4. Test


I could use help testing this.  It works flawlessly on these system in these states:

Windows XP Safe Mode

Windows 7 Safe Mode

Windows 8 Safe Mode

Windows 8 Regular Session


END FORK NOTES

| NAME       | Tron, an automated PC cleanup script                                                        |
| :--------- | :------------------------------------------------------------------------------------------ |
| AUTHOR     | vocatus on reddit.com/r/sysadmin (`vocatus d0t gate@gmail.com`) // PGP key ID: `0x82A211A2` |
| BACKGROUND | Why the name Tron? Tron "Fights for the User"                                               |

I got tired of running these utilities manually and decided to just automate everything, so Tron basically automates a variety of tasks to clean up/disinfect a Windows machine.

# CONTENTS

1. Usage Summary

2. Command-Line Use

3. Notes on Safe Mode

4. Sending a Post-Run Email Report

5. Changing Defaults

6. Pack Integrity

7. License

8. Contact Info

9. Full details of ALL steps

# USE

1. Boot into Safe Mode with Network Support (Safe Mode is NOT required but is strongly recommended)

2. Copy `tron.bat` and the `\resources` folder to the target machine and run `tron.bat` as an **ADMINISTRATOR** (Tron will refuse to run if you don't run as an Administrator)

3. Wait anywhere from **3-10 hours** (yes, it takes that long)

4. Reboot

By default the log file is at `C:\Logs\tron.log`

Tron will briefly check for a newer version when it starts up and notify you if one is found. Depending how badly the system is infected, it could take anywhere from 3 to 10 hours to run. I've personally observed times between 4-8 hours, and one user reported a run time of 30 hours. Basically set it and forget it.

# COMMAND-LINE USE

Command-line use is fully supported. All flags are optional and can be combined. *

    tron.bat [-a -c -d -e -er -m -o -p -r -sa -sb -sd -sp -v -x] | [-h]

    -a  Automatic mode (no welcome screen or prompts; implies -e)

    -c  Config dump (display current config. Can be used with other
        flags to see what WOULD happen, but script will never execute
        if this flag is used)

    -d  Dry run (run through script without executing any jobs)
    
    -e  Accept EULA (suppress display of disclaimer warning screen)
    
    -er Email a report when finished. Requires you to configure SwithMailSettings.xml

    -h  Display help text
    
    -m  Preserve default Metro apps (don't remove them)

    -o  Power off after running (overrides -r if used together)

    -p  Preserve power settings (don't reset power settings to default)
    
    -r  Reboot automatically (auto-reboot 30 seconds after completion)

    -sa Skip anti-virus scans (Sophos, Vipre, MBAM)
    
    -sb Skip de-bloat (OEM bloatware removal)

    -sd Skip defrag (force Tron to ALWAYS skip Stage 5 defrag)

    -sp Skip patches (do not patch 7-Zip, Java Runtime, Adobe Flash or Reader)

    -v  Verbose. Show as much output as possible. NOTE: Significantly slower!
    
    -x  Self-destruct. Tron deletes itself after running and leaves logs intact
   
\* There is no UPM flag


# SAFE MODE

Microsoft, in their long-standing tradition of breaking useful, heavily-used functionality for no reason, changed how you get into Safe Mode for Windows 8, disabling the traditional F8 method. Tron re-enables the F8 method as part of it's prep tasks (before actually running), but here's how to manually re-enable the old-style boot menu that supports the F8 key. From an admin command prompt, run this command:

    bcdedit /set {default} bootmenupolicy legacy

Reboot and you should now be able to use F8 to select Safe Mode. Note that this command is the same one Tron runs, so if you launch Tron to the menu and then exit, you'll accomplish the same thing.


# EMAIL REPORT
To have Tron send an email report at completion, edit this file:

    \resources\stage_6_wrap-up\email_report\SwithMailSettings.xml
    
Specify your SMTP server, username, and password. After specifying your settings you can use the -er flag to have Tron send the email report.

Keep in mind the username and password for the email account will be stored in PLAIN TEXT so don't leave it lying around on a system you don't trust.


# CHANGE DEFAULTS (advanced)

If you don't want to use the command-line and don't like Tron's defaults, you can change the following default variables. Keep in mind command-line flags will always override their respective default option.

- To change log location, edit these lines:

  ```
  set LOGPATH=%SystemDrive%\Logs
  set LOGFILE=tron.log
  ```
  
- To change where Tron stores quarantined files, change this path (note: this is currently unused by Tron, so setting it has no effect):
  ```
  set QUARANTINE_PATH=C:\path\to\your\desired\folder
  ```

- To always run automatically (no welcome screen, implies acceptance of EULA), change this to `yes`:

  ```
  set AUTORUN=no
  ```

- To always do a dry run (don't actually execute jobs), change this to `yes`:

  ```
  set DRY_RUN=no
  ```
  
- To permanently accept the End User License Agreement (suppress display of disclaimer warning screen), change this to `yes`:
  ```
  set EULA_ACCEPTED=no
  ```

- To preserve default Metro apps (don't remove them), change this to `yes`:
  
  ```
  set PRESERVE_METRO_APPS=no
  ```

- To shut down the computer when Tron is finished, change this to `yes`:

  ```
  set AUTO_SHUTDOWN=no
  ```

- To preserve the power scheme (instead of resetting to Windows defaults), change this to `yes`:
  
  ```
  set PRESERVE_POWER_SCHEME=no
  ```

- To configure post-run reboot, change this value (in seconds). `0` disables auto-reboot:

  ```
  set AUTO_REBOOT_DELAY=0
  ```
  
- To skip anti-virus scan engines (Sophos, Vipre, MBAM), change this to `yes`:

  ```
  set SKIP_ANTIVIRUS_SCANS=no
  ```

- To skip OEM debloat, change this to `yes`:
  
  ```     
  set SKIP_DEBLOAT=no
  ```
  
- To **ALWAYS** skip defrag, regardless whether `C:\` is an SSD or not, change this line to read `yes`:

  ```
  set SKIP_DEFRAG=no
  ```

- To skip patches (don't patch 7-Zip, Java, Adobe Flash and Reader) change this to `yes`:

  ```
  set SKIP_PATCHES=no
  ```

- To display as much output as possible (verbose), change this to `yes`:

  ```
  set VERBOSE=no
  ```

- To have Tron delete itself after running (self-destruct), change this to `yes`:

  ```
  set SELF_DESTRUCT=no
  ```

* There is no -UPM flag


# INTEGRITY

In every release `checksums.txt` is signed with my PGP key (`0x82A211A2`, included). You can use it to verify package integrity.


# LICENSE

Tron and any associated bootstrapper scripts and `.reg` files that I've written are free to use/redistribute/whatever under the **MIT license**. It'd be nice if you sent an email and let me know if you do something cool with it, but it's not required. All 3rd-party tools Tron calls (MBAM, TDSSK, etc) are bound by their respective licenses.


# OTHER

I try to keep everything updated. If you notice some of the packages are out of date, PM me on reddit or send me an email (listed above), I respond pretty quickly most days.

Hope this is helpful to other PC techs,

– Vocatus

If you feel overly charitable:
```
1JWMVs5hQ5SnHxMu5QbRffQWkMy8k4SmLV
```


# FULL TRON DESCRIPTION
The best way to see what Tron does is simply to crack `Tron.bat` open with a text editor (preferably one with syntax highlighting) or here on Github and just read the code. Every section has comments explaining exactly what it does, and you don't need to be able to read code to understand it. However, barring that, here's a general description of every action Tron performs.

## tron.bat
Master script that launches all the other tools. It performs a lot of actions on its own, but for any task we can't perform directly, we call an external utility or script


## Tron prep jobs

1. **Detect SSD**: Detect solid state hard drives. If found, tron skips the **Stage 5 defrag**

2. **Detect Safe Mode**: Detect whether or not we're in Safe Mode and notify the user if we're not

3. **Enable F8 Safe Mode selection**: Re-enable the ability to use the `F8` key on bootup (Windows 8/8.1 only; enabled by default on Server 2012/2012 R2)

4. **Make log and quarantine dirs**: Create the `LOGPATH` and `QUARANTINE_PATH` directories if they don't already exist

5. **Check for update**: Use `wget` to pull down `md5sums.txt` from the Tron mirror and see if we're on the current version. Tron will ask to automatically download the newest version, and then self-destruct the current copy. Downloads to the current users desktop


## STAGE 0: Prep

1. **Rkill**: Rkill is an anti-malware prep tool; it looks for and kills a number of known malware that interfere with removal tools

2. **ProcessKiller**: Utility provided by /u/cuddlychops06 which kills various userland processes. We use this to further kill anything that might interfere with Tron. Specifically, it kills everything in userland with the exception of the following processes: `ClassicShellService.exe`, `explorer.exe`, `dwm.exe`, `cmd.exe`, `mbam.exe`, `teamviewer.exe`, `TeamViewer_Service.exe`, `Taskmgr.exe`, `Teamviewer_Desktop.exe`, `MsMpEng.exe`, `tv_w32.exe`, `VTTimer.exe`, `Tron.bat`, `rkill.exe`, `rkill64.exe`, `rkill.com`, `rkill64.com`, `conhost.exe`, `dashost.exe`, `wget.exe`

3. **TDSS Killer**: Anti-rootkit utility from Kaspersky Labs. Tron calls TDSSKiller with the following flags:

  ```
  -l %TEMP%\tdsskiller.log -silent -tdlfs -dcexact -accepteula -accepteulaksn
  ```

4. **erunt**: Used to backup the registry before beginning a Tron run

5. **VSS purge**: Purges oldest set of Volume Shadow Service files (basically snapshot-in-time copies of files). Malware can often hide out here

6. **Disable sleep mode**: Tron disables sleep mode when the script starts to prevent going to sleep. At the end of the script it resets power settings to Windows defaults, unless you run with the -p flag

7. **Check and repair WMI**: Check the WMI interface and attempt repair if broken. Tron uses WMI for a lot of stuff including ISO date format conversion, OEM bloatware removal, and various other things, so having it functioning is critical


## STAGE 1: Tempclean

1. **Internet Explorer cleanup**: Runs built-in Windows tool to clean and reset Internet Explorer:

  ```
  rundll32.exe inetcpl.cpl,ClearMyTracksByProcess 4351
  ```

2. **CCLeaner**: CCLeaner utility by Piriform. Used to clean temp files before running AV scanners

3. **BleachBit**: BleachBit utility. Used to clean temp files before running AV scanners

4. **TempFileClean**: Script I wrote to clean some areas that other tools seem to miss

5. **DriveCleanup.exe**: Cleans unused/not present USB device drivers. Utility from Uwe Sieber ( www.uwe-sieber.de )

6. **Clear Windows event logs**: Backs up Windows event logs by default to the LOGPATH directory, then clears all log files

7. **Clear Windows Update cache**: Purges uninstaller files for already-installed Windows Updates. Typically frees up quite a bit of space


## STAGE 2: De-bloat

1. **OEM de-bloat** (by name): Use WMI to attempt to uninstall any program listed in this file:

  ```
  \resources\stage_2_de-bloat\oem\programs_to_target.txt
  ```

2. **OEM de-bloat** (by GUID): Use WMI to attempt to remove specific list of GUIDs in this file:

  ```
  \resources\stage_2_de-bloat\oem\programs_to_target_by_GUID.bat
  ```

3. **Metro de-bloat**: Remove the built-in Metro apps that no one uses (programs like Calculator, Paint etc are NOT removed). Purges them from the cache (can always fetch from Windows Update later)


## STAGE 3: Disinfect

1. **RogueKiller**: anti-rootkit utility and anti-malware prep tool. Similar to rkill

2. **Sophos Virus Removal Tool**: Command-line anti-virus scanner. Using Tron's `-v` flag gives more verbose output. Using Tron's `-sa` flag skips this component

3. **Vipre Rescue Scanner**: Command-line anti-virus scanner. Using Tron's `-v` flag gives more verbose output. Using Tron's `-sa` flag skips this component

4. **Malwarebytes Anti-Malware**: Anti-malware scanner. Because there is no command-line support for MBAM, we simply install it and continue with the rest of the script. This way a tech can click **Scan** whenever they're around, but the script doesn't stall while waiting for user input. Using Tron's `-sa` flag skips this component

5. **DISM image check & repair**: Microsoft utility for checking the Windows Image Store (sort of a more powerful System File Checker). Windows 8 and up only

6. **System File Checker**: Microsoft utility for checking the filesystem for errors and attempting to repair if found. Only run on Windows Vista and up (XP and below require a reboot)


## STAGE 4: Patch
Tron installs or updates these programs:

1. **7-zip**: Open-source compression and extraction tool. Far superior to just about everything (including the venerable WinRAR). Using Tron's `-sp` flag skips this component

2. **Adobe Flash Player**: Used by YouTube and various other sites. Using Tron's `-sp` flag skips this component

3. **Adobe Reader**: Standard PDF reader. Using Tron's `-sp` flag skips this component

4. **Java Runtime Environment**: I hate Java, but it is still widely used so we at least get the system on the latest version. Using Tron's `-sp` flag skips this component

5. **Windows updates**: Self-explanatory

6. **DISM base reset**: Recompiles the "Windows Image Store" after we finished purging old files from it earlier. Windows 8 and up only


## STAGE 5: Optimize

1. **chkdsk**: Checks disk for errors and schedules a chkdsk with repair at next reboot

2. **Defraggler**: Command-line defrag tool from Piriform


## STAGE 6: Wrap-up

1. **email_report**: Sends an email report with log file when Tron finishes. Requires you to specify your SMTP settings in `\resources\stage_6_wrap-up\email_report\SwithMailSettings.xml`


## STAGE 7: Manual tools
Tron does not run these automatically because most of them don't support command-line use.

1. **ADSSpy**: Scans for hidden NTFS Alternate Data Streams

2. **AdwCleaner**: Popular user-suggested adware removal tool

3. **aswMBR**: Rootkit scanner

4. **autoruns**: Examine and remove programs that run at startup

5. **ComboFix**: The "scorched-earth policy" of malware removal

6. **gmer**: Rootkit/ADS scanner

7. **Junkware Removal Tool**: Temp files and random junkware remover

8. **ServicesRepair.exe**: ESET utility for fixing broken Windows services

9. **TempFileCleaner**: OldTimer utility for cleaning temp files

10. **VirusTotal uploader tool**: Uploads a file directly to VirusTotal for scanning
