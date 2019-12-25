$Begin = Get-Date -Date '14.8.2019 00:00:00'
$End = Get-Date -Date '14.8.2019 17:00:00'

Get-EventLog -LogName System -ComputerName "server2" -EntryType Error -After $Begin -Before $End