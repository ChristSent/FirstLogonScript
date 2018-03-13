This script utilizes Microsoft's Built-In RunOnce functionality to setup a script that you specify to run the first time a new user logs into a system.

Instructions:
1. Run powershell as administrator
2. Run:
PS> Setup-FirstLogonScript.ps1 -ScriptPath <full-path-to.script> -ScriptName <Nickname for Script> -powershell or -bash


Either choose -powershell or -bash depending on what type os script your adding.