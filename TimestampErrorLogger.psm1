#--------------------------------------------------#
# FUNCTIONS
#--------------------------------------------------#
function Start-TimestampErrorLog(){

    [CmdletBinding()]
    param (
        [string] $path
    )

    $logPath = "$path\ErrorLog.txt"

    New-Item -Path $logPath | Out-Null
    $time = Get-Date -UFormat "%c"
    "#-------------------------------------------------------#" | Out-File -FilePath $logPath -Append
    "# ERROR LOG STARTED: $time" | Out-File -FilePath $logPath -Append
    "#-------------------------------------------------------#" | Out-File -FilePath $logPath -Append
}
function Write-TimestampError(){

    [CmdletBinding()]
    param (
        [string] $path,
        [string] $currentError
    )

    $logPath = "$path\ErrorLog.txt"

    $time = Get-Date -UFormat "%c"
    $time, $currentError | Out-File -FilePath $logPath -Append
    "#-------------------------------------------------------#" | Out-File -FilePath $logPath -Append
}
function Stop-TimestampErrorLog(){

    [CmdletBinding()]
    param (
        [string] $path
    )

    $logPath = "$path\ErrorLog.txt"

    $time = Get-Date -UFormat "%c"
    "#-------------------------------------------------------#" | Out-File -FilePath $logPath -Append
    "# ERROR LOG STOPPED: $time" | Out-File -FilePath $logPath -Append
    "#-------------------------------------------------------#" | Out-File -FilePath $logPath -Append
}
