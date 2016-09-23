$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Invoke-Expression $(Join-Path $toolsDir "topbeat-1.3.1-windows\uninstall-service-topbeat.ps1")
Uninstall-ChocolateyZipPackage '__NAME__' "topbeat.1.3.1.nupkg"
