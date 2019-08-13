

<#

.SYNOPSIS
This powershell function gets information about the monitors attached to any computer. It uses EDID information provided by WMI. If this value is not specified it pulls the monitors of the computer that the script is being run on.

.DESCRIPTION
The function begins by looping through each computer specified. For each computer it gets a list of monitors.
It then gets all of the necessary data from each monitor object and converts and cleans the data and places it in a custom PSObject. It then adds
the data to an array. At the end the array is displayed.

.PARAMETER ComputerName
Use this to specify the computer(s) which you'd like to retrieve information about monitors from.

.EXAMPLE
PS C:/> Get-Monitor.ps1 -ComputerName MyComputer

Manufacturer Model SerialNumber AttachedComputer
------------ ----- ------------ ---------------
Acer Acer K272HUL T0SfADAFD MyComputer

.EXAMPLE
PS C:/> $Computers = @("Comp1","Comp2","Comp3")
PS C:/> Get-Monitor.ps1 -ComputerName $Computers

Manufacturer Model SerialNumber AttachedComputer
------------ ----- ------------ ----------------

#>

[CmdletBinding()]
PARAM (
[Parameter(ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
[String[]]$ComputerName = $env:ComputerName
)

#List of Manufacture Codes that could be pulled from WMI and their respective full names. Used for translating later down.
$ManufacturerHash = @{
"AAC" = "AcerView";
"ACR" = "Acer";
"ACI" = "Asus";
"APP" = "Apple Computer";
"AUO" = "Asus";
"CMO" = "Acer";
"CPQ" = "Compaq";
"DEL" = "Dell";
"ENC" = "Eizo";
"HWP" = "HP";
"LEN" = "Lenovo";
"SAN" = "Samsung";
"SAM" = "Samsung";
"SNY" = "Sony";
"SRC" = "Shamrock";
"SUN" = "Sun Microsystems";
"SEC" = "Hewlett-Packard";
"TAT" = "Tatung";
"TOS" = "Toshiba";
"TSB" = "Toshiba";
"VSC" = "ViewSonic";
"UNK" = "Unknown";
"_YV" = "Fujitsu";
}


## Hack - remove this later IMPORTANT
$ComputerName = "kjovicic", "zsakotic"
##

#Takes each computer specified and runs the following code:
ForEach ($Computer in $ComputerName) {

#Grabs the Monitor objects from WMI
$Monitors = Get-WmiObject -Namespace "root\WMI" -Class "WMIMonitorID" -ComputerName $Computer -ErrorAction SilentlyContinue

#Creates an empty array to hold the data
$Monitor_Array = @()


#Takes each monitor object found and runs the following code:
ForEach ($Monitor in $Monitors) {

#Grabs respective data and converts it from ASCII encoding and removes any trailing ASCII null values
If ([System.Text.Encoding]::ASCII.GetString($Monitor.UserFriendlyName) -ne $null) {
$Mon_Model = ([System.Text.Encoding]::ASCII.GetString($Monitor.UserFriendlyName)).Replace("$([char]0x0000)","")
} else {
$Mon_Model = $null
}
$Mon_Serial_Number = ([System.Text.Encoding]::ASCII.GetString($Monitor.SerialNumberID)).Replace("$([char]0x0000)","")
$Mon_Attached_Computer = ($Monitor.PSComputerName).Replace("$([char]0x0000)","")
$Mon_Manufacturer = ([System.Text.Encoding]::ASCII.GetString($Monitor.ManufacturerName)).Replace("$([char]0x0000)","")


#Sets a friendly name based on the hash table above. If no entry found sets it to the original 3 character code
$Mon_Manufacturer_Friendly = $ManufacturerHash.$Mon_Manufacturer
If ($Mon_Manufacturer_Friendly -eq $null) {
$Mon_Manufacturer_Friendly = $Mon_Manufacturer
}

#Creates a custom monitor object and fills it with 4 NoteProperty members and the respective data
$Monitor_Obj = [PSCustomObject]@{
Manufacturer = $Mon_Manufacturer_Friendly
Model = $Mon_Model
SerialNumber = $Mon_Serial_Number
AttachedComputer = $Mon_Attached_Computer
}

#Appends the object to the array
$Monitor_Array += $Monitor_Obj

} #End ForEach Monitor

#Outputs the Array
$Monitor_Array

} #End ForEach Computer
