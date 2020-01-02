<#
.SYNOPSIS
    List user accounts
.DESCRIPTION
    Showe detailed info about user accounts on a Windows system
.EXAMPLE
    Get-UserAccounts -computername "192.168.15.2"
    User accounts from a pc based on IP address
    Get-UserAccounts -computername "MyComputerName"
    User accounts from a pc based on computer name
.NOTES
    Author: Miroslav Vidovic - miroslav-vidovic@hotmail.com
    Tested on: Powershell 5.1
#>

function Get-UserAccounts{
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)]
        [string]$computername="$env:COMPUTERNAME"
    )
PROCESS{
    Get-WmiObject -Class Win32_UserAccount -ComputerName $computername |
    Select-Object AccountType, Description, Disabled, Domain, FullName,
    InstallDate, LocalAccount, Lockout, Name, PasswordChangeable,
    PasswordExpires, PasswordRequired, SID, SIDType 
}}

Get-UserAccounts -computername "MyComputerName"
