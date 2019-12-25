<#
.SYNOPSIS
    Check licence information
.DESCRIPTION
    Check the licence status of Microsoft products on a selected computer
.EXAMPLE
    Get-LicenceStatus -computername "192.168.15.2"
    Check the licence status based on an ip address
    Get-LicenceStatus -computername "MyComputerName"
    Check the licence status based on a computername
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    Author: Miroslav Vidovic - miroslav-vidovic@hotmail.com
    Tested on: Powershell 5.1
#>

$lstat = DATA {
ConvertFrom-StringData -StringData @'
0 = Unlicensed
1 = Licensed
2 = OOB Grace
3 = OOT Grace
4 = Non-Genuine Grace
5 = Notification
6 = Extended Grace
'@
}

function Get-LicenceStatus {
    param (
        [parameter(ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)]
        [string]$computername="$env:COMPUTERNAME"
    )
    PROCESS {
        Get-WmiObject SoftwareLicensingProduct -ComputerName $computername |
        where {$_.PartialProductKey} | 
        select PSComputerName, Name, ApplicationId,
        @{N="LicenseStatus"; E={$lstat["$($_.LicenseStatus)"]} } 
}}

Get-LicenceStatus -computername "192.168.15.2"
