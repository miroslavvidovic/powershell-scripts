$status = DATA {ConvertFrom-StringData -StringData @'
1 = Discharging
2 = On AC. No battery discharge. Not necessarily charging.
6 = Charging
'@}
$chem = DATA {ConvertFrom-StringData -StringData @'
6 = Lithium-ion
'@}
function get-battery {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
 [string]$computername="$env:COMPUTERNAME"
)
PROCESS {
 Get-WmiObject -Class Win32_Battery  `
  -ComputerName $computername |
 select DeviceID, Name, Description,
 @{Name="Status";
  Expression={$status["$($_.BatteryStatus)"]}},
  @{Name="Chemistry";
  Expression={$chem["$($_.Chemistry)"]}},
 @{Name="Voltage(V)";
  Expression={$($_.DesignVoltage / 1000)}},
 @{Name="PecentChargeLeft";
  Expression={$($_.EstimatedChargeRemaining)}},
 PowerManagementSupport
}}

get-battery "vmaksimovic"