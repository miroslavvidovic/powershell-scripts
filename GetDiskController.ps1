$dprot = DATA {    
ConvertFrom-StringData -StringData @'               
9 = SCSI Parallel Interface
10 = SCSI Fibre Channel Protocol
11 = SCSI Serial Bus Protocol
42 = Enhanced ATA/IDE
'@
}
function get-diskcontroller {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
 [string]$computername="$env:COMPUTERNAME"
)
PROCESS{
  $ide = $null
  $scsi= $null
  $ide = Get-WmiObject -Class Win32_IDEController `        
  -ComputerName $computername
  $scsi = Get-WmiObject -Class Win32_SCSIController `         
  -ComputerName $computername
  if ($ide){                                             
    "IDE Controllers"
    $ide | select Name, Status, Manufacturer,
     MaxNumberControlled,
     @{Name="Protocol"; Expression={$dprot["$($_.ProtocolSupported)"]}}
  } if ($scsi){                                                
    "SCSI Controllers"
    $scsi | select Name, Status, Manufacturer,
     MaxNumberControlled,
     @{Name="Protocol"; Expression={$dprot["$($_.ProtocolSupported)"]}}
  }
}}

get-diskcontroller