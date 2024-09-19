# SMTP-Einstellungen
$smtpServer = "smtp.ionos.de"
$smtpFrom = "raifi@ifak-bochum.de"
$smtpTo = "edv@ifak-bochum.de"
$smtpUser = "raifi@ifak-bochum.de"

# Sicheres Laden des Passworts aus einer verschlüsselten Datei
$securePassword = Get-Content "C:\Path\To\EncryptedPassword.txt" | ConvertTo-SecureString
$smtpPass = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword))

# PC-Name und Seriennummer abrufen
$computerName = $env:COMPUTERNAME
$serialNumber = (Get-WmiObject win32_bios).SerialNumber

# Prüfen des freien Speicherplatzes auf Laufwerk C:
$drive = Get-PSDrive -Name C
$freeSpaceGB = [math]::round($drive.Free / 1GB, 2)
$totalSpaceGB = [math]::round(($drive.Used + $drive.Free) / 1GB, 2)

# Schwellenwert für die Benachrichtigung (in GB)
$threshold = 10

if ($freeSpaceGB -lt $threshold) {
    # Wenn der freie Speicherplatz unter den Schwellenwert fällt, sende eine E-Mail
    $smtpSubject = "Warnung: Weniger als $threshold GB auf Laufwerk C: auf $computerName"
    $smtpBody = @"
Das Laufwerk C: auf dem Computer $computerName (Seriennummer: $serialNumber) hat nur noch $freeSpaceGB GB freien Speicherplatz von insgesamt $totalSpaceGB GB.
Der Schwellenwert für diese Warnung ist auf $threshold GB eingestellt.
"@

    $message = New-Object Net.Mail.MailMessage
    $message.From = $smtpFrom
    $message.To.Add($smtpTo)
    $message.Subject = $smtpSubject
    $message.Body = $smtpBody

    $smtp = New-Object Net.Mail.SmtpClient($smtpServer, 587)
    $smtp.EnableSsl = $true
    $smtp.Credentials = New-Object System.Net.NetworkCredential($smtpUser, $smtpPass)

    try {
        $smtp.Send($message)
    } catch {
        # Fehlerprotokollierung in eine Datei
        $errorMessage = "Fehler beim Senden der E-Mail: $_"
        $errorMessage | Out-File -Append -FilePath "C:\Path\To\ErrorLog.txt"
    }
}
