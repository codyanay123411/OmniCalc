# Makes OmniCalc your PC's calculator:
#  - Start menu entry named "Calculator" (so searching "calc" finds OmniCalc)
#  - Keyboard Calculator key opens OmniCalc
#  - Links that open the Windows calculator (ms-calculator:) open OmniCalc
#  - Removes the built-in Windows Calculator app (after asking)
# Undo everything with "Restore Windows Calculator.cmd".
$ErrorActionPreference = 'Stop'
$here  = $PSScriptRoot
$html  = Join-Path $here 'OmniCalc.html'
$icon  = Join-Path $here 'OmniCalc.ico'
if (-not (Test-Path $html)) { throw "OmniCalc.html must be in the same folder as this script ($here)." }

$edge = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe' -ErrorAction SilentlyContinue).'(default)'
if (-not $edge) { $edge = @("${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe", "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe") | Where-Object { Test-Path $_ } | Select-Object -First 1 }
if (-not $edge) { throw 'Microsoft Edge was not found.' }
$uri = ([System.Uri]$html).AbsoluteUri
$edgeArgs = "--app=`"$uri`" --window-size=1200,820"

# 1. Shortcuts: "OmniCalc" and "Calculator" in the Start menu, OmniCalc on the Desktop
$programs = [Environment]::GetFolderPath('Programs')
$shell = New-Object -ComObject WScript.Shell
$calcLnk = Join-Path $programs 'Calculator.lnk'
foreach ($path in @((Join-Path $programs 'OmniCalc.lnk'), $calcLnk, (Join-Path ([Environment]::GetFolderPath('Desktop')) 'OmniCalc.lnk'))) {
    $s = $shell.CreateShortcut($path)
    $s.TargetPath = $edge; $s.Arguments = $edgeArgs; $s.WorkingDirectory = $here
    $s.IconLocation = "$icon,0"; $s.Description = 'OmniCalc'; $s.Save()
}
Write-Host '[1/4] Start menu "Calculator" now opens OmniCalc.' -ForegroundColor Green

# 2. Keyboard Calculator key
$appKey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\AppKey\18'
New-Item $appKey -Force | Out-Null
Set-ItemProperty $appKey -Name ShellExecute -Value $calcLnk
Write-Host '[2/4] Calculator key on your keyboard now opens OmniCalc.' -ForegroundColor Green

# 3. ms-calculator: links
$proto = 'HKCU:\Software\Classes\ms-calculator'
New-Item "$proto\shell\open\command" -Force | Out-Null
Set-ItemProperty $proto -Name '(default)' -Value 'URL:OmniCalc'
Set-ItemProperty $proto -Name 'URL Protocol' -Value ''
Set-ItemProperty "$proto\shell\open\command" -Name '(default)' -Value "`"$edge`" $edgeArgs"
Write-Host '[3/4] Calculator links now open OmniCalc.' -ForegroundColor Green

# 4. Remove the built-in Windows Calculator (current user only; reinstallable from the Microsoft Store)
$pkg = Get-AppxPackage -Name 'Microsoft.WindowsCalculator' -ErrorAction SilentlyContinue
if ($pkg) {
    $ans = Read-Host 'Remove the built-in Windows Calculator app now? You can reinstall it any time. (y/n)'
    if ($ans -match '^[yY]') {
        $pkg | Remove-AppxPackage
        Write-Host '[4/4] Windows Calculator removed.' -ForegroundColor Green
    } else { Write-Host '[4/4] Kept Windows Calculator.' -ForegroundColor Yellow }
} else { Write-Host '[4/4] Windows Calculator is already removed.' -ForegroundColor Green }

Write-Host ''
Write-Host 'Done. If the Calculator key still opens the old app, sign out and back in.'
Read-Host 'Press Enter to close'
