function test-powersource {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
 [string]$computername="$env:COMPUTERNAME"
 )
PROCESS {
 $status = Get-WmiObject -Namespace 'root\wmi' -Class BatteryStatus `
  -ComputerName $computername
 if ($status.PowerOnLine) {"System on External Power"}
 else {"System on Battery Power"}
}}


test-powersource "stomic"