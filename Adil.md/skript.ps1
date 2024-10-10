Passwort verschlüsseln

# Passwort eingeben und verschlüsseln
$securePassword = Read-Host "Bitte gib dein Email-Passwort ein" -AsSecureString

# Passwort verschlüsselt in eine Datei speichern
$securePassword | ConvertFrom-SecureString | Set-Content "C:\Pfad\zu\password.txt"

Skript

# SMTP-Einstellungen
$smtpServer = "smtp.ionos.de"
$smtpFrom = "Deine Email"
$smtpTo = "Empfänger Mail"
$smtpUser = "Deine Email"  # Falls dein SMTP-Server Authentifizierung erfordert

# Verschlüsseltes Passwort aus Datei laden und entschlüsseln
$securePassword = Get-Content "C:\Pfad\zu\password.txt" | ConvertTo-SecureString
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $smtpUser, $securePassword
$smtpPass = $credential.GetNetworkCredential().Password

# PC-Name und Seriennummer abrufen
$computerName = $env:COMPUTERNAME
$serialNumber = (Get-WmiObject win32_bios).SerialNumber

# Prüfen des freien Speicherplatzes auf Laufwerk C:
$drive = Get-PSDrive -Name C
$freeSpaceGB = [math]::round($drive.Free / 1GB, 2)
$totalSpaceGB = [math]::round(($drive.Used + $drive.Free) / 1GB, 2)

# Schwellenwert für die Benachrichtigung (10 GB)
$threshold = 10

if ($freeSpaceGB -lt $threshold) {
    # Wenn der freie Speicherplatz unter 10 GB fällt, sende eine E-Mail
    $smtpSubject = "Warnung: Weniger als 10 GB auf Laufwerk C: auf $computerName"
    $smtpBody = @"
Das Laufwerk C: auf dem Computer $computerName (Seriennummer: $serialNumber) hat nur noch $freeSpaceGB GB freien Speicherplatz von insgesamt $totalSpaceGB GB.
"@

    $message = New-Object Net.Mail.MailMessage
    $message.From = $smtpFrom
    $message.To.Add($smtpTo)
    $message.Subject = $smtpSubject
    $message.Body = $smtpBody

    $smtp = New-Object Net.Mail.SmtpClient($smtpServer, 587)  # Port 587 für TLS, ändere ggf. für SSL (Port 465)
    $smtp.EnableSsl = $true
    $smtp.Credentials = New-Object System.Net.NetworkCredential($smtpUser, $smtpPass)

     try {
        $smtp.Send($message)
        Write-Host "E-Mail wurde gesendet."
    } catch {
        Write-Host "Fehler beim Senden der E-Mail: $_"
    }
} else {
    Write-Host "Genügend freier Speicherplatz vorhanden: $freeSpaceGB GB von insgesamt $totalSpaceGB GB auf $computerName (Seriennummer: $serialNumber)"
}

