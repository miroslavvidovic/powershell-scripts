$chassis = DATA {ConvertFrom-StringData -StringData @'       
3 = Desktop
5 = Pizza Box
7 = Tower
10 = Notebook
'@}
$obd = DATA {ConvertFrom-StringData -StringData @'     
3 = Video
5 = Ethernet
'@}

function get-computersystem {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
 [string]$computername="$env:COMPUTERNAME"
)
PROCESS {
  "Computer System"
  Get-WmiObject -Class Win32_ComputerSystem `                 
  -ComputerName $computername|
  select Name, Manufacturer, Model,
  SystemType, Description,
  NumberOfProcessors, NumberOfLogicalProcessors,
  @{Name="RAM(GB)";
  Expression={[math]::round($($_.TotalPhysicalMemory/1GB), 2)}}
 "System Enclosure:"
 Get-WmiObject -Class Win32_SystemEnclosure `                   
 -ComputerName $computername |
 select Manufacturer, Model,
 @{Name="Chassis"; Expression={$chassis["$($_.ChassisTypes)"]}},
 LockPresent,SerialNumber, SMBIOSAssetTag
 "Base Board:"
 Get-WmiObject -Class Win32_BaseBoard `                    
 -ComputerName $computername |
 select Manufacturer, Model, Name,
 SerialNumber, SKU, Product,
 Replaceable, Version
 "On Board Devices:"
 Get-WmiObject -Class Win32_OnBoardDevice `                     
 -ComputerName $computername |
 select Description,
 @{Name="Device";
 Expression={$obd["$($_.DeviceType)"]}}
}}

".", "127.0.0.1" | foreach {get-computersystem}