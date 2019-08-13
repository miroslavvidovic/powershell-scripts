#
# Provjera koliko je slobodnog prostora na C disku kod navedenih računara
#

"mvidovic", "aprodanovic", "dbojic", "publicserver","server2" | foreach {
Get-WmiObject -Class Win32_LogicalDisk `
-ComputerName $_ -Filter "DeviceId='C:'" } |
Format-Table SystemName, @{Name="Free"; 
Expression={[math]::round($($_.FreeSpace/1GB), 2)}} -auto