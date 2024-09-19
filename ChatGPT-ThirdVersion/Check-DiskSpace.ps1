param(
    [string]$DriveLetter = "C",
    [int]$ThresholdGB = 10
)

$drive = Get-PSDrive -Name $DriveLetter
$freeSpaceGB = [math]::Round($drive.Free / 1GB, 2)

if ($freeSpaceGB -lt $ThresholdGB) {
    $eventMessage = "Warnung: Laufwerk $DriveLetter hat nur noch $freeSpaceGB GB freien Speicherplatz."
    Write-EventLog -LogName "Application" -Source "DiskSpaceMonitor" -EventId 1000 -EntryType Warning -Message $eventMessage
}
