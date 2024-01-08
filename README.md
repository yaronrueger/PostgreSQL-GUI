# PG-Editor-Web

Dieses Svelte-Projekt konzentriert sich auf die Select_Tabelle.svelte-Datei, die eine Tabelle mit einer Dropdown-Auswahl zum Anzeigen von Daten aus verschiedenen Tabellen enthält. Die Tabelle bietet auch Filterfunktionen für jede Spalte und die Möglichkeit, neue Zeilen hinzuzufügen bzw. zu bearbeiten.
- Startseite (Auswahl der Tabelle): 
![image](https://github.com/yaronrueger/PostgreSQL-GUI/assets/105042550/0473a68d-d4a0-4759-9648-07c08a322393)
- Anischt der Tabelle mit Editor-Funktionen
![image](https://github.com/yaronrueger/PostgreSQL-GUI/assets/105042550/a67eb272-e302-4591-afb6-bcd69d00abd0)

### Voraussetzungen
- Node.js
- npm
- API zur PostgresDatenbank (z.B.: fastapi)
### Installation
1. Klonen Sie das Repository oder laden Sie den Code herunter.
2. Navigieren Sie im Terminal zum Projektverzeichnis.
3. Ändere in der ~ Select_Tabelle.svelte ~ die Beispiel-API-Adresse mit der richtigen Adresse, die mit der PostgreSQL-Datenbank kommuniziert.
4. Führen Sie npm install aus, um die Abhängigkeiten zu installieren.
### Verwendung
1. Führen Sie npm run dev aus, um den Entwicklungsserver zu starten. 
2. Öffnen Sie Ihren Browser und navigieren Sie zu http://localhost:5000.
3. API-Aufrufe und erwartete Ausgabe In diesem Projekt werden die folgenden API-Aufrufe verwendet:
- getTables: Gibt ein Array von Tabellennamen zurück.
    - Beispiel-Ausgabe: ["tabelle1", "tabelle2", "tabelle3", ...]
- getTableStructure: Gibt ein Array von Spaltennamen für die ausgewählte Tabelle zurück.
    - Beispiel-Ausgabe: ["spalte1", "spalte2", "spalte3", ...]
- getTableData: Gibt ein Array von Zeilen mit Daten für die ausgewählte Tabelle zurück. Jede Zeile ist ein Array von Zellenwerten.
    - Beispiel-Ausgabe: [["wert1.0", "wert1.1", "wert1.2"], ["wert2.0", "wert2.1", "wert2.2"], ["wert3.0", "wert3.1", "wert3.2"]]
- Stellen Sie sicher, dass Ihre API die erwartete Ausgabe für jeden API-Aufruf bereitstellt, damit das Svelte-Projekt korrekt funktioniert.

