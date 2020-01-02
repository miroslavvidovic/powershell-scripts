function Get-InputDevices {
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string]$computername = "$env:COMPUTERNAME"
    )
    PROCESS {
        "Keyboard"
        Get-WmiObject -Class Win32_Keyboard `
            -ComputerName $computername |
        Select-Object Name, Description, DeviceId,
        Layout, NumberOfFunctionKeys
        "Mouse"
        Get-WmiObject Win32_PointingDevice `
            -ComputerName $computername |
        Select-Object Manufacturer, Name, DeviceID,
        DeviceInterface
    }
}

Get-InputDevices "127.0.0.1"