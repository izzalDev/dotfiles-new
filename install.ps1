$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
$adminCommands = @'
winget install --id Microsoft.VCRedist.2015+.x64 --accept-source-agreements --accept-package-agreements
winget install --id Microsoft.PowerShell --accept-source-agreements --accept-package-agreements
'@

if (-not $IsAdmin) {
    $proc = Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile", "-Command", $adminCommands -PassThru
    $proc.WaitForExit()
}

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
}

scoop install aria2 
scoop config aria2-warning-enabled false
scoop bucket add versions
scoop bucket add nerd-fonts
scoop bucket add extras

scoop install nerd-fonts/JetBrainsMono-NF
scoop install versions/wezterm-nightly
scoop install neovim
scoop install which
scoop install gh
scoop install gcc
scoop install nodejs
scoop install starship
scoop install extras/lazygit
scoop install grep
scoop install fd
scoop install tre-command
scoop install busybox
scoop install komorebi
scoop install yazi
scoop install whkd

git clone https://github.com/izzaldev/nvim $env:LOCALAPPDATA\nvim

$profileScript = @'
Get-Alias |
  Where-Object { "$($_.Options) $($_.Name)" -notmatch 'ReadOnly|Constant|cd' } |
  ForEach-Object { Remove-Item "Alias:$($_.Name)" }

function y {
  $tmp = (New-TemporaryFile).FullName
  yazi $args --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp -Encoding UTF8
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
      Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
  }
  Remove-Item -Path $tmp
}

function clear {
  "`n" * $Host.UI.RawUI.WindowSize.Height | Out-Host
  [Console]::SetCursorPosition(0, 0)
}

starship init powershell | Invoke-Expression
'@

[System.Environment]::SetEnvironmentVariable("YAZI_FILE_ONE", "C:\Program Files\Git\usr\bin\file.EXE", "User")
[System.Environment]::SetEnvironmentVariable("KOMOREBI_CONFIG_HOME", "$Env:USERPROFILE\.config\komorebi", "User")
[System.Environment]::SetEnvironmentVariable("WHKD_CONFIG_HOME", "$Env:USERPROFILE\.config\whkd", "User")

komorebic enable-autostart --whkd
komorebic start --whkd

New-Item -Path "$env:USERPROFILE\Documents\PowerShell" -ItemType Directory -Force
New-Item -Path "$env:USERPROFILE\Documents\PowerShell\profile.ps1" -ItemType File -Force
$profileScript > $env:USERPROFILE\Documents\PowerShell\profile.ps1
