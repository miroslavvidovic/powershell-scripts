$memuse = DATA {ConvertFrom-StringData -StringData @'           
3 = System memory
'@}
$memcheck = DATA {ConvertFrom-StringData -StringData @'   
3 = None
4 = Parity
'@}
$memform = DATA {ConvertFrom-StringData -StringData @'    
7 = SIMM
8 = DIMM
'@}
$memtype = DATA {ConvertFrom-StringData -StringData @'    
2 = DRAM
20 = DDR
21 = DDR-2
'@}
function get-memory {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
 [string]$computername="$env:COMPUTERNAME"
)
PROCESS{
 Get-WmiObject -Class Win32_PhysicalmemoryArray ` 
  -ComputerName $computername |
 Select @{Name="Location"; Expression={
  if ($_.Location -eq 3){"System Board"}
  else {"Other"}
 } },
 @{Name="Use";
 Expression={$memuse["$($_.Use)"]}},
 MemoryDevices, HotSwappable,
 @{Name="MaxRAM(GB)";
 Expression={[math]::round($($_.MaxCapacity/1mB), 2)}},
 @{Name="CheckType";
 Expression={$memcheck["$($_.MemoryErrorCorrection)"]}}
""
 Get-WmiObject Win32_Physicalmemory  -ComputerName $computername  |                             
 select BankLabel,
 @{Name="Size(GB)";
 Expression={[math]::round($($_.Capacity/1gb), 2)}},
 DataWidth, DeviceLocator,
 @{Name="Form";
 Expression={$memform["$($_.FormFactor)"]}},
 @{Name="Type";
 Expression={$memtype["$($_.MemoryType)"]}},
 Speed, TotalWidth,
 @{Name="Detail";
 Expression={$memdetail["$($_.TypeDetail)"]}}
}}

# get-memory "dstojanovic"
get-memory