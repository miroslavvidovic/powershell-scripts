$computer = "i9maksimovic"

if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {
Get-WmiObject -Class Win32_Service -Filter "Name LIKE 'win%'" |
select Name, State
}
else {Write-Host "Cannot connect to $computer"}