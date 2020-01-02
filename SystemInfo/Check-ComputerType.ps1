<#
.SYNOPSIS
    Check computer type
.DESCRIPTION
    Check computer type based on a predifined hash of values. 
.EXAMPLE
    Check-ComputerType -computername "127.0.0.1"
.NOTES
    Author: Miroslav Vidovic - miroslav-vidovic@hotmail.com
    Tested on: Powershell 5.1
#>

$comptype = DATA {
ConvertFrom-StringData -StringData @'
0 =  Unspecified
1 =  Desktop
2 =  Mobile
3 =  Workstation
4 =  Enterprise Server
5 =  Small Office and Home Office (SOHO) Server
6 =  Appliance PC
7 =  Performance Server
8 =  Maximum
'@
}

function Get-ComputerType {
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [string]$computername="$env:COMPUTERNAME"
    )
    process {
        Get-WmiObject -Class Win32_ComputerSystem `
        -ComputerName $computername |
        Select-Object Name,
        @{Name="ComputerType"; Expression={$comptype["$($_.PCSystemType)"]}}
    }
}

Get-ComputerType -computername "127.0.0.1"
