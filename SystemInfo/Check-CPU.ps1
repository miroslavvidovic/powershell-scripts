<#
.SYNOPSIS
    Get CPU info
.EXAMPLE
    Get-CpuTyp -computername "127.0.0.1"

    DeviceID                  : CPU0
    Processor Type            : Central Processor
    Manufacturer              : GenuineIntel
    Name                      : Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz
    Description               : Intel64 Family 6 Model 158 Stepping 9
    CPU Family                : 
    CPU Architecture          : x64
    NumberOfCores             : 4
    NumberOfLogicalProcessors : 8
    AddressWidth              : 64
    DataWidth                 : 64
    CurrentClockSpeed         : 2801
    MaxClockSpeed             : 2801
    ExtClock                  : 100
    L2CacheSize               : 1024
    L2CacheSpeed              : 
    L3CacheSize               : 6144
    L3CacheSpeed              : 0
    CurrentVoltage            : 9
    PowerManagementSupported  : False
    ProcessorId               : BFEBFBFF000906E9
    SocketDesignation         : U3E1
    Status                    : OK
.NOTES
    Author: Miroslav Vidovic - miroslav-vidovic@hotmail.com
    Tested on: Powershell 5.1
#>
$arch = DATA {
    ConvertFrom-StringData -StringData @'
0 = x86                                                    
9 = x64
'@
}
$fam = DATA {
    ConvertFrom-StringData -StringData @'
29 = AMD Athlon™ Processor Family
112 = Hobbit Family                                    
131 = AMD Athlon™ 64 Processor Family
132 = AMD Opteron™ Processor Family
'@
}
$type = DATA {
    ConvertFrom-StringData -StringData @'
3 = Central Processor
4 = Math Processor                               
6 = Video Processor
'@
}

function Get-CpuType {
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]             
        [string]$computername = "$env:COMPUTERNAME"
    )
    process {
        Get-WmiObject -Class Win32_Processor `
            -ComputerName $computername |                      
        Select-Object DeviceID,
        @{Name         = "Processor Type";
            Expression = { $type["$($_.ProcessorType)"] }
        },
        Manufacturer, Name, Description,
        @{Name         = "CPU Family";
            Expression = { $fam["$($_.Family)"] }
        },
        @{Name         = "CPU Architecture";
            Expression = { $arch["$($_.Architecture)"] }
        },
        NumberOfCores, NumberOfLogicalProcessors, AddressWidth,
        DataWidth, CurrentClockSpeed, MaxClockSpeed,
        ExtClock, L2CacheSize, L2CacheSpeed, L3CacheSize,
        L3CacheSpeed, CurrentVoltage, PowerManagementSupported,
        ProcessorId, SocketDesignation, Status
    }
}

Get-CpuType -computername "127.0.0.1"
