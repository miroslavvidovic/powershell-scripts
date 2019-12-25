$dtype = DATA {ConvertFrom-StringData -StringData @'          
3 = Local Disk
4 = Network Drive
'@}
$media = DATA {ConvertFrom-StringData -StringData @'    
11 = Removable media other than floppy
12 = Fixed hard disk media
'@}
function get-logicaldisk {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
[string]$computername="$env:COMPUTERNAME"
)
PROCESS{
 Get-WmiObject -Class Win32_LogicalDisk `                 
 -ComputerName $computername |
 select DeviceID, Compressed, Description,
  @{Name="Drive Type"; 
    Expression={$dtype["$($_.DriveType)"]}},              
 @{Name="Media Type"; 
    Expression={$media["$($_.MediaType)"]}},   
 FileSystem,
 @{Name="Disk Size (GB)";
    Expression={"{0:F3}" -f $($_.Size/1GB)}},                
 @{Name="Free Space (GB)";
    Expression={"{0:F3}" -f $($_.FreeSpace/1GB)}},       
 SupportsDiskQuotas, SupportsFileBasedCompression,
 VolumeName, VolumeSerialNumber
}}

get-logicaldisk