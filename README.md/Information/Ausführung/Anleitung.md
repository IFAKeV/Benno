**Anleitung** 

**PowerShell als Administrator öffnen**

PowerShell Skript zulassen:
Get-ExecutionPolicy > Set-ExecutionPolicy RemoteSigned > J > Get-ExecutionPolicy = RemoteSigned
(Falls Sie die Einstellung eines Tages auf Standard zurücksetzen wollen, verwenden Sie in einer Admin-PowerShell den Befehl: Get-ExecutionPolicy Default)

Das Skript abspeichern mit der Endung „ps1“

„Windows + r“ Zusammen Drücken geben sie den Befehl „taskschd.msc“ eingeben (Unter Windows 11 „Taskplaner“)

Unter Aktion > Aufgabe erstellen > Den Haken setzen bei Unabhängig von der Benutzeranmeldung Ausführung klicken > Den Reiter Trigger > Wöchentlich > Reiter Action > Programm/Skript: "powershell.exe" einfügen > Argumente: den Ganzen Pfad wo das Skript gespeichert wurde > Starten in: nur den Pfad zum Skript.
