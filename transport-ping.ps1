function pingTransport{
    $transportComputers="radivanovic", "dilic", "givanovic"

    $separator="-----------------------------------------"

    foreach($computer in $transportComputers){
        Write-Host $separator
        Write-Host $computer
        Test-Connection -ComputerName $computer -Quiet -Count 1  
    }

    Write-Host $serparator
    Read-Host -Prompt "Press Enter to exit" 
}

pingTransport