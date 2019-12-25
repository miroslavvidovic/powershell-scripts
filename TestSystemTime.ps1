function test-systemtime {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
 [string]$computername="$env:COMPUTERNAME"
)
PROCESS {
 $now = Get-WmiObject -Class Win32_LocalTime `
 -ComputerName $computername
 $now2 = Get-WmiObject -Class Win32_UTCTime `
 -ComputerName $computername
 $local = Get-Date -Year $($now.Year) -Month $($now.Month) `
        -Day $($now.Day) -Hour $($now.Hour) `
        -Minute $($now.Minute) -Second $($now.Second)
 $utc = Get-Date -Year $($now2.Year) -Month $($now2.Month) `
        -Day $($now2.Day) -Hour $($now2.Hour) `
        -Minute $($now2.Minute) -Second $($now2.Second)
 $tz =  Get-WmiObject -Class Win32_TimeZone `
        -ComputerName $computername
$daylton = Get-Date -Month $tz.daylightmonth -Day $tz.daylightday `
           -Hour $tz.daylighthour -Minute $tz.daylightminute `
                      -Second $tz.daylightsecond
$stndon = Get-Date -Month $tz.standardmonth -Day $tz.standardday `
          -Hour $tz.standardhour -Minute $tz.standardminute `
           -Second $tz.standardsecond
if (($local -ge $daylton) -and ($local -le $stndon)){
  $timename = $tz.DaylightName
}
else {$timename = $tz.StandardName}
 "Server      : $($now.__SERVER)"
 "Time Zone   : $($tz.Description)"
 "Time Setting: $timename"
 "Local Time  : $local"
 "UTC   Time  : $utc"
}}

test-systemtime "server2"