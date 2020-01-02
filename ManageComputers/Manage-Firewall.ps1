<#
.SYNOPSIS
    Manage firewall
.DESCRIPTION
    Disable\Enable and check firewall status
.EXAMPLE
    Get-FirewallState
    Disable-Firewall
    Enable-Firewall
.NOTES
    Author: Miroslav Vidovic - miroslav-vidovic@hotmail.com 
    Tested on: Powershell 5.1
#>


function Get-FirewallState{
    [CmdletBinding()]
    param (
        )

    process{
        Get-NetFirewallProfile |
        Select-Object Name, Enabled
    }
}

function Disable-Firewall{
    [CmdletBinding()]
    param (
        )
    process {
        Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
    }

    end {
        Get-FirewallState
    }
}

function Enable-Firewall {
    [CmdletBinding()]
    param (
    )
    process {
        Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
    }
    
    end {
        Get-FirewallState
    }
}

Get-FirewallState