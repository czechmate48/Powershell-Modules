#--------------------------------------------------#
# FUNCTIONS
#--------------------------------------------------#
function Set-RegistryValue{
    [CmdletBinding()]
    param (
        [string]$path, 
        [string]$name, 
        [string]$value
    )

    try{ 
        Get-ItemProperty -Path $path | Select-Object -ExpandProperty $name -ErrorAction Stop | Out-Null
        Write-Host -ForegroundColor Green "CONFIRMED: $name exists"
        Set-ItemProperty $path $name -Value $value -type String
        Write-Host "SUCCESS: $name set in registry" -ForegroundColor Green
    } 
    catch [System.Management.Automation.PSArgumentException]
    {
        Write-Host -ForegroundColor Green "CONFIRMED: $name value doesn't exist" 
        New-ItemProperty $path -Name $name -Value $value | Out-Null
        Write-Host "SUCCESS: $name set in registry" -ForegroundColor Green
    }
    catch 
    {
        Write-Host -ForegroundColor Red "ERROR: Uncaught exception setting registry $name. Cannot set registry value"
        Write-Host -ForegroundColor Red "Exiting Program"
    }
}
function Remove-RegistryItem(){

    [CmdletBinding()]
    param (
        [string] $path,
        [string] $name
    )

    try {
        Remove-ItemProperty $path -Name $name | Out-Null
        Write-Host -ForegroundColor Green "SUCCESS: $name removed from registry" 
    }
    catch {
        Write-Host -ForegroundColor Red "ERROR: Couldn't remove $name from registry"
    }
}
