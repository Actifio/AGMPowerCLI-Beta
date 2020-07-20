#
# Module manifest for module 'AGMPowerCLI'
#
# Generated by: Anthony Vandewerdt
#
# Generated on: 16/6/2020
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'AGMPowerCLI.psm1'

# Version number of this module.
ModuleVersion = '0.0.0.7'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '31f83a9e-9fe8-43b4-9a82-02325de71f2a'

# Author of this module
Author = 'Anthony Vandewerdt'

# Company or vendor of this module
CompanyName = 'Actifio'

# Copyright statement for this module
Copyright = '(c) 2020 Actifio, Inc. All rights reserved'

# Description of the functionality provided by this module
Description = 'This is a community generated powershell module for AGM.  This is pre-BETA'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '7.0'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    'Get-AGMAPIData',
    'Post-AGMAPIData',
    'Put-AGMAPIData',
    'Connect-AGM',
    'Disconnect-AGM',
    'Convert-FromUnixDate',
    'Convert-ToUnixDate',
    'Convert-AGMDuration',
    'Get-AGMErrorMessage',
    'Test-AGMJSON',
    'Get-AGMAppliance',
    'Get-AGMApplication',
    'Get-AGMApplicationActiveImage',
    'Get-AGMApplicationAppClass',
    'Get-AGMApplicationBackup',
    'Get-AGMApplicationInstanceMember',
    'Get-AGMApplicationMember',
    'Get-AGMApplicationTypes',
    'Get-AGMApplicationWorkflow',
    'Get-AGMApplicationWorkflowStatus',
    'Get-AGMAudit',
    'Get-AGMConsistencyGroup',
    'Get-AGMDiskPool',
    'Get-AGMEvent',
    'Get-AGMHost',
    'Get-AGMImage',
    'Get-AGMJob',
    'Get-AGMJobCountSummary',
    'Get-AGMJobHistory',
    'Get-AGMJobStatus',
    'Get-AGMLDAPConfig',
    'Get-AGMLDAPGroup',
    'Get-AGMLogicalGroup',
    'Get-AGMLogicalGroupMember',
    'Get-AGMOrg',
    'Get-AGMRight',
    'Get-AGMRole',
    'Get-AGMSession',
    'Get-AGMSLT',
    'Get-AGMSLTPolicy',
    'Get-AGMSLP',
    'Get-AGMSLA',
    'Get-AGMTimeZoneHandling',
    'Get-AGMUpgradeHistory',
    'Get-AGMUser',
    'Get-AGMVersion',
    'Get-AGMVersionDetail',
    'Get-AGMWorkflow',
    'Save-AGMPassword',
    'Set-AGMAPILimit',
    'Set-AGMTimeZoneHandling',
    'Set-AGMOrgApplication',
    'Set-AGMOrgHost',
    'Set-AGMOrgLogicalGroup',
    'New-AGMMount',
    'New-AGMOrg',
    'New-AGMRole',
    'Remove-AGMApplication',
    'Remove-AGMImage',
    'Remove-AGMJob',
    'Remove-AGMMount',
    'Remove-AGMOrg',
    'Remove-AGMRole',
    'Remove-AGMUser',
    'Update-AGMOrg')

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = '*'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @("Actifio","AGM","Sky","CDS","CDX","VDP")

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/Actifio/AGMPowerCLI-Beta/blob/main/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/Actifio/AGMPowerCLI-Beta'

        # A URL to an icon representing this module.
        IconUri = 'https://i.imgur.com/QAaK5Po.jpg'

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

