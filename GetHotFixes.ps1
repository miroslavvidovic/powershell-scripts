function get-hf {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
 [string]$computername="$env:COMPUTERNAME"
)
PROCESS {
if ($psversiontable.PSversion.Major -qe 2) {
 $fixes = Get-HotFix -ComputerName $computername }
 else {
  $fixes = Get-WmiObject -Class Win32_QuickFixEngineering `
    -ComputerName $computername
 }
 $fixes | select CSName, HotFixID, Caption,
 Description, InstalledOn, InstalledBy
}}