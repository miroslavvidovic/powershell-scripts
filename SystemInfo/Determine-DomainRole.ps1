<#
.SYNOPSIS
    Determine a domain role of a computer system.
.NOTES
    Author: Miroslav Vidovic - miroslav-vidovic@hotmail.com
#>

$domrole = DATA {
    ConvertFrom-StringData -StringData @'
0 = Standalone Workstation
1 = Member Workstation
2 = Standalone Server
3 = Member Server
4 = Backup Domain Controller
5 = Primary Domain Controller
'@
}

function Get-DomainRole {
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string]$computername = "$env:COMPUTERNAME"
    )
    PROCESS {
        Get-WmiObject -Class Win32_ComputerSystem `
            -ComputerName $computername |
        select Name, Domain,
        @{Name         = "DomainRole";
            Expression = { $domrole["$($_.DomainRole)"] }
        }
    }
}

Get-DomainRole "127.0.0.1"