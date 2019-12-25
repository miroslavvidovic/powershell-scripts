
$ArrComputers =  "selekovic"

Clear-Host
foreach ($Computer in $ArrComputers) 
{
    $System = get-wmiobject Win32_ComputerSystem -Computer $Computer
    $computerName = $System.DNSHostName
    $computerManufacturer = $System.Manufacturer
    $computerModel = $System.Model
    $OS = get-wmiobject Win32_OperatingSystem -Computer $Computer
    $computerOS = $OS.caption
    $computerCPU = get-wmiobject Win32_Processor -Computer $Computer
    $cpuName = $computerCPU.Name
    $motherboard = Get-WmiObject Win32_BaseBoard -Computer $Computer -ea STOP
    $computerMotherboard = $motherboard.Manufacturer + " " + $motherboard.Product
    $computerMonitor = Get-WmiObject Win32_DesktopMonitor -Computer $Computer
    $computerGraphics = Get-WmiObject Win32_VideoController -Computer $Computer
    $computerHDD = Get-WmiObject Win32_LogicalDisk -ComputerName $Computer -Filter drivetype=3
    $PhysicalRAM = (Get-WMIObject -class Win32_PhysicalMemory -ComputerName $Computer |
Measure-Object -Property capacity -Sum | % {[Math]::Round(($_.sum / 1GB),2)})

    


        "-------------------------------------------------------"
        $computerManufacturer
        $computerModel
        $cpuName
        $computerHDD.Size
        $computerMotherboard
        $computerGraphics.Name
        $PhysicalRAM
        $computerOS
        $computerSystem.DNSHostname
        "-------------------------------------------------------"
}