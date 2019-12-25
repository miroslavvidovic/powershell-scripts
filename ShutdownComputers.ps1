Import-Csv computers.csv |
foreach {
 (Get-WmiObject -Class Win32_OperatingSystem  `
   -ComputerName $_.Computer ).Win32Shutdown(5)
}