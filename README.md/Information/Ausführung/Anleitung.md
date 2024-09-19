Schritt 1: Passwort einmalig verschlüsseln und speichern
Verwenden Sie das folgende Skript, um Ihr Passwort zu verschlüsseln und in einer Datei zu speichern:

Passwort eingeben und verschlüsseln
$securePassword = Read-Host "Bitte gib dein Email-Passwort ein" -AsSecureString

Passwort verschlüsselt in eine Datei speichern
$securePassword | ConvertFrom-SecureString | Set-Content "C:\Pfad\zu\password.txt"

-Pfad : Ersetzen C:\Pfad\zu\password.txtdurch den gewünschten Speicherort.
-Dies speichert das Passwort verschlüsselt in der Datei password.txt.


**Anleitung** 

**PowerShell als Administrator öffnen**

PowerShell Skript zulassen:
Get-ExecutionPolicy > Set-ExecutionPolicy RemoteSigned > J > Get-ExecutionPolicy = RemoteSigned
(Falls Sie die Einstellung eines Tages auf Standard zurücksetzen wollen, verwenden Sie in einer Admin-PowerShell den Befehl: Get-ExecutionPolicy Default)

Das Skript abspeichern mit der Endung „ps1“

„Windows + r“ Zusammen Drücken geben sie den Befehl „taskschd.msc“ eingeben (Unter Windows 11 „Taskplaner“)

Unter Aktion > Aufgabe erstellen > Den Haken setzen bei Unabhängig von der Benutzeranmeldung Ausführung klicken > Den Reiter Trigger > Wöchentlich > Reiter Action > Programm/Skript: "powershell.exe" einfügen > Argumente: den Ganzen Pfad wo das Skript gespeichert wurde > Starten in: nur den Pfad zum Skript.
