﻿function get-disk {
param (
  [string]$computername = "$env:COMPUTERNAME"
)
  Get-WmiObject -Class Win32_DiskDrive -ComputerName $computername |
  Format-List DeviceID, Status,
  Index, InterfaceType,
  Partitions, BytesPerSector, SectorsPerTrack, TracksPerCylinder,
  TotalHeads, TotalCylinders, TotalTracks, TotalSectors,
  @{Name="Disk Size (GB)"; Expression={"{0:F3}" -f $($_.Size/1GB)}}
}

get-disk "imaksimovic"