 Param(
    [Parameter(Mandatory=$true)]
    [string]$ScriptPath,
    [Parameter(Mandatory=$true)]
    [string]$ScriptName,
    [Parameter(Mandatory=$true,ParameterSetName="powershell")]
    [switch]$powershell,
    [Parameter(Mandatory=$true,ParameterSetName="batch")]
    [switch]$batch
)

if(-not(Test-Path $ScriptPath)) { 
    Throw "The path you specified was invalid."
    exit
}

if($powershell) {
    $ScriptPath = 'C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -executionPolicy Bypass -File ' + $ScriptPath
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
REG ADD HKU\TEMP\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v $ScriptName /t REG_SZ /d $ScriptPath /f
REG UNLOAD HKU\TEMP

#Run garbage collection to close open handle to the registry.
[gc]::Collect()