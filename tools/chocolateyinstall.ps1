$ErrorActionPreference = 'Stop';


$packageName= 'topbeat'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.elastic.co/beats/topbeat/topbeat-1.3.1-windows.zip'

$installationPath = $toolsDir

# # Now parse the packageParameters using good old regular expression
# if ($packageParameters) {
#   $match_pattern = "\/(?<option>([a-zA-Z]+)):(?<value>([`"'])?([a-zA-Z0-9- _\\:\.]+)([`"'])?)|\/(?<option>([a-zA-Z]+))"
#   $option_name = 'option'
#   $value_name = 'value'

# if ($packageParameters -match $match_pattern ) {
#     $results = $packageParameters | Select-String $match_pattern -AllMatches
#     $results.matches | % {
#       $arguments.Add(
#       $_.Groups[$option_name].Value.Trim(),
#       $_.Groups[$value_name].Value.Trim())
#     }
#   }
#   else
#   {
#     Throw "Package Parameters were found but were invalid (REGEX Failure)"
#   }

#   if ($arguments.ContainsKey("InstallationPath")) {
#     Write-Host "You want to use a custom Installation Path"
#     $installationPath = $arguments["InstallPath"]
#   }
# }

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
