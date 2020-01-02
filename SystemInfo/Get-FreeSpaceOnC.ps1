<#
.SYNOPSIS
    Check the amount of free space
.DESCRIPTION
    Check the ammount of free space on drive C: on several systems and format the output as a table.
.NOTES
    Author: Miroslav Vidovic - miroslav-vidovic@hotmail.com
    Tested on: Powershell 5.1
#>

"127.0.0.1", "192.168.15.2", "192.168.15.10" | foreach {
Get-WmiObject -Class Win32_LogicalDisk `
-ComputerName $_ -Filter "DeviceId='C:'" } |
Format-Table SystemName, @{Name="Free"; 
Expression={[math]::round($($_.FreeSpace/1GB), 2)}} -auto