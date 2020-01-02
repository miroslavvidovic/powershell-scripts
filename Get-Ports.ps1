function get-port {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
 [string]$computername="$env:COMPUTERNAME"
)
PROCESS {
"Parallel Port"
Get-WmiObject -Class Win32_ParallelPort `
  -ComputerName $computername |
select Name, OSAutoDiscovered, PNPDeviceID
"Serial Port"
Get-WmiObject -Class Win32_SerialPort `
  -ComputerName $computername |
select Name, OSAutoDiscovered,
PNPDeviceID, ProviderType, MaxBaudRate
 "USBHub"
 Get-WmiObject -Class Win32_USBHub `
  -ComputerName $computername | select Name, PNPDeviceID
 ""
 "USB Controller"
 Get-WmiObject -Class Win32_USBController `
  -ComputerName $computername | Select Name, PNPDeviceID
}}

get-port "127.0.0.1"