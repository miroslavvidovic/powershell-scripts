$ping = New-Object System.Net.Networkinformation.Ping
1..254 | % { $ping.send("192.168.26.$_") }