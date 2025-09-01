winget install --id Microsoft.VCRedist.2015+.x86
winget install --id Microsoft.VCRedist.2015+.x64
winget install --id Microsoft.PowerShell

if ( -not (Get-command scoop -ErrorAction SilentlyContinue)){
 Invoke-RestMethod get.scoop.sh | Invoke-Expression
}

scoop bucket add versions
scoop bucket add nerd-fonts
scoop install JetBrainsMono-NF
scoop install wezterm-nightly
scoop install neovim
scoop install msys2
scoop install which
scoop install gh
scoop install gcc
scoop install nodejs
scoop install starship

git clone https://github.com/izzaldev/nvim $env:LOCALAPPDATA\nvim

New-Item -Path (&Split-Path $PROFILE.CurrentUserAllHosts) -ItemType Directory
New-Item -Path $PROFILE.CurrentUserAllHosts -ItemType File
Write-Output "starship init powershell | Invoke-Expression" > $PROFILE.CurrentUserAllHosts