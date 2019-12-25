function get-diskdrive {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
 [string]$computername="$env:COMPUTERNAME"
)
PROCESS{
  Get-WmiObject -Class Win32_DiskDrive `
  -ComputerName $computername |
  select DeviceID, InterfaceType,
  Manufacturer, Model, FirmwareRevision,
  SerialNumber, Signature,
  StatusInfo, Partitions,
  TotalHeads, BytesPerSector, TotalSectors,
  SectorsPerTrack, TotalTracks, TracksPerCylinder,
  TotalCylinders,
  @{Name="Disk Size (GB)";
   Expression={"{0:F3}" -f $($_.Size/1GB)}},             
  SCSIBus, SCSILogicalUnit, SCSIPort, SCSITargetId
  "Capabilities:"                                     
  Get-WmiObject -Class Win32_DiskDrive `
  -ComputerName $computername |
  select  -ExpandProperty CapabilityDescriptions
}}


function get-drivetopartition {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
[string]$computername="$env:COMPUTERNAME"
)
PROCESS{  
  Get-WmiObject -Class Win32_DiskDrive -ComputerName $computername |
  foreach {
   $_.DeviceId
   $inxid = ($_.DeviceID).Replace("\","\\")
   $query = "ASSOCIATORS OF {Win32_DiskDrive.DeviceID=""$inxid""}
        ➥  WHERE RESULTCLASS = Win32_DiskPartition"
   Get-WmiObject -ComputerName $computername -Query $query
  }
}}


get-drivetopartition