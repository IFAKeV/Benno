param(
    [string]$DriveLetter = "C",
    [int]$ThresholdGB = 10,
    [string]$SmtpServer = "smtp",
    [string]$SmtpFrom = "@",
    [string]$SmtpTo = "@",
    [string]$SmtpUser = "@",
    [string]$PasswordFile = "C:\Path\To\EncryptedPassword.txt",
    [string]$ErrorLogPath = "C:\Path\To\ErrorLog.txt"
)

$drivesToMonitor = @("C", "D", "E")
foreach ($drive in $drivesToMonitor) {
    CheckDriveSpace -DriveLetter $drive
}

function Get-DriveSpace($driveLetter) {
    $drive = Get-PSDrive -Name $driveLetter
    $freeSpaceGB = [math]::round($drive.Free / 1GB, 2)
    $totalSpaceGB = [math]::round(($drive.Used + $drive.Free) / 1GB, 2)
    return @{Free = $freeSpaceGB; Total = $totalSpaceGB}
}

function Send-LowSpaceAlert($driveInfo, $computerName, $serialNumber) {
    # E-Mail-Versand-Logik hier
}

if (-not (Test-Path $PasswordFile)) {
    throw "Password file not found: $PasswordFile"
}

function Write-Log {
    param($message, $logPath)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $message" | Out-File -Append -FilePath $logPath
}

$config = Get-Content "C:\Path\To\Config.json" | ConvertFrom-Json
$smtpServer = $config.SmtpServer
# ... andere Konfigurationsdetails

$thresholdPercent = 10
if (($freeSpaceGB / $totalSpaceGB) * 100 -lt $thresholdPercent) {
    # Warnungslogik hier
}

$lastAlertFile = "C:\Path\To\LastAlert.txt"
if (Test-Path $lastAlertFile) {
    $lastAlert = Get-Content $lastAlertFile | Get-Date
    if ((Get-Date) - $lastAlert -lt (New-TimeSpan -Hours 24)) {
        return # Keine weitere Warnung innerhalb von 24 Stunden
    }
}
Get-Date | Out-File $lastAlertFile

$smtpSubject = "Warnung: Weniger als {0} GB auf Laufwerk {1}: auf {2}" -f $threshold, $DriveLetter, $computerName

param(
    [switch]$TestMode
)
if ($TestMode) {
    # Simulieren Sie niedrigen Speicherplatz und E-Mail-Versand
}
