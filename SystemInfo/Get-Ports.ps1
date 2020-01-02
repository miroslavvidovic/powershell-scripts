function Get-Port {
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string]$computername = "$env:COMPUTERNAME"
    )
    process {
        "Parallel Port"
        Get-WmiObject -Class Win32_ParallelPort `
            -ComputerName $computername |
        Select-Object Name, OSAutoDiscovered, PNPDeviceID
        "Serial Port"
        Get-WmiObject -Class Win32_SerialPort `
            -ComputerName $computername |
        Select-Object Name, OSAutoDiscovered,
        PNPDeviceID, ProviderType, MaxBaudRate
        "USBHub"
        Get-WmiObject -Class Win32_USBHub `
            -ComputerName $computername | Select-Object Name, PNPDeviceID
        ""
        "USB Controller"
        Get-WmiObject -Class Win32_USBController `
            -ComputerName $computername | Select-Object Name, PNPDeviceID
    }
}

Get-Port "127.0.0.1"
