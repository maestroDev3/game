# Spielkonzept: „Small Realms“ (Arbeitstitel)

**Genre:** Rundenbasierte Pixel-Strategie (Advance-Wars-Loop) · **Plattform:** Android, iOS (Web-Build nur für Tests) · **Monetarisierung:** kostenlos, ohne Werbung, Supporter-Kauf + Kosmetik
**Stand:** 2026-10-03 · Story #49 (Repo `game`) · Recherche: `docs/recherche/genre.md` · Pflege durch den Agenten nach Entscheidungen des Menschen.

> **Elevator-Pitch:** Kleine Reiche, kurze Kriege. Speer schlägt Reiter, Reiter schlägt Bogen, und das Dorf in der Mitte entscheidet. Jede Karte ist neu, eine Partie dauert eine Mittagspause, ein Zug passt an die Haltestelle.

---

## 1. Spielerfahrung in 90 Sekunden

1. App öffnen → **„Spielen“** → Mission 1 lädt in unter 10 s, kein Login. Drei Milizen stehen gegen zwei Plünderer, die Karte hat 8×10 Felder.
2. Tipp auf eine Miliz: Die Bewegungsfelder leuchten. Tipp auf den Wald neben dem Gegner: Hinweis „Wald schützt“.
3. Tipp auf einen Plünderer: Vorschau **„−4 · Gegenschlag −1“**. Nach dem Bestätigen folgen Treffer, Hit-Stop und die fliegende Zahl. **Aha-Moment nach höchstens 90 s: „Ich weiß vorher genau, was passiert.“**
4. Der Gegner braucht unter 5 s. Der zweite Plünderer greift die Miliz im Wald an und macht nur 2 Schaden statt 3 auf offenem Feld. Das zweite Aha: Gelände zählt.
5. In Runde 3 nimmt der Spieler das Dorf ein, bekommt +100 Gold und rekrutiert den ersten Speerträger.

## 2. Core Loop

```
 Partie (10–20 min, 8–15 Runden)
 ┌─ Rundenbeginn: Einkommen, Heilung auf eigenen Gebäuden (+2 HP)
 │  Zug (1–3 min): jede Einheit einmal  Bewegen → Angreifen | Einnehmen | Befestigen | Warten
 │                 Bauen = Rekrutieren in eigener Kaserne/HQ
 └─ „Zug beenden“ → Autosave → Gegnerzug → …
 Ende: HQ eingenommen | Gegner ohne Einheiten | Rundenlimit → Punkte
```

- **Bewegen:** Jedes Feld kostet Bewegungspunkte je nach Gelände. Durch eigene Einheiten darf man ziehen, gegnerische blockieren. Bis zur Aktion lässt sich die Bewegung **zurücknehmen**.
- **Angreifen:**
  - Nahkampf ist auch nach der Bewegung erlaubt.
  - Fernkampf (Reichweite ≥ 2) bekommt keinen Gegenschlag.
  - Geräte ziehen und schießen nie im selben Zug.
  - Ein Verteidiger, der überlebt, schlägt im Nahkampf mit seinen Rest-HP zurück.
  - **Kein Zufall.**
- **Einnehmen:** nur Einheiten mit dem Tag `capture`. Jedes Gebäude hat 20 Punkte, pro Zug werden die aktuellen HP der Einheit abgezogen (volle HP: 2 Züge). Wegziehen oder Tod setzt den Fortschritt zurück.
- **Bauen:** Rekrutieren auf einer freien eigenen Kaserne oder dem HQ. Die Einheit handelt ab der nächsten Runde.
- **Gold:**
  - Einkommen: Dorf und Kaserne je 100, HQ 200; Start mit 300.
  - Spieler 2 bekommt +100 Gold als Ausgleich für den Erstzug; der Wert wird per Bot-Turnier bestimmt.
- **Rundenlimit:** 15 Runden. Danach gewinnt, wer mehr Punkte hat: Gebäude × 100 + Σ Kosten × HP/10.
- **Sterne (Missionen):** ★ Sieg · ★★ Sieg in ≤ N Runden · ★★★ höchstens K Verluste.

## 3. Einheiten-Modell

Einheiten sind Datensätze. Neue Einheiten brauchen keinen Code, solange ihre Tags existieren.

```json
{ "id": "crown.spear", "faction": "crown", "cost": 150, "move": 3, "moveType": "foot",
  "range": [1, 1], "attack": 5, "attackType": "pierce", "defense": 2,
  "armor": "light", "hp": 10, "tags": ["capture"] }
```

**Schaden** (nur Ganzzahlen, damit Geräte und Web identisch rechnen):

```
Schaden = floor( A × M × HP_A × max(1, 10 − V − G) / 10 000 ), mindestens 1
A Angriff · M Matrix-% · HP_A Angreifer-HP (1–10) · V Verteidigung · G Gelände
```

**Matrix** (M in %, Angriffstyp → Rüstungsklasse). Stich schlägt Beritten, Beritten schlägt Gerät und Fernkampf, Geschoss schlägt Leicht, Wucht schlägt Schwer:

| | Leicht | Schwer | Beritten | Gerät |
|---|---|---|---|---|
| Klinge | 100 | 50 | 80 | 130 |
| Stich | 90 | 60 | **150** | 70 |
| Geschoss | **130** | 40 | 90 | 50 |
| Wucht | 80 | **150** | 70 | 120 |

**Kronland** (langsam, robust, befestigt):

| Einheit | Klasse / Typ | Kosten | Bew. | Reichw. | Ang. | Vert. | Tags |
|---|---|---|---|---|---|---|---|
| Miliz | Leicht / Klinge | 100 | 3 | 1 | 4 | 1 | capture |
| Speerträger | Leicht / Stich | 150 | 3 | 1 | 5 | 2 | capture |
| Bogenschütze | Leicht / Geschoss | 200 | 3 | 2 | 5 | 0 | – |
| Ritter | Beritten / Klinge | 350 | 6 | 1 | 7 | 2 | – |
| Schildwache | Schwer / Klinge | 300 | 2 | 1 | 5 | 4 | – |
| Katapult | Gerät / Wucht | 400 | 2 | 3–4 | 7 | 0 | no_move_attack |
| Pionier | Leicht / Klinge | 150 | 3 | 1 | 2 | 1 | capture, build_palisade |

**Sumpfclans** (schnell, billig, heilen). Fraktionsregel: Sumpf kostet sie nur 1 Bewegungspunkt und gibt ihnen +1 Verteidigung.

| Einheit | Klasse / Typ | Kosten | Bew. | Reichw. | Ang. | Vert. | Tags |
|---|---|---|---|---|---|---|---|
| Plünderer | Leicht / Klinge | 90 | 4 | 1 | 4 | 0 | capture |
| Hakenspeer | Leicht / Stich | 140 | 3 | 1 | 5 | 1 | capture |
| Schleuderer | Leicht / Geschoss | 180 | 4 | 2 | 4 | 0 | – |
| Keilerreiter | Beritten / Klinge | 300 | 6 | 1 | 6 | 1 | – |
| Moorkoloss | Schwer / Wucht | 320 | 3 | 1 | 6 | 3 | – |
| Steinwerfer | Gerät / Wucht | 380 | 3 | 2–4 | 6 | 0 | no_move_attack |
| Schamanin | Leicht / Wucht | 250 | 3 | 1 | 2 | 1 | heal_adjacent:2 |

**Gelände** (Kosten Fuß / Beritten / Gerät; G = Verteidigungsbonus):

| Gelände | Kosten | G | Besonderes |
|---|---|---|---|
| Ebene, Straße | 1/1/1 | 0 | – |
| Wald | 2/3/3 | 2 | – |
| Hügel | 2/3/– | 3 | Fernkampf +1 Reichweite |
| Sumpf | 2/3/– | 0 | Sumpfclans 1 und +1 |
| Furt | 2/2/3 | 0 | – |
| Wasser, Fels | – | – | unpassierbar |
| Dorf / Kaserne / HQ | 1/1/1 | 2/3/4 | Einkommen, Heilung; Kaserne/HQ rekrutieren |
| Palisade | +1 | +2 | Pionier baut sie für 100 Gold auf Ebene |

**Beispiele** (alle auf Ebene):

| Kampf | Rechnung | Schaden |
|---|---|---|
| Speerträger greift Ritter an | 5 × 150 × 10 × 8 / 10 000 | 6 |
| Gegenschlag des Ritters mit 4 HP | 7 × 100 × 4 × 8 / 10 000 | 2 |
| Ritter greift Katapult an | | 9 |
| Bogenschütze greift Schildwache an | | 1 |

Die Konter sind ohne Taschenrechner spürbar.

## 4. Karten

**Format:** versioniertes JSON, eine Zeichenkette pro Zeile. Kampagne, Handkarten und Generator nutzen dasselbe Format.

```json
{ "format": "small-realms-map", "version": 1, "id": "gen-v1-8f3a2c",
  "size": [14, 14], "symmetry": "rot180", "seed": 4012,
  "generator": { "name": "mirror", "version": 1 },
  "terrain": ["..ff.hh.......", "..."],
  "buildings": [{ "at": [1, 12], "type": "hq", "owner": 0 }],
  "units": [{ "at": [2, 12], "type": "crown.militia", "owner": 0 }],
  "rules": { "turnLimit": 15, "startGold": 300, "fog": false },
  "validation": { "validator": 1, "games": 400, "p0WinRate": 0.51 } }
```

**Größen:** 12×12 (ca. 10 min), 14×14 (Standard), 16×16 (ca. 20 min). In 1.0 gibt es nur 1 gegen 1.

**Generator** (`mirror` v1, deterministisch aus Seed und Parametern):
1. Rauschen für Höhe und Feuchte auf einer Kartenhälfte erzeugen. Daraus Gelände: Ebene ≥ 50 %, Wald 15–25 %, Hügel 5–10 %, Wasser und Sumpf ≤ 15 %.
2. Die Hälfte spiegeln, standardmäßig punktsymmetrisch, alternativ an Achse oder Diagonale.
3. Die HQs gegenüber platzieren, 16–22 Wegpunkte voneinander entfernt. Je Seite 1 Kaserne und 3 Dörfer im Radius 6, dazu 2–4 neutrale Gebäude in der Mitte.
4. Straßen per A* legen.

**Validator:**
- **Auf dem Gerät (< 50 ms).** Bei Verstoß wird mit Seed+1 neu erzeugt. Geprüft wird:
  - Jedes Gebäude ist von beiden HQs zu Fuß erreichbar.
  - In Runde 1 ist kein Angriff möglich.
  - Die Wegkosten zu den 3 nächsten Gebäuden unterscheiden sich je Seite um höchstens 1.
- **In der CI (Bot-Turnier).** Je Parametersatz 1 000 Karten mit je 2 Partien und getauschten Seiten. Bestanden, wenn:
  - Spieler 1 zu 45–55 % gewinnt,
  - die Partien im Median 8–15 Runden dauern,
  - weniger als 10 % unentschieden enden.
  - Daily-Seeds werden vorab genauso geprüft.

**Skirmish-Modi:**
- Gefecht gegen die KI: Handkarte oder Generator, 3 Stufen, beide Fraktionen.
- Daily Skirmish.
- Varianten (siehe 7).
- Hot-Seat: zwei Spieler auf einem Gerät.
- Ab 0.3 gibt es ~10 Handkarten als Schaufenster und Fallback.

## 5. KI (Heuristik, kein Deep Learning)

**Drei Karten pro Gegnerzug:**
- **Bedrohungskarte:** erwarteter gegnerischer Schaden je Feld im nächsten Zug.
- **Einflusskarte:** eigene minus gegnerische Stärke, mit Abfall je Feld. Daraus ergeben sich Front, sichere Felder und Lücken.
- **Zielkarte:** Wert der Gebäude (HQ ×3), mit Abfall nach Wegkosten.

**Aktionen:** Jede Einheit bewertet jede Kombination aus Feld und Aktion:

```
Wert = Schaden × Zielkosten − Gegenschlag × Eigenkosten − Bedrohung × Eigenwert + Gelände + Einnahme
```

Reihenfolge: Fernkampf, dann sichere Kills, dann Einnehmen, dann Positionieren.

**Produktion:** Die KI kauft den besten Matrix-Vorteil pro Gold gegen die gegnerischen Rüstungsklassen. Solange neutrale Gebäude stehen, hält sie mindestens 2 Einnehmer.

**Stufen** (keine Stufe bekommt versteckte Boni):
- Leicht: ±30 % Rauschen, kein Fokusfeuer.
- Normal: wie beschrieben.
- Schwer: Fokusfeuer über alle Einheiten.

**Budget:** ≤ 300 ms pro Zug auf einem Mittelklasse-Handy, gemessen auf 14×14 mit 16 Einheiten. Die KI läuft im Isolate (im Web im Hauptthread, daher das knappe Budget).

**Bots:** `RandomBot`, `GreedyBot` (maximaler Sofortschaden), `HeuristicBot`.

**Spaß-Check-Gate:** Die Heuristik gewinnt auf 200 Karten ≥ 90 % gegen Random und ≥ 70 % gegen Greedy.

**Balancing:**
- Fraktionen gewinnen über 500 Karten je 48–52 %.
- Jede Einheit hat 5–40 % Kaufanteil.
- Jede Werteänderung braucht einen Turnier-Report im PR.

## 6. Kampagne (8 Missionen, einmalig, Onboarding)

Jede Mission bringt eine neue Mechanik. Die Kampagne spielt mit Kronland. Die Sumpfclans werden nach Mission 4 frei, durch Spielen.

| # | Mission | Neue Mechanik | Karte | Dauer |
|---|---|---|---|---|
| 1 | Grenzposten | Bewegen, Angreifen, Vorschau | 8×10 | 3 min |
| 2 | Hinterhalt | Gelände | 10×10 | 5 min |
| 3 | Das Dorf | Einnehmen, Einkommen | 10×12 | 8 min |
| 4 | Speer gegen Keiler | Rekrutieren, Konter | 12×12 | 10 min |
| 5 | Pfeilregen | Fernkampf, Hügel | 12×12 | 12 min |
| 6 | Palisaden | Befestigen, 8 Runden halten | 12×14 | 12 min |
| 7 | Belagerung | Katapult, HQ einnehmen | 14×14 | 15 min |
| 8 | Die Sumpfkrone | volle Partie gegen „Normal“ | 14×14 | 15–20 min |

Skripte sind Daten: Trigger (`onTurnStart`, `onUnitLost`, `onCapture`, `onTurnLimit`) lösen Effekte aus (`dialog`, `spawn`, `win`, `lose`). Ein Dialog hat höchstens 2 Zeilen. Nach 1.0 kommen **keine Handmissionen** mehr.

## 7. Meta

| Element | 1.0 |
|---|---|
| **Statistik:** Siege je Fraktion und Stufe, Lieblingseinheit, kürzester Sieg | ja |
| **Varianten, durch Spielen freigeschaltet:** Nebel, Schnellgefecht (10 Runden), Reiche Lande (Einkommen ×2), Ohne Gerät, Festungen | 5 |
| **Kosmetik:** Banner, Einheiten-Skins, Kartenthemen (Winter, Wüste als Palettentausch); teils über Sterne, teils kaufbar | 6+ |
| **Daily Skirmish:** gleicher Seed für alle, Wertung nach Runden und Verlusten; Streak mit 1 Freeze pro Woche | ja |
| **Seed-Codes:** 8 Zeichen zum Teilen, ohne Server und Moderation | ja |
| **Asynchrones PvP** | 1.x |

**Asynchrones PvP (1.x):**
- Die Aktionslisten laufen über Firebase mit Anonymous Auth.
- Beide Clients simulieren jeden Zug nach, so fallen Manipulationen auf.
- Zugzeit 24 h. Push „Du bist dran“ nur von 7 bis 22 Uhr.

## 8. Session-Design

- **Kerneinheit:** ein Zug, 1–3 min. **Partie oder Mission:** 10–20 min. Über den Tag verteilt spielbar.
- **Autosave:** nach jeder Aktion ins Aktionslog, zusätzlich ein Snapshot je Zug.
- **Gegnerzug:** höchstens 8 s, auf ×2/×4 beschleunigbar oder überspringbar mit Zusammenfassung.
- **Ziele** (oberes Viertel laut GameAnalytics):
  - D1 ≥ 30 %, D7 ≥ 6 %
  - Mission 1 wird zu ≥ 85 % abgeschlossen
  - Partie-Abschlussrate ≥ 60 %
- Keine Energie, keine Leben, keine Wartezeiten, kein Login.

## 9. Monetarisierung (Empfehlung: ohne Werbung)

| Hebel | Preis | Inhalt |
|---|---|---|
| **Supporter** | 4,99 € | Danke-Banner, goldener Kartenrahmen, freiwilliger Credits-Eintrag |
| **Großer Supporter** | 9,99 € | dazu 2 Kosmetik-Pakete |
| **Kosmetik-Paket** | 1,99–2,99 € | Skin-Set je Fraktion oder Kartenthema |

- **Einmalkäufe, keine Währung.** Alle Käufe zusammen kosten höchstens ~30 € (Deckel wie bei Polytopia).
- **Erwartung** (Annahme: 1–2 % Käufer zu ~5 €): 500–1 000 € brutto je 10 000 Installs. Primärziel sind Installs und eine Bewertung ≥ 4,3.
- **Alternative (a):** Fraktion 3+ als IAP, wie die Polytopia-Stämme. Bringt mehr Umsatz, kostet aber Balancing- und Content-Aufwand je Fraktion.
- **Alternative (b):** Rewarded Ads für Kosmetik. Bricht die Marke „ohne Werbung“.
- **Verbotsliste (bindend):**
  - Leben/Energie
  - bezahlte Zufallsitems
  - zweite Währung
  - Countdown-Angebote
  - Confirmshaming
  - Pay-to-Win: keine kaufbaren Einheiten, Werte oder KI-Erleichterungen
  - Streak-Verlust ohne Freeze
  - Push zwischen 22 und 7 Uhr
  - Kinder-Zielgruppe

## 10. Technik

**`packages/game_core`** (reines Dart, deterministisch):

| Modul | Inhalt |
|---|---|
| `map/` | Grid, Gelände, Kartenformat mit Migration, Generator, Validator, Wegfindung |
| `units/` | Datensätze, Tags, Fraktionen, JSON-Loader |
| `combat/` | Formel, Matrix, Gegenschlag, Vorschau |
| `match/` | `MatchState`, Aktionen (`Move`, `Attack`, `Capture`, `Recruit`, `Fortify`, `EndTurn`), Sieg |
| `ai/` | Einflusskarten, Utility, Produktion, Stufen |
| `campaign/` | Missionen, Trigger, Sterne |
| `sim/` | Bots, Turniere, Reports (`dart run bin/tournament.dart --maps 1000`) |
| `rng/`, `save/` | aus Rune Rush |

- **Zustand:** Startkarte + Seed + Aktionslog, `apply(state, action) → (state, events)`. Darauf bauen Replays, Undo, Autosave und Async-PvP auf.
- **Determinismus:**
  - Keine `double` in den Regeln.
  - Der RNG muss web-sicher sein, denn Dart-`int` ist im Web eine JS-Number.
  - Die CI testet zusätzlich mit `-p chrome`.
- **Daten:** `assets/data/{units,matrix,terrain,generator}.json`, `assets/maps/`, `assets/campaign/`.
- **Analytics:**
  - `ftue_step`
  - `mission_start/end(id, result, turns, stars)`
  - `skirmish_start(source, size, faction, ai, variant)`
  - `skirmish_end(result, turns, duration_s)`
  - `undo_used`, `enemy_turn_skipped`, `daily_end(rank)`, `purchase(sku)`
- **Spaß-Check:** Flutter Web mit minimalem Flame-Renderer und Kenney-Platzhaltern auf GitHub Pages, 30 min im Handy-Browser gespielt.
- **Aus Rune Rush übernommen:** Seeded-RNG, Save/Migration, Service-Interfaces, EN/DE, Shop-UI (→ Kosmetik), Album-UI (→ Statistik), CI, Compliance-Checkliste. Herkunft mit Commit-Hash in `docs/basis.md`.

## 11. Art-Richtung

- **Kacheln:** 16×16-Pixel-Art, ganzzahlig auf ×3 = 48 px skaliert, `FilterQuality.none`. Sichtbar sind ~8×14 Felder, Pinch-Zoom ×2–×4.
- **Lesbarkeit** (Antwort auf die Kritik an Age of Strategy):
  - Teamfarbe zusätzlich über Banner und Umriss, farbenblind-tauglich.
  - HP-Zahl immer sichtbar.
  - Schrift ≥ 12 dp.
- **Juice:** Hit-Stop, fliegende Zahlen, Wackeln bei Kills, Einnahme-Balken, geschichteter 8-Bit-Sound.
- **Quellen:**
  - Kenney „Tiny Battle“ (CC0).
  - Ergänzungen nur unter CC0, CC-BY oder OGA-BY und nur in 16 px.
  - Nachweis in `assets/CREDITS.md`, Entscheidung als ADR „Pixel-Art-Lizenz“.

## 12. Umfang nach Versionen

| Version | Enthält | Gate |
|---|---|---|
| **0.1 Headless + Web-Spaß-Check** | `game_core`, Formate, Generator + Validator, 3 Bots, Turnier in der CI, minimaler Web-Client mit 2 Fraktionen | KI-Gate erfüllt; Mensch spielt 30 min: „noch eine Partie?“ |
| **0.2 App + Closed Test** | Android, Missionen 1–4, Gefecht mit Generator, Autosave, Undo, EN/DE, Analytics, Crashlytics | 12 Tester über 14 Tage; erst, wenn Rune Rush ≥ 4 Wochen stabil läuft |
| **0.3 Soft Launch** | Missionen 1–8, ~10 Handkarten, 3 KI-Stufen, Daily Skirmish, Seed-Codes, IAP, 2 Kosmetik-Pakete | D1/D7, Abschlussraten, Bewertung |
| **1.0** | Android + iOS, 5 Varianten, Sterne-Freischaltungen, Hot-Seat, Store-Listing, Community-Start (Reddit, Discord) | 10 000 Installs im ersten Jahr |
| **1.x** | Async-PvP, Generator-Biome; Fraktion 3 nur nach Daten | Bindung |

**Option Editor + Community** (nur nach ausdrücklicher Entscheidung des Menschen):
- **Umfang:**
  - In-App-Editor mit Validator-Pflicht.
  - Upload über Firestore/Storage.
  - Melden und Sperren, wie es die Play-UGC-Richtlinie verlangt.
  - Kuratierte Liste.
- **Aufwand:** ca. 3 Epics, also 6–10 Wochen Agentenarbeit.
- **Dauerhaft:** **3–5 h Moderation pro Woche durch den Menschen**, mehr als sein heutiger Slot für dieses Spiel.
- **Billigere Stufe:** Seed-Codes, die ohnehin in 1.0 enthalten sind.

## 13. Risiken und Gegenmaßnahmen

| Risiko | Gegenmaßnahme |
|---|---|
| Partien länger als 20 min | Rundenlimit, Standardkarte 14×14, schnelle KI-Züge, Partiedauer als Turnier-Metrik |
| KI wirkt dumm oder unfair | Gates, Turnier-Reports, keine versteckten Boni |
| Generator-Karten langweilig | Metriken für umkämpfte Gebäude und Führungswechsel; Handkarten als Fallback |
| Unlesbar auf kleinen Displays | 48-px-Kacheln, Zoom, Kontrast- und Farbenblind-Check im Closed Test |
| Spieler erwarten 500+ Karten | Daily Skirmish, Seed-Codes, Varianten; Editor-Option dokumentiert |
| Kleine Nische, wenig Discovery | ASO ohne fremde Marken, Community vor Launch, Seed-Codes zum Teilen |
| Rechtliche Nähe zu Advance Wars | Mittelalter-Thema, eigene Namen und Formel, keine Kommandeur-Porträts |
| Determinismus bricht im Web | Ganzzahl-Regeln, web-sicherer RNG, Golden-Replays in der CI auf VM und Chrome |
| Zu wenig Menschenzeit (≈ 1 h/Woche) | Headless über CI; Menschen-Phasen nur versetzt zu Rune Rush |
