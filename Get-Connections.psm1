###################
#Created by: Christopher N. Sefcik
#Date: 9/20/2020
###################

Function Get-Connections{

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        $computerList
    )
    
    $connectedDevices = New-Object System.Collections.ArrayList
    $disconnectedDevices = New-Object System.collections.ArrayList

    Write-Host ""
    Write-Host "GENERATING DEVICE LISTS, PLEASE WAIT..." -ForegroundColor Yellow
    Write-Host ""

    foreach ($computer in $computerList) {

        Write-Host "Testing Connection: " -NoNewline -ForegroundColor Blue; Write-Host "$computer" -NoNewline -ForegroundColor White

        try{
            Test-Connection $computer -ErrorAction Stop | Out-Null  
            Write-Host " CONNECTED" -ForegroundColor Green
            $connectedDevices += $computer
        }
        catch {
            Write-Host " DISCONNECTED" -ForegroundColor Red
            $disconnectedDevices += $computer
            continue
        }
    }

    return $connectedDevices

    <#
        .SYNOPSIS
        Takes a list of computer names and identifies whether they are currently connected to the network

        .DESCRIPTION
        Pings the device name and identifies whether it will respond. If it responds, then the device is connected to the network

        .PARAMETER computerList
        Required. This variable contains a list of the computers to be tested. Generally obtained by "Get-Content -Path *FilePath*"
    #>
}
