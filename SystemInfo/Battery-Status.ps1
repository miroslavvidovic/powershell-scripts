<#
.SYNOPSIS
    Check the battery status
.DESCRIPTION
    Display information regarding the internal battery, charging status and battery percentage.
.EXAMPLE
    Get-Battery -computername "127.0.0.1"
.NOTES
    Author: Miroslav Vidovic - miroslav-vidovic@hotmail.com
    Tested on: Powershell 5.1
#>

$status = DATA {ConvertFrom-StringData -StringData @'
1 = Discharging
2 = On AC. No battery discharge. Not necessarily charging.
6 = Charging
'@}
$chem = DATA {ConvertFrom-StringData -StringData @'
6 = Lithium-ion
'@}

function Get-Battery {
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline=$true,
                ValueFromPipelineByPropertyName=$true)]
        [string]$computername="$env:COMPUTERNAME"
    )
    process {
        Get-WmiObject -Class Win32_Battery  `
        -ComputerName $computername |
        Select-Object DeviceID, Name, Description,
        @{Name="Status";
        Expression={$status["$($_.BatteryStatus)"]}},
        @{Name="Chemistry";
        Expression={$chem["$($_.Chemistry)"]}},
        @{Name="Voltage(V)";
        Expression={$($_.DesignVoltage / 1000)}},
        @{Name="PecentChargeLeft";
        Expression={$($_.EstimatedChargeRemaining)}},
        PowerManagementSupport
    }
}

Get-Battery -computername "127.0.0.1"