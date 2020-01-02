<#
.SYNOPSIS
    Shutdown multiple computers
.DESCRIPTION
    Shutdown a PC with a given IP address or name
.NOTES
    Author: Miroslav Vidovic - mrioslav-vidovic@hotmail.com
    Tested on: Powershell 5.1

    Script expects a comptuers.csv file in the following format:
    where the first row (Computer) is the header
    Computer
    W08R2CS01
    W08R2CS02
    W08R2SQL08
    W08R2SQL08A
    WSS08
    DC02
#>

Import-Csv computers.csv |
ForEach-Object {
    (Get-WmiObject -Class Win32_OperatingSystem `
    -ComputerName $_.Computer ).Win32Shutdown(5)
}