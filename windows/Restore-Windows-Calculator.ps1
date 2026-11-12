# Undoes "Make OmniCalc Default": puts the Windows Calculator back. OmniCalc itself stays installed.
$programs = [Environment]::GetFolderPath('Programs')
Remove-Item (Join-Path $programs 'Calculator.lnk') -ErrorAction SilentlyContinue
Remove-Item 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\AppKey\18' -Recurse -ErrorAction SilentlyContinue
Remove-Item 'HKCU:\Software\Classes\ms-calculator' -Recurse -ErrorAction SilentlyContinue
Write-Host 'Calculator key, links and the "Calculator" shortcut are back to normal.' -ForegroundColor Green
if (-not (Get-AppxPackage -Name 'Microsoft.WindowsCalculator' -ErrorAction SilentlyContinue)) {
    Write-Host 'Opening the Microsoft Store page for Windows Calculator. Click Get or Install.'
    Start-Process 'ms-windows-store://pdp/?ProductId=9WZDNCRFHVN5'
}
Read-Host 'Press Enter to close'
