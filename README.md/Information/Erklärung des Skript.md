Erklärung des Skript

1. SMTP-Konfiguration:
Zunächst werden die Einstellungen für den SMTP-Server festgelegt. Dazu gehören der Servername (in deinem Fall smtp.ionos.de), die E-Mail-Adresse des Absenders, die des Empfängers sowie die Anmeldedaten für die Authentifizierung beim SMTP-Server. Diese Anmeldedaten sind notwendig, um die E-Mail über den angegebenen Server zu versenden.

2. Abruf von Systeminformationen:

Anschließend ruft das Skript zwei wichtige Informationen über den Computer ab:

Den Computername: Dieser wird über eine Umgebungsvariable ermittelt.
Die Seriennummer des Computers: Diese wird durch eine Abfrage der BIOS-Informationen über WMI (Windows Management Instrumentation) abgerufen.

3. Speicherplatzüberwachung:
Das Skript überprüft den verfügbaren Speicherplatz auf Laufwerk C:. Es berechnet sowohl den verfügbaren freien Speicherplatz als auch den Gesamtspeicherplatz in Gigabyte (GB). Dabei wird der Speicherplatz auf zwei Dezimalstellen gerundet.

4. Schwellenwert-Überprüfung:
Ein Schwellenwert von 10 GB wird festgelegt. Wenn der freie Speicherplatz auf Laufwerk C: unter diesen Wert fällt, wird eine E-Mail-Benachrichtigung ausgelöst.

5. E-Mail-Versand:
Wenn der freie Speicherplatz unter 10 GB liegt, erstellt das Skript eine E-Mail. Der Betreff und der Text der E-Mail enthalten Informationen über den Computer (Name und Seriennummer) sowie den freien und den gesamten Speicherplatz. Diese E-Mail wird dann über den zuvor konfigurierten SMTP-Server versendet. Die SMTP-Verbindung erfolgt über Port 587, was in der Regel für TLS-Verschlüsselung genutzt wird.
