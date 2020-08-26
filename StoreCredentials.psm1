#-------------------------------#
# CREATED BY: Christopher N. Sefcik
# USE: Store user credentials in a text file. 
#-------------------------------#

function Write-CredentialsToFile {

    [CmdletBinding()]
    param (
	[Parameter(mandatory)] [string] $username,
	[Parameter(mandatory)] [securestring] $password,
	[Parameter(mandatory)] [string]$path,
	[string]$domain,
        [string]$logPath
    )

    try{
        New-Item -path $path -Name "Credentials.txt"
        $credentialsFile = "$path\Credentials.txt" 
        $unsecurePassword = ConvertFrom-SecureString $password -ErrorAction Stop
        $username, $unsecurePassword | Out-File -FilePath $credentialsFile -ErrorAction Stop
	if ($domain) { $domain | Out-File -FilePath $credentialsFile -ErrorAction Stop }
	Write-Host "SUCCESS: Credentials output to $credentialsFile" -ForegroundColor Green
	if ($logPath){ "SUCCESS: Credentials output to $credentialsFile" | Out-File -FilePath $logPath -Append }
    }catch {
        Write-Host "ERROR: Credentials not output to $credentialsFile" -ForegroundColor Red
	if ($logPath) { "FAILURE: Credentials not output to $credentialsFile" | Out-File -FilePath $logPath -Append }
    }
}

function Remove-CredentialsFile{

    [CmdletBinding()]
    param (
        [Parameter(mandatory)] [string] $path,
        [string] $logPath
    )

    try {
        Remove-Item -Path $path
        Write-Host "SUCCESS: Removed Credentials text file" -ForegroundColor Green
        if ($logPath) {"SUCCESS: Removed Credentials text file" | Out-File -FilePath $logPath -Append}
    } catch {
        Write-Host "ERROR: Problem removing Credentials text file" -ForegroundColor Red
        if ($logPath) {"FAILURE: Problem removing Credentials text file" | Out-File -FilePath $logPath -Append}
    }
}