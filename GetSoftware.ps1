function get-software {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
 [string]$computername="$env:COMPUTERNAME"
)
PROCESS {
"Installed Software"
 Get-WmiObject -Class Win32_Product `
 -ComputerName $computername |
 select Name, IdentifyingNumber,
 InstallLocation, Vendor, Version
"Installed COM Applications"
 Get-WmiObject -Class Win32_COMApplication `
 -ComputerName $computername |
select Name, AppID
}}

#get-software "aprodanovic"

get-software "aprodanovic" | out-file c:\reports\software-aprodanovic.txt