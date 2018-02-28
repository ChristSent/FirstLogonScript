 Param(
   [string]$ScriptPath
)



if(-not($scriptPath)) { 
    Throw "You must supply a fully qualified path to your script."
    exit
}

if(-not(Test-Path $ScriptPath)) { 
    Throw "The path you specified was invalid."
    exit
}

# Get the ID and security principal of the current user account

$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()

$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)

 

# Get the security principal for the Administrator role

$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator

 

# Check to see if we are currently running "as Administrator"

if (-not $myWindowsPrincipal.IsInRole($adminRole)) {
    Throw "You must run powershell as administrator before running this script"
}

 
REG LOAD HKU\TEMP "C:\Users\Default\ntuser.dat"
REG ADD HKU\TEMP\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v NewRegKey /t REG_SZ /d $ScriptPath /f
REG UNLOAD HKU\TEMP