$computers = @("localhost", "aprodanovic", "dbojic")

Get-WmiObject -Class Win32_Service -Filter "Name='winrm'" `
 -ComputerName $computers | ft SystemName, State, StartMode