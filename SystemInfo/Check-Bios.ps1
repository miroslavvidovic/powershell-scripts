<#
.SYNOPSIS
    Check the BIOS information.
.DESCRIPTION
    Display detailed bios information.
.EXAMPLE
    Get-BiosInfo -computername "127.0.0.1"
    
    BuildNumber          : 
    CurrentLanguage      : en|US|iso8859-1,0
    InstallableLanguages : 8
    Manufacturer         : LENOVO
    Name                 : 4KCN40WW
    PrimaryBIOS          : True
    Release Date         : 17.10.2017. 02:00:00
    SerialNumber         : PF10C7QW
    SMBIOSBIOSVersion    : 4KCN40WW
    SMBIOSMajorVersion   : 3
    SMBIOSMinorVersion   : 0
    SMBIOSPresent        : True
    Status               : OK
    Version              : LENOVO - 1

    BIOS Characteristics:
    PCI is supported
    BIOS is Upgradable (Flash)
    Boot from CD is supported
    USB Legacy is supporte
.NOTES
    Author: Miroslav Vidovic - miroslav-vidovic@hotmail.com
    Tested on: Powershell 5.1
#>

$bioschar = DATA {ConvertFrom-StringData -StringData @'       
7 = PCI is supported
8 = PC Card (PCMCIA) is supported
9 = Plug and Play is supported
11 = BIOS is Upgradable (Flash)
15 = Boot from CD is supported
33 = USB Legacy is supported
'@}

function Get-BiosInfo {                               
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline=$true,
                ValueFromPipelineByPropertyName=$true)]
        [string]$computername="$env:COMPUTERNAME"
    )
    process {
        Get-WmiObject -Class Win32_Bios `
        -ComputerName $computername |                                  
        Select-Object  BuildNumber, CurrentLanguage, InstallableLanguages, 
        Manufacturer, Name, PrimaryBIOS,
        @{Name="Release Date";
        Expression={ $_.ConvertToDateTime( $_.ReleaseDate) }}, SerialNumber, SMBIOSBIOSVersion, 
        SMBIOSMajorVersion, SMBIOSMinorVersion, SMBIOSPresent, Status, Version
        "BIOS Characteristics:"                                    
        Get-WmiObject -Class Win32_Bios -ComputerName $computername |
        Select-Object -ExpandProperty BiosCharacteristics |
        foreach {$bioschar["$($_)"]}
    }
}

Get-BiosInfo
