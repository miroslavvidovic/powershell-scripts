<#
.SYNOPSIS
    Restart a PC
.DESCRIPTION
    Restart a PC with a given IP address or name
.EXAMPLE
    PS C:\> <example usage>
    restart-PC -computername "192.168.15.2"
    restart-PC -computername "MyComputerName"
.INPUTS
.OUTPUTS
.NOTES
    Author: Miroslav Vidovic - mrioslav-vidovic@hotmail.com
    Tested on: Powershell 5.1

    Credentials if needed are inserted in the following format
    for AD
    DOMAINNAME\USER
    PASSWORD
    for local account
    COMPUTER\USER
    PASSWORD
#>

function restart-PC {
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)]
        [string]$computername="$env:COMPUTERNAME"
    )
BEGIN{
    $cred = Get-Credential
}
PROCESS {
    $comp = Get-WmiObject Win32_OperatingSystem -ComputerName $computername -Credential $cred
    $ret = $comp.Reboot()
    if ($ret.ReturnValue -eq 0){
        Write-Host "Restarting $computername succeeded."
    }
    else {Write-Host "Restarting $computername failed"}
    }
}

restart-pc -computername "192.168.15.2"
