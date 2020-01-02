<#
.SYNOPSIS
    Check the RAM memmory
.DESCRIPTION
    Check the amount of RAM memmory
.EXAMPLE
    Get-RamMemmory -computername "127.0.0.1"
.NOTES
    Author: Miroslav Vidovic - miroslav-vidovic@hotmail.com
    Tested on: Powershell 5.1
#>

function Get-RamMemmory {
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$true)]
        [string]$computername
    )
    Get-WmiObject -Class Win32_ComputerSystem -ComputerName $computername |
    Select-Object Name, @{Name="RAM"; Expression={$([math]::round(($_.TotalPhysicalMemory / 1gb),2))}}
}

Get-RamMemmory -computername "127.0.0.1"