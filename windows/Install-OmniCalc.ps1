# OmniCalc installer: creates Start Menu + Desktop shortcuts that open OmniCalc
# in its own app window (no browser tabs or address bar). Run again to repair.
# To remove: run with -Uninstall
param([switch]$Uninstall)

$ErrorActionPreference = 'Stop'
$here      = $PSScriptRoot
$html      = Join-Path $here 'OmniCalc.html'
$icon      = Join-Path $here 'OmniCalc.ico'
$startLnk  = Join-Path ([Environment]::GetFolderPath('Programs')) 'OmniCalc.lnk'
$deskLnk   = Join-Path ([Environment]::GetFolderPath('Desktop'))  'OmniCalc.lnk'
$appKey    = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\AppKey\18'

if ($Uninstall) {
    Remove-Item $startLnk, $deskLnk -ErrorAction SilentlyContinue
    if ((Get-ItemProperty $appKey -ErrorAction SilentlyContinue).ShellExecute -like '*OmniCalc*') { Remove-Item $appKey -Recurse }
    Write-Host 'OmniCalc shortcuts removed. Your Calculator key opens Windows Calculator again.' -ForegroundColor Green
    return
}

if (-not (Test-Path $html)) { throw "OmniCalc.html must be in the same folder as this script ($here)." }

# Find Microsoft Edge (built into Windows 11)
$edge = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe' -ErrorAction SilentlyContinue).'(default)'
if (-not $edge) {
    $edge = @("${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
              "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe") | Where-Object { Test-Path $_ } | Select-Object -First 1
}
if (-not $edge) { throw 'Microsoft Edge was not found.' }

$uri  = ([System.Uri]$html).AbsoluteUri
$edgeArgs = "--app=`"$uri`" --window-size=1200,820"

$shell = New-Object -ComObject WScript.Shell
foreach ($path in @($startLnk, $deskLnk)) {
    $s = $shell.CreateShortcut($path)
    $s.TargetPath       = $edge
    $s.Arguments        = $edgeArgs
    $s.WorkingDirectory = $here
    $s.IconLocation     = "$icon,0"
    $s.Description      = 'OmniCalc - scientific, graphing, programmer and more'
    $s.Save()
}
Write-Host "Installed. Search 'OmniCalc' in the Start menu, or use the Desktop icon." -ForegroundColor Green

$ans = Read-Host "Make your keyboard's Calculator key open OmniCalc instead of Windows Calculator? (y/n)"
if ($ans -match '^[yY]') {
    New-Item $appKey -Force | Out-Null
    Set-ItemProperty $appKey -Name ShellExecute -Value $startLnk
    Write-Host 'Done. The Calculator key now opens OmniCalc (sign out and back in if it does not change right away).' -ForegroundColor Green
}
Write-Host 'Tip: open OmniCalc, right-click its taskbar icon and choose "Pin to taskbar".'
Write-Host ''
Read-Host 'Press Enter to close'
