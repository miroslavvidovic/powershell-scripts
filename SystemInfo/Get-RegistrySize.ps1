function Get-RegistrySize {
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string]$computername = "$env:COMPUTERNAME"
    )
    process {
        Get-WmiObject -Class Win32_Registry -ComputerName $computername |
        Select-Object CurrentSize, ProposedSize, MaximumSize, Status,
        @{Name = "InstallationDate"; Expression = { $_.ConvertToDateTime($_.InstallDate) } }
    }
}

Get-RegistrySize
