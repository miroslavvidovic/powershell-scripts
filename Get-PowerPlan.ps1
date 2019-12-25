function get-powerplan {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
 ValueFromPipelineByPropertyName=$true)]
 [string]$computername="$env:COMPUTERNAME"
)
PROCESS {
 Get-WmiObject -Namespace 'root\cimv2\power' `               
  -Class Win32_PowerPlan -ComputerName $computername |
 sort IsActive -Descending |
 Format-List ElementName, Description, InstanceID, IsActive
"'nActive Plan Details"
$plan = Get-WmiObject -namespace 'root\cimv2\power' `
-Class Win32_PowerPlan -ComputerName $computername |
 where {$_.IsActive}                                           
$id = ($plan.InstanceID).Replace("\","\\")
$query = "ASSOCIATORS OF {Win32_PowerPlan.InstanceID=""$id}""}"
$psIndexes = Get-WmiObject -ComputerName $computername `
-namespace 'root\cimv2\power' -Query $query              
"Battery Power"
foreach ($psIndex in ($psIndexes | where {$_.InstanceID -like "*DC*"})){
 $inxid = ($psIndex.InstanceId).Replace("\","\\")
 $query = "ASSOCIATORS OF                                
    ➥  {Win32_PowerSettingDataIndex.InstanceID=""$inxid}""}
    ➥  WHERE RESULTCLASS = Win32_PowerSetting "
 Get-WmiObject -ComputerName $computername `
 -namespace 'root\cimv2\power' -Query $query |                 
 Add-Member -MemberType Noteproperty -Name "SettingIndexValue"`
 -Value $($psIndex.SettingIndexValue) -PassThru |
 Format-List InstanceId, Description, SettingIndexValue
}
"External Power"                                     
foreach ($psIndex in ($psIndexes | where {$_.InstanceID -like "*AC*"}) ) {
 $inxid = ($psIndex.InstanceId).Replace("\","\\")
 $query = "ASSOCIATORS OF                                     
   ➥  {Win32_PowerSettingDataIndex.InstanceID=""$inxid}""}
   ➥  WHERE RESULTCLASS = Win32_PowerSetting "
 Get-WmiObject -ComputerName $computername `
 -namespace 'root\cimv2\power' -Query $query |
 Add-Member -MemberType Noteproperty `
-Name "SettingIndexValue" `                                    
 -Value $($psIndex.SettingIndexValue) -PassThru|
 Format-List InstanceId, Description, SettingIndexValue
}
}}

get-powerplan