$comptype = DATA {
ConvertFrom-StringData -StringData @'
0 =  Unspecified
1 =  Desktop
2 =  Mobile
3 =  Workstation
4 =  Enterprise Server
5 =  Small Office and Home Office (SOHO) Server
6 =  Appliance PC
7 =  Performance Server
8 =  Maximum
'@
}


function Get-ComputerType {
    [CmdletBinding()]
  param (
  [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
 [string]$computername="$env:COMPUTERNAME"
)
PROCESS {
  Get-WmiObject -Class Win32_ComputerSystem `
  -ComputerName $computername |
  select Name,
  @{Name="ComputerType"; Expression={$comptype["$($_.PCSystemType)"]}}
}}

get-computertype "vmarkanovic"