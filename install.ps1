winget install --id Microsoft.VCRedist.2015+.x86
winget install --id Microsoft.VCRedist.2015+.x64
winget install --id Microsoft.PowerShell

if ( -not (Get-command scoop -ErrorAction SilentlyContinue)){
 Invoke-RestMethod get.scoop.sh | Invoke-Expression
}

scoop bucket add versions
scoop bucket add nerd-fonts
scoop bucket add extras
scoop install nerd-fonts/JetBrainsMono-NF
scoop install versions/wezterm-nightly
scoop install neovim
scoop install msys2
scoop install which
scoop install gh
scoop install gcc
scoop install nodejs
scoop install starship
scoop install extras/lazygit
scoop install grep
scoop install fd

git clone https://github.com/izzaldev/nvim $env:LOCALAPPDATA\nvim

New-Item -Path (&Split-Path $PROFILE.CurrentUserAllHosts) -ItemType Directory -Force
New-Item -Path $PROFILE.CurrentUserAllHosts -ItemType File -Force
Write-Output "starship init powershell | Invoke-Expression" > $PROFILE.CurrentUserAllHosts