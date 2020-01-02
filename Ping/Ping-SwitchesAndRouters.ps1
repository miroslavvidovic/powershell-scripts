Class NetworkItem {
    [string] $name
    [string] $ip
    [string] $type

    NetworkItem([string]$name,[string]$ip,[string]$type){
        $this.name = $name
        $this.ip = $ip
        $this.type = $type
    }
}

$networkItems =@(
    #Uprava
    [NetworkItem]::new("xu-s stack Router Uprava","10.10.0.1","Router"),
    [NetworkItem]::new("Direktorski sprat","10.10.0.2","Switch"),
    [NetworkItem]::new("Prizemlje nova uprava - komercijala 48","10.10.0.3","Switch"),
    [NetworkItem]::new("Prizemlje nova uprava - komercijala 24","10.10.0.4","Switch"),
    [NetworkItem]::new("II sprat nova uprava - teh. biro 48","10.10.0.5","Switch"),
    [NetworkItem]::new("II sprat nova uprava - teh. biro 24","10.10.0.6","Switch"),
    [NetworkItem]::new("Prizemlje stara uprava","10.10.0.7","Switch"),
    [NetworkItem]::new("I sprat stara uprava - IT","10.10.0.8","Switch"),
    [NetworkItem]::new("I sprat stara uprava - Racunovodstvo","10.10.0.9","Switch"),
    [NetworkItem]::new("Vrtic","10.10.0.10","Switch")
    #Bitovaja
    [NetworkItem]::new("Bitovaja Router","10.10.0.17","Router"),
    [NetworkItem]::new("Bitovaja","10.10.0.18","Switch"),
    [NetworkItem]::new("Prerada rastvora","10.10.0.19","Switch"),
    [NetworkItem]::new("Centralna laboratorija","10.10.0.20","Switch"),
    [NetworkItem]::new("Zeoliti","10.10.0.21","Switch"),
    [NetworkItem]::new("RP1","10.10.0.22","Switch"),
    [NetworkItem]::new("Precipitirani hidrat","10.10.0.23","Switch"),
    [NetworkItem]::new("TEC","10.10.0.24","Switch"),
    [NetworkItem]::new("Silikagel","10.10.0.25","Switch"),
    #Masinska
    [NetworkItem]::new("Masinska Router","10.10.0.33","Router"),
    [NetworkItem]::new("Masinska","10.10.0.34","Switch"),
    [NetworkItem]::new("Transport","10.10.0.35","Switch"),
    [NetworkItem]::new("Pazinka","10.10.0.36","Switch"),
    [NetworkItem]::new("Skladiste","10.10.0.37","Switch"),
    [NetworkItem]::new("Teretna kapija","10.10.0.38","Switch"),
    [NetworkItem]::new("Restoran","10.10.0.39","Switch")
)



function pingItems{
    $separator="-----------------------------------------"

    foreach($item in $networkItems){
        Write-Host $separator
        Write-Host $item.name
        Test-Connection -ComputerName $item.ip -Quiet -Count 1  
    }

    Write-Host $serparator
    Read-Host -Prompt "Press Enter to exit" 
}

pingItems