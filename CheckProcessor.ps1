$arch = DATA {ConvertFrom-StringData -StringData @'
0 = x86                                                    
9 = x64
'@}
$fam = DATA {ConvertFrom-StringData -StringData @'
29 = AMD Athlon™ Processor Family
112 = Hobbit Family                                    
131 = AMD Athlon™ 64 Processor Family
132 = AMD Opteron™ Processor Family
'@}
$type = DATA {ConvertFrom-StringData -StringData @'
3 = Central Processor
4 = Math Processor                               
6 = Video Processor
'@}


function get-cputype {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]             
 [string]$computername="$env:COMPUTERNAME"
)
PROCESS {
 Get-WmiObject -Class Win32_Processor `
  -ComputerName $computername |                      
 Select DeviceID,
 @{Name="Processor Type";
 Expression={$type["$($_.ProcessorType)"]}},
 Manufacturer, Name, Description,
 @{Name="CPU Family";
 Expression={$fam["$($_.Family)"]}},
 @{Name="CPU Architecture";
 Expression={$arch["$($_.Architecture)"]}},
 NumberOfCores, NumberOfLogicalProcessors, AddressWidth,
 DataWidth,  CurrentClockSpeed, MaxClockSpeed,
 ExtClock,  L2CacheSize, L2CacheSpeed, L3CacheSize,
 L3CacheSpeed,  CurrentVoltage, PowerManagementSupported,
 ProcessorId, SocketDesignation, Status
}}


get-cputype -computername "127.0.0.1"