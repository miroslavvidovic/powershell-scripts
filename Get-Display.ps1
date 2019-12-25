function get-display {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
 [string]$computername="$env:COMPUTERNAME"
)
PROCESS{
 "Monitor"
 Get-WmiObject -Class Win32_DesktopMonitor `
 -ComputerName $computername |
 select Name, Description, DeviceId,
 MonitorManufacturer, MonitorType,
 PixelsPerXLogicalInch,
 PixelsPerYLogicalInch,
 ScreenHeight, ScreenWidth
  "Video"
 Get-WmiObject -Class Win32_VideoController `
 -ComputerName $computername |
 select Name,
 @{Name="RAM(MB)"; Expression={$_.AdapterRAM/1mb}},
 VideoModeDescription,
 CurrentRefreshRate,
 InstalledDisplayDrivers,
 @{Name="DriverDate";
 Expression={$_.ConvertToDateTime($_.DriverDate)}},
 DriverVersion
}}

 
get-display "aprodanovic"