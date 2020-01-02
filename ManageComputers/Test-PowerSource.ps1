<#
.SYNOPSIS
    Check the power source
.DESCRIPTION
    Check the power source of computer
.EXAMPLE
    Test-PowerSource -computername "192.168.15.2"
    Check the power source based on an ip address
    Test-PowerSource -computername "MyComputerName"
    Check the power source based on a computername
.NOTES
    Author: Miroslav Vidovic - miroslav-vidovic@hotmail.com
    Tested on: Powershell 5.1
#>

function Test-PowerSource {
    [CmdletBinding()]
        param (
        [parameter(ValueFromPipeline=$true,
                ValueFromPipelineByPropertyName=$true)]
        [string]$computername="$env:COMPUTERNAME"
    )
    process {
        $status = Get-WmiObject -Namespace 'root\wmi' -Class BatteryStatus `
        -ComputerName $computername
        if ($status.PowerOnLine) {"System on External Power"}
        else {"System on Battery Power"}
}}

Test-PowerSource -computername "127.0.0.1"