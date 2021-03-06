function GetAGMPowerCLIInstall
{
  # Returns the known installation locations for the AGMPowerCLI Module
  return Get-Module -ListAvailable -Name AGMPowerCLI -ErrorAction SilentlyContinue | Select-Object -Property Name, Version, ModuleBase
}

function GetPSModulePath 
{
    # Returns all available PowerShell Module paths  
    # Windows uses semi-colons, Linux and Mac use colons, go figure.
    $platform=$PSVersionTable.platform
	if ( $platform -match "Unix" )
	{
		return $env:PSModulePath.Split(':')
    }
    else 
    {
      $hostVersionInfo = (get-host).Version.Major
      if ( $hostVersionInfo -lt "6" )
      {
        return $env:PSModulePath.Split(';') 
      }
      else 
      {
        return $env:PSModulePath.Split(';') -notmatch "WindowsPowerShell"
      }
    }

}

function InstallMenu 
{
  # Creates a menu of available install or upgrade locations for the module
  Param(
    [Array]$InstallPathList,
    [ValidateSet('installation','upgrade or delete')]
    [String]$InstallAction
  )
  $i = 1
  foreach ($Location in $InstallPathList)
  {
    Write-Host -Object "$i`: $Location"
    $i++
  }

  While ($true) 
  {
    [int]$LocationSelection = Read-Host -Prompt "`nPlease select an $InstallAction path"
    if ($LocationSelection -lt 1 -or $LocationSelection -gt $InstallPathList.Length)
    {
      Write-Host -Object "Invalid selection. Please enter a number in range [1-$($InstallPathList.Length)]"
    } 
    else
    {
      break
    }
  }
  
  return $InstallPathList[($LocationSelection - 1)]
}

function RemoveModuleContent 
{
  # Attempts to remove contents from an existing installation
  try 
  {
    Remove-Item -Path $InstallPath -Recurse -Force -ErrorAction Stop -Confirm:$true
  }
  catch 
  {
    throw "$($_.ErrorDetails)"
  }
}

function CreateModuleContent
{
  $platform=$PSVersionTable.platform
  # Attempts to create a new folder and copy over the AGMPowerCLI Module contents
  try
  {
    if ( $platform -notmatch "Unix" )
    {
    $null = Get-ChildItem -Path $PSScriptRoot\AGMPowerCLI* -Recurse | Unblock-File
    }
    $null = New-Item -ItemType Directory -Path $InstallPath -Force -ErrorAction Stop
    $null = Copy-Item $PSScriptRoot\AGMPowerCLI* $InstallPath -Force -Recurse -ErrorAction Stop
    $null = Test-Path -Path $InstallPath -ErrorAction Stop
    
    Write-Host -Object "`nInstallation successful."
  }
  catch 
  {
    throw $_
  }
}

function ReportAGMPowerCLI
{
  # Removes the AGMPowerCLI Module from the active session and displays a list of all current install locations
  Remove-Module -Name AGMPowerCLI -ErrorAction SilentlyContinue
  GetAGMPowerCLIInstall
}

### Code
Clear-Host

$hostVersionInfo = (get-host).Version.Major
if ( $hostVersionInfo -lt "5" )
{
    Write-Host "This module only works with PowerShell Version 5.  You are running version $hostVersionInfo."
    Write-Host "You will need to install PowerShell Version 5 or higher and try again"
    break
}

Import-LocalizedData -BaseDirectory $PSScriptRoot\ -FileName AGMPowerCLI.psd1 -BindingVariable ActModuleData
Write-host 'Detected PowerShell version:   ' $hostVersionInfo
Write-host 'Downloaded ActPowerCLI version:' $ActModuleData.ModuleVersion
Write-host ""

[Array]$ActInstall = GetAGMPowerCLIInstall
if ($ActInstall.Length -gt 0)
{
    Write-Host 'Found an existing AGMPowerCLI Module installation in the following locations:' 
    ReportAGMPowerCLI | Format-Table
    write-host ""
    Write-host "Upgrade or delete menu (choose a folder to upgrade to"$ActModuleData.ModuleVersion"or choose the delete option):"
    $ActInstall += @{
        Name       = 'Delete All'
        Version    = 0.0.0.0
        ModuleBase = 'DELETE all listed installations of the AGMPowerCLI Module'
        }
    $InstallPath = InstallMenu -InstallPathList $ActInstall.ModuleBase -InstallAction 'upgrade or delete'
    
    if ($InstallPath.Split(' ')[0] -eq 'DELETE')
    {
        foreach ($Location in ([Array]$ActInstall = GetAGMPowerCLIInstall).ModuleBase)
        {
        $InstallPath = $Location
        RemoveModuleContent      
        }
        break
    }
    else
    {
        RemoveModuleContent
        CreateModuleContent
    }
    }
    else
    {
    Write-Host "Could not find an existing AGMPowerCLI Module installation."
    Write-Host "Where would you like to install AGMPowerCLI version"$ActModuleData.ModuleVersion
    Write-Host ""
    $InstallPath = InstallMenu -InstallPathList (GetPSModulePath) -InstallAction installation
    $InstallPath = $InstallPath + '\AGMPowerCLI\'
    CreateModuleContent
}

Write-Host -Object "`nAGMPowerCLI Module installation location(s):"
ReportAGMPowerCLI | Format-Table