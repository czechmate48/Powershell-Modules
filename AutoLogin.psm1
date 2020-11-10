#--------------------------------------------------#
# Created By: Christopher N. Sefcik
# Usage: Edits the registry to allow for auto login
#--------------------------------------------------#

function Install-AutoLogin {

    [CmdletBinding()]
    param (
	[Parameter(Mandatory=$true)]
        [string] $localAdminName,
        [Parameter(Mandatory=$true)]
	[string] $localAdminPassword,
        [string] $logPath
    )

    $regPath = "HKLM:\SOFTWARE\Microsoft\WINDOWS NT\CurrentVersion\Winlogon"

    #USERNAME
    try{
        Set-RegistryValue -path $regPath -name "DefaultUserName" -value $localAdminName
        if ($logPath) {"SUCCESS: DefaultUserName set in registry" | Out-File -FilePath $logPath -Append}
    }
    catch{
        if ($logPath) {"ERROR: DefaultUserName not set in registry" | Out-File -FilePath $logPath -Append}
    }

    #PASSWORD
    try{
        Set-RegistryValue -path $regPath -name "DefaultPassword" -value $localAdminPassword
        if ($logPath) {"SUCCESS: DefaultPassword set in registry" | Out-File -FilePath $logPath -Append}
    }
    catch{
        if ($logPath) {"ERROR: DefaultPassword not set in registry" | Out-File -FilePath $logPath -Append}
    }

    #AUTO LOGIN
    try{
        Set-RegistryValue -path $regPath -name "AutoAdminLogon" -value $true
        if ($logPath) {"SUCCESS: AutoAdminLogon set in registry" | Out-File -FilePath $logPath -Append}
    }
    catch{
        if ($logPath) {"ERROR: AutoAdminLogon not set in registry" | Out-File -FilePath $logPath -Append}
    }

    <#
	.SYNOPSIS
	Edits the registry to allow for automatic log in
	.DESCRIPTION
	Edits the registry to allow for automatic log in. Requires an administrator user name and password
	.PARAMETER localAdminName
	Required. The name of the local administrator account. Requires password is passed in using plain text
	.PARAMETER localAdminPassword
	Required. The password of the local administrator account
	.PARAMETER logPath
	Optional. Used for logging the process in a text file
	.INPUTS
	.OUTPUTS
	.EXAMPLE
	Install-AutoLogin -localAdminName "Administrator" -localAdminPassword "password"
	.LINK
	Uninstall-AutoLogin
    #>
}

function Uninstall-AutoLogin{

    [CmdletBinding()]
    param (
        [string] $logPath
    )

    $regPath = "HKLM:\SOFTWARE\Microsoft\WINDOWS NT\CurrentVersion\Winlogon"

    #USERNAME
    try{
        Remove-RegistryItem -path $regPath -name "DefaultUserName"
        "SUCCESS: DefaultUserName removed from registry" | Out-File -FilePath $logPath -Append
    }
    catch{
        "ERROR: DefaultUserName not removed from registry" | Out-File -FilePath $logPath -Append
        Write-TimestampError -path $PSScriptRoot -currentError $Error[0]
    }

    #PASSWORD
    try{
        Remove-RegistryItem -path $regPath -name "DefaultPassword"
        "SUCCESS: DefaultPassword removed from registry" | Out-File -FilePath $logPath -Append
    }
    catch{
        "ERROR: DefaultPassword not removed from registry" | Out-File -FilePath $logPath -Append
        Write-TimestampError -path $PSScriptRoot -currentError $Error[0]
    }

    #AUTO LOGIN
    try{
        Remove-RegistryItem -path $regPath -name "AutoAdminLogon"
        "SUCCESS: AutoAdminLogon removed from registry" | Out-File -FilePath $logPath -Append
    }
    catch{
        "ERROR: AutoAdminLogon not removed from registry" | Out-File -FilePath $logPath -Append
        Write-TimestampError -path $PSScriptRoot -currentError $Error[0]
    }

    <#
	.SYNOPSIS
	Edits the registry to allow for automatic log in
	.DESCRIPTION
	Edits the registry to allow for automatic log in. Removes login information for an administrator account
	.PARAMETER logPath
	Optional. Used for logging the process in a text file
	.INPUTS
	.OUTPUTS
	.EXAMPLE
	Uninstall-AutoLogin -logPath "C:\users\user\
	.LINK
	Uninstall-AutoLogin
    #>
}