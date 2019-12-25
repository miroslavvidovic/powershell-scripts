function get-registrysize {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
 [string]$computername="$env:COMPUTERNAME"
)
PROCESS {
Get-WmiObject -Class Win32_Registry -ComputerName $computername |
Select CurrentSize, ProposedSize, MaximumSize, Status,
@{Name="InstallationDate";Expression={$_.ConvertToDateTime($_.InstallDate)}}
}
}

get-registrysize