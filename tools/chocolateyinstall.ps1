$ErrorActionPreference = 'Stop';


$packageName= 'topbeat'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.elastic.co/beats/topbeat/topbeat-1.3.1-windows.zip'

$installationPath = $toolsDir

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installationPath
  fileType      = 'EXE_MSI_OR_MSU'
  url           = $url
  url64bit      = $url64

  silentArgs    = "/qn /norestart /l*v `"$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)

  softwareName  = 'topbeat*'
  checksum      = ''
  checksumType  = 'md5'
  checksum64    = ''
  checksumType64= 'md5'
}

Install-ChocolateyZipPackage @packageArgs
Invoke-Expression $(Join-Path $installationPath "topbeat-1.3.1-windows\install-service-topbeat.ps1")
