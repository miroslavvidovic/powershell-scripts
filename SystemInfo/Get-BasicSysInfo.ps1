<#
.SYNOPSIS
    System info
.DESCRIPTION
    Display basic system information for multiple computer.
.NOTES
    Author: Miroslav Vidovic - miroslav-vidovic@hotmail.com
    Tested on: Powershell 5.1
.NOTES
    Script expects a comptuers.csv file in the following format:
    where the first row is the header
    Computer
    W08R2CS01
    W08R2CS02
    W08R2SQL08
    W08R2SQL08A
    WSS08
    DC02
#>

Import-Csv computers.csv |
foreach {
    $system = "" |
    Select-Object Name, Make, Model, CPUs, Cores,
    LogProc, Speed, Memory, Windows, SP

    $server = Get-WmiObject -Class Win32_ComputerSystem `
    -ComputerName $_.Computer

    $system.Name = $server.Name
    $system.Make = $server.Manufacturer
    $system.Model = $server.Model
    $system.Memory = $server.TotalPhysicalMemory
    $system.CPUs = $server.NumberOfProcessors
    $cpu = Get-WmiObject -Class Win32_Processor `
    -ComputerName $_.Computer | select -First 1
    $system.Speed = $cpu.MaxClockSpeed
    $os = Get-WmiObject -Class Win32_OperatingSystem `
    -ComputerName $_.Computer
    $system.Windows = $os.Caption
    $system.SP = $os.ServicePackMajorVersion
    if (($os.Version -split "\.")[0] -ge 6) {
        $system.Cores = $cpu.NumberOfCores
        $system.LogProc = $cpu.NumberOfLogicalProcessors
    } else {
        $system.CPUs = ""
        $system.Cores = $server.NumberOfProcessors
    }
    $system
} |
Format-Table -AutoSize -Wrap