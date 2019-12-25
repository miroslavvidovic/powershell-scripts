$fmask = DATA {
ConvertFrom-StringData -StringData @'
4 = Grants the right to append data to the file.For a directory, this value grants the right to create a subdirectory.
8 = Grants the right to read extended attributes.
65536 = Grants delete access.
524288 = Assigns the write owner.
'@
}
function get-foldermask {
[CmdletBinding()]
param (
 [parameter(ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
 [string]$computername="$env:COMPUTERNAME",
 [string]$path
)
PROCESS{
$path = $path.Replace("\","\\")
$sd = Get-WmiObject -Class Win32_LogicalFileSecuritySetting `
 -ComputerName $computername -Filter "Path='$path'" |
 Invoke-WmiMethod -Name GetSecurityDescriptor
 "Owner "
 $sd.Descriptor.Owner | Format-Table Domain, Name -AutoSize
 $sd.Descriptor.DACL | foreach {
  "`n$($_.Trustee.Domain)/$($_.Trustee.Name)"
  $accessmask = $_.AccessMask
   $fmask.GetEnumerator()| sort Key |
   foreach {
    if ($accessmask -band $_.key){
     "$($fmask[$($_.key)])"
    }
   }
 }
}}


get-foldermask -path "E:\Publicfolders\Sekretarijat" -computername "publicserver"