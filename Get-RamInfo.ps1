function get-ram {
[CmdletBinding()]
param (
 [parameter(Mandatory=$true)]
 [string]$computername
)
 Get-WmiObject -Class Win32_ComputerSystem -ComputerName $computername |
 Select Name, @{Name="RAM"; Expression={$([math]::round(($_.TotalPhysicalMemory / 1gb),2))}}
}

get-ram "nelekovic"