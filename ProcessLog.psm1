#--------------------------------------------------#
# Created By: Christopher N. Sefcik
# Usage: Creates a log called "ProcessLog.txt" that is used to log messages during
#        a scripts execution
#--------------------------------------------------#

function Start-ProcessLog{

    [CmdletBinding()]
    param (
        [Parameter(mandatory)] [string]$path,
	[bool]$display=$True
    )

    New-Item -path $path -Name "ProcessLog.txt"
    $path += "\ProcessLog.txt"
    $time = Get-Date
    if($display) {Write-Host "$time : START PROCESS" -ForegroundColor Green}
    "$time : START PROCESS" | Out-File -FilePath $path -Append
    "#--------------------------#" | Out-File -FilePath $path -Append

    <#
	.SYNOPSIS
	Creates a process log text file called ProcessLog.txt at the specified path
	Indicates the time the process log was created
	.DESCRIPTION
	Creates a process log text file called ProcessLog.txt at the specified path
	Indicates the time the process log was created
	.PARAMETER path
	Required. String variable that specifies the absolute path to a directory to store ProcessLog.txt 
	.PARAMETER display
	Optional. Boolean variable that specifies whether or not to display the log messages in the terminal window
	.INPUTS
	.OUTPUTS
	.EXAMPLE
	Start-ProcessLog -path "C:\Users\Contoso"
	Start-ProcessLog -path "C:\Users\Contoso" -display $False
	.LINK
	Write-ProcessLog
	Stop-ProcessLog
    #>
}

function Write-ProcessLog {

    [CmdletBinding()]
    param (
	[Parameter(mandatory)] [string]$message,
        [Parameter(mandatory)] [string]$path,
	[bool]$display=$True
    )

    $time = Get-Date
    if($display) {Write-Host "$time : $message" -ForegroundColor Green}
    
    try { 
	$processLog="$path\ProcessLog.txt"
	"$time : $message" | Out-File -FilePath $processLog -Append 
    } catch { 
	Write-Host "Error: Unable to write to message to ProcessLog.txt"
    }

    <#
	.SYNOPSIS
	Writes a message to the ProcessLog.txt text file 
	.DESCRIPTION
	Writes a message to the ProcessLog.txt text file 
	Using this function requires a file called ProcessLog.txt is present in the directory specified by the 'path' parameter
	To create ProcessLog.txt, use Start-Process function 
	ProcessLog.txt file 
	.PARAMETER message
	Required. String variable containing the message to write to the process log
	.PARAMETER path
	Required. String variable containing the absolute path to the directory that contains the file ProcessLog.txt
	.PARAMETER display
	Optional. Boolean variable that specifies whether or not to display the log messages in the terminal window
	.INPUTS
	.OUTPUTS
	.EXAMPLE
	Write-ProcessLog -path "C:\Users\Contoso"
	Write-ProcessLog -path "C:\Users\Contoso" -message "file transfer complete" -display $False
	.LINK
	Start-ProcessLog
	Stop-ProcessLog
    #>
}

function Stop-ProcessLog{

    [CmdletBinding()]
    param (
        [Parameter(mandatory)] [string]$path,
	[Parameter(mandatory)] [bool]$display
    )

    $path += "\ProcessLog.txt"
    $time = Get-Date
    if($display) {Write-Host "$time : END PROCESS" -ForegroundColor Green}
    "#--------------------------#" | Out-File -FilePath $path -Append
    "$time : END PROCESS" | Out-File -FilePath $path -Append

    <#
	.SYNOPSIS
	Generates a message indicating the end of the process log
	Indicates the time the process log was stopped
	.DESCRIPTION
	Generates a message indicating the end of the process log
	Indicates the time the process log was stopped
	.PARAMETER path
	Required. String variable that specifies the absolute path to a directory to store ProcessLog.txt 
	.PARAMETER display
	Optional. Boolean variable that specifies whether or not to display the log messages in the terminal window
	.INPUTS
	.OUTPUTS
	.EXAMPLE
	Stop-ProcessLog -path "C:\Users\Contoso"
	Stop-ProcessLog -path "C:\Users\Contoso" -display $False
	.LINK
	Start-ProcessLog
	Write-ProcessLog
    #>
}

