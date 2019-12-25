function new-regkey {
[CmdletBinding()]
param (
 [parameter(Mandatory=$true)]
 [string]
 [Validateset("HKCR", "HKCU", "HKLM", "HKUS", "HKCC")]
  $hive,
 [parameter(Mandatory=$true)]
 [string]$key,
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)][string]$computername="$env:COMPUTERNAME"
)
PROCESS {
$rh = set-HiveValue $hive
$reg = [wmiclass]"\\$computername\root\default:StdRegprov"
$reg.CreateKey($rh, $key)
}}

new-regkey -hive HKLM -key "SOFTWARE\PAW"