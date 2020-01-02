$sku = DATA {
    ConvertFrom-StringData -StringData @'
1 = Ultimate Edition
8 = Datacenter Server Edition
'@
}
$lang = DATA {
    ConvertFrom-StringData -StringData @'
1033 = English US
2057 = English UK
'@
}
$code = DATA {
    ConvertFrom-StringData -StringData @'
1252 = Latin I
'@
}
$fboost = DATA {
    ConvertFrom-StringData -StringData @'
0 = None
1 = Minimum
2 = (Default) Maximum
'@
}
function get-operatingsystem {
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string]$computername = "$env:COMPUTERNAME"
    )
    PROCESS {
        Get-WmiObject -Class Win32_OperatingSystem `
            -ComputerName $computername |
        select CSName, Caption,
        @{Name         = "Operating System SKU";
            Expression = { $sku["$($_.OperatingSystemSKU)"] }
        },
        SerialNumber, ServicePackMajorVersion,
        ServicePackMinorVersion, BuildNumber, Version,
        OSArchitecture, SystemDevice, SystemDrive,
        WindowsDirectory, SystemDirectory,
        @{Name         = "OS Language";
            Expression = { $lang["$($_.OSLanguage)"] }
        },
        @{Name         = "OS Type";
            Expression = { $os["$($_.OSType)"] }
        },
        @{Name         = "Code Set";
            Expression = { $code["$($_.CodeSet)"] }
        },
        @{Name         = "Country Code";
            Expression = { $country["$($_.CountryCode)"] }
        },
        EncryptionLevel,
        @{Name         = "Foreground Application Boost";
            Expression = { $fboost["$($_.ForegroundApplicationBoost)"] }
        },
        DataExecutionPrevention_32BitApplications,
        DataExecutionPrevention_Available,
        DataExecutionPrevention_Drivers,
        @{Name         = "Data Execution Prevention Support Policy";
            Expression = { $depsupport["$($_.DataExecutionPrevention_SupportPolicy)"] }
        },
        @{Name         = "Installation Date";
            Expression = { $_.ConvertToDateTime($_.InstallDate) }
        },
        @{Name         = "Last Bootup time";
            Expression = { $_.ConvertToDateTime($_.LastBootUpTime) }
        },
        @{Name         = "Local Date Time";
            Expression = { $_.ConvertToDateTime($_.LocalDateTime) }
        },
        @{Name         = "Offset from GMT";
            Expression = { "$($_.CurrentTimeZone) minutes" }
        },
        @{Name = "Locale "; Expression = { $loc["$($_.Locale)"] } },
        MaxNumberOfProcesses,
        @{Name         = "Max Process Memory Size (GB)";
            Expression = { "{0:F3}" -f $($_.MaxProcessMemorySize * 1kb / 1GB) }
        },
        PAEEnabled,
        @{Name         = "Free Physical Memory (GB)";
            Expression = { "{0:F3}" -f $($_.FreePhysicalMemory / 1GB * 1kb) }
        },
        @{Name         = "Size Stored In Paging Files (GB)";
            Expression = { "{0:F3}" -f $($_.SizeStoredInPagingFiles * 1kb / 1GB) }
        },
        @{Name         = "Free Space In Paging Files (GB)";
            Expression = { "{0:F3}" -f $($_.FreeSpaceInPagingFiles * 1kb / 1GB) }
        },
        @{Name         = "Total Visible Memory Size (GB)";
            Expression = { "{0:F3}" -f $($_.TotalVisibleMemorySize * 1kb / 1GB) }
        },
        @{Name         = "Total Virtual Memory Size (GB)";
            Expression = { "{0:F3}" -f $($_.TotalVirtualMemorySize * 1kb / 1GB) }
        },
        @{Name         = "Free Virtual Memory (GB)";
            Expression = { "{0:F3}" -f $($_.FreeVirtualMemory * 1kb / 1GB) }
        }
    }
}


get-operatingsystem "127.0.0.1"