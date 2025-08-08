Get-Alias |
  Where-Object { "$($_.Options) $($_.Name)" -notmatch 'ReadOnly|Constant|cd' } |
  ForEach-Object { Remove-Item "Alias:$($_.Name)" }

function clear {
  "`n" * $Host.UI.RawUI.WindowSize.Height | Out-Host
  [Console]::SetCursorPosition(0, 0)
}

function config {
  cd ~\.config
}

function astronvim {
  $env:NVIM_APPNAME = "astronvim"
  nvim @args
  Remove-Item Env:NVIM_APPNAME
}

function nvchad {
  $env:NVIM_APPNAME = "nvchad"
  nvim @args
  Remove-Item Env:NVIM_APPNAME
}

function lazyvim {
  $env:NVIM_APPNAME = "lazyvim"
  nvim @args
  Remove-Item Env:NVIM_APPNAME
}

function y {
  $tmp = (New-TemporaryFile).FullName
  yazi $args --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp -Encoding UTF8
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
      Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
  }
  Remove-Item -Path $tmp
}

Invoke-Expression (&starship init powershell)
