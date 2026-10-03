---
name: flutter-dart
description: Technische Regeln für dieses Dart/Flutter/Flame-Strategiespiel – Stack je Stufe, Projektstruktur (game_core-Module), Umgebung, Befehle, Architektur (Determinismus, Ganzzahlen, Daten statt Code), Tests inkl. Bot-Turnier, Definition of Done (Abschnitt 7), Store-Compliance. Vor jedem Implementierungs-Task lesen.
---

# Flutter/Dart-Regeln für „Small Realms“

## 1. Stack nach Stufen (Stand 2026-10-03)

| Stufe | Baustein | Package / Version |
|---|---|---|
| **B1 (headless)** | Dart SDK stable (≥ 3.10), `package:test`, `very_good_analysis`, `json_annotation`/`build_runner` nur falls nötig (lieber handgeschriebene `fromJson`) | reines Dart, keine Flutter-Abhängigkeit |
| **B2 (App)** | Flutter stable ≥ 3.44, `flame: ^1.38.2` (Tilemap/Sprites, **nicht** 2.0-dev), `flame_test`, `flutter_riverpod: ^3.4`, `go_router`, `flutter_soloud` | wie Rune Rush, Versionen beim Einstieg aus `maestroDev3/game` übernehmen |
| **B2** | Firebase: `firebase_core`, `firebase_analytics`, `firebase_crashlytics`; RevenueCat `purchases_flutter` | **kein** `google_mobile_ads`, kein Mediation-SDK |
| **Web-Build** | `flutter build web --release` auf GitHub Pages, nur für den Spaß-Check | kein Store-Ziel |

Neue Dependencies nur mit kurzer ADR in `docs/entscheidungen/`.

## 2. Projektstruktur

```
/
├─ pubspec.yaml                 # Workspace: [packages/game_core, app]  (app ab B2)
├─ packages/game_core/          # REINES DART – keine Flutter-/Flame-Imports, nur Ganzzahlen
│  ├─ lib/src/
│  │  ├─ map/        # Tile, Terrain, MapData (JSON v1), MapGenerator, MapValidator, Pathfinding
│  │  ├─ units/      # UnitType (JSON), Faction, DamageMatrix, Unit (HP, Position, Status)
│  │  ├─ combat/     # Schadensformel, Vorschau, Gegenschlag, Gelände-Boni
│  │  ├─ rules/      # Zugablauf, Aktionen, Einkommen, Einnahme, Siegbedingungen, Rundenlimit
│  │  ├─ ai/         # Einflusskarten, Utility-Scoring, 3 Stufen, RandomBot, GreedyBot
│  │  ├─ campaign/   # Missionsdefinitionen (JSON), Skripte (Ereignisse), Sterne
│  │  ├─ rng/        # SeededRandom (32-Bit, web-sicher)
│  │  ├─ save/       # Save-Schema, Versionierung, Migration, Replay (Zugliste)
│  │  └─ sim/        # Bot-Turnier, Fairness-Messung je Karte, Report
│  ├─ bin/tournament.dart        # CLI: --games 200 --map seed:… --ai a,b
│  └─ test/
├─ app/                         # ab B2: Flutter-App (android/, ios/, web/)
│  └─ lib/features/ battle/ (Flame) menu/ campaign/ skirmish/ settings/ supporter/ ; services/
├─ assets/data/                 # units.json, factions.json, terrain.json, missions/*.json, maps/*.json
├─ assets/CREDITS.md            # jede Art-/Audio-Quelle mit URL, Lizenz, Datum
├─ docs/
└─ .github/workflows/           # ci.yml (Dart), ab B2: app.yml, web.yml
```

## 3. Umgebung

**Lokale Session (PC des Entwicklers):** Dart/Flutter installiert. Alle Befehle aus Abschnitt 4 laufen lokal.

**Cloud-Session:** Dart und Flutter sind **nicht** installierbar (`storage.googleapis.com`, `pub.dev` gesperrt). Vorgehen: `which dart flutter` prüfen; fehlt beides, nicht installieren, sondern Branch pushen und die CI als Testlauf nutzen (`gh run watch`, `gh run view --log-failed`). Kleine Commits. Planung, Issues, Docs, Daten-JSON und Reviews gehen immer.

## 4. Befehle

```bash
dart pub get
dart format --output=none --set-exit-if-changed .
dart analyze --fatal-infos
dart test packages/game_core                      # schnell, deterministisch
dart test packages/game_core -p chrome            # Web-Determinismus (JS-Zahlen)
dart run packages/game_core/bin/tournament.dart --games 200 --ai heuristic2,greedy --seed 42
# ab B2:
(cd app && flutter test --coverage)
(cd app && flutter build web --release)           # Spaß-Check-Build
(cd app && flutter build apk --debug)
```

## 5. Architektur-Regeln

1. **`game_core` ist pur und ganzzahlig.** Keine `double` in Regeln, Schaden, Bewegung, Scoring (Web rechnet `int` als JS-Zahl; 32-Bit-Arithmetik mit expliziter Maskierung im RNG). Keine `DateTime.now()`, kein `Random()` ohne Seed.
2. **Determinismus:** gleicher Seed + gleiche Zugliste = gleicher Zustand. Replays sind Zuglisten; Tests prüfen Replay-Gleichheit.
3. **Daten statt Code:** Einheiten, Fraktionen, Gelände, Schadensmatrix, Missionen und Karten sind JSON in `assets/data/` mit `schemaVersion`. Neue Einheit = Datensatz + Sprite, kein neuer Code. Loader validieren beim Start (Test: alle Dateien laden fehlerfrei).
4. **Exakte Vorschau:** Jede Angriffsaktion liefert vorab `(damage, counterDamage)`; die Ausführung muss exakt das Vorschau-Ergebnis erzeugen (Test).
5. **KI ohne versteckte Boni:** Die KI nutzt dieselben Regeln und Daten wie der Spieler; Schwierigkeit entsteht durch Suchtiefe/Gewichtung, nie durch Rabatte. KI-Zug < 5 s auf Mittelklasse-Android (Budget: ≤ 2 000 Bewertungen pro Zug), abbrechbar.
6. **Generator + Validator:** Jede generierte Karte besteht Erreichbarkeit (alle HQs verbunden), Symmetrie-/Fairness-Check (Bot-Turnier: Sieg-Rate Seite A zwischen 40 und 60 %), Mindestabstand der HQs. Seeds sind teilbar als Code (`SR1-<base32>`).
7. **Services hinter Interfaces** (`AnalyticsService`, `SaveService`, `IapService`, `RemoteConfigService`) mit Fakes; **kein `AdService`**. Echte SDKs nur in `bootstrap.dart`.
8. **Keine Logik in Widgets; kein Riverpod im Frame-Loop.** Flame rendert Karte und Einheiten und sendet Intents an `game_core`.
9. **Save-Schema versioniert**, jede Änderung mit Migration + Test. Autosave nach jedem Zug.
10. **Lokalisierung von Anfang an** (ARB EN/DE), keine Strings im Code; Einheiten-/Missionsnamen über Schlüssel.
11. **Verbotsliste** (CLAUDE.md) ist technisch bindend: kein Code-Pfad für Werbung, Währung, Pay-to-Win, Editor-Upload.

## 6. Tests (TDD)

Ablauf je Task: Akzeptanzkriterium → Test (Name = Kriterium) → rot → minimal implementieren → grün → refaktorieren.

| Ebene | Werkzeug | Regeln |
|---|---|---|
| `game_core` | `dart test` (+ `-p chrome` in CI) | Deterministisch; Property-Tests für Generator („immer verbunden“, „nie HQ am Rand“), Pathfinding, Schadensmatrix (alle Paare definiert); Replay-Gleichheit. Ziel ≥ 90 % Coverage. |
| KI/Balancing | Bot-Turnier (`sim/`) | Gate je Stufe: Heuristik schlägt RandomBot ≥ 95 %, GreedyBot ≥ 70 % über 200 Partien; keine Partie ohne Ergebnis; Report im PR bei jeder Änderung an Daten, Regeln oder KI. |
| Flame (B2) | `flame_test` | Lifecycle/Input; `testGolden` sparsam. |
| Meta-UI (B2) | Widget-/Golden-Tests | Goldens nur auf Linux erzeugen; Updates nur mit visueller Anforderung im Issue. |
| Services | Unit-Tests mit Fakes | Echte SDKs nur in `integration_test/` (nightly). |

## 7. Definition of Done (für jeden Task)

1. Jedes Akzeptanzkriterium des Tasks hat genau einen Test mit dem Kriterium als Testnamen; alle Tests grün – in `game_core` auch unter `-p chrome`.
2. `dart format`, `dart analyze --fatal-infos` (ab B2 `flutter analyze --fatal-infos`), `dart test` und ab B2 `flutter test` laufen in der CI grün.
3. Keine neuen Deprecation-Warnungen, keine `// ignore:` ohne Begründung in derselben Zeile.
4. Keine neue Dependency ohne ADR.
5. Keine `double` in `game_core`-Regeln, keine Flutter-Imports in `game_core`, keine hart kodierten Einheiten-/Karten-/Balancing-Werte, keine Strings außerhalb der ARB-Dateien.
6. Bei Änderungen an Daten (`assets/data/`), Regeln oder KI: Bot-Turnier-Report im PR (Gates aus Abschnitt 6 erfüllt).
7. Bei Änderungen am Generator: Validator-Statistik über 500 Seeds im PR (Anteil verworfener Karten, Fairness-Spanne).
8. Bei Änderungen am Save-/Karten-/Replay-Format: `schemaVersion` erhöht, Migration + Test.
9. Bei visuellen Änderungen (B2): Goldens aktualisiert, Screenshot im PR.
10. Der PR verweist auf den Task (`Closes #nr`), die CI ist grün, der Task wird über das Merge geschlossen.
11. `STAND.md` ist aktualisiert, falls sich ein Story-Status ändert; Portfolio-Regel (max. 2 Stories in `test` über beide Repos) geprüft.

## 8. Store-Compliance (ab B2, vor jedem Release)

- Android: `targetSdk = 36`, 16-KB-Page-Size-Check, Data-Safety passend zu Firebase/RevenueCat (kein Ads-SDK → keine Werbe-ID).
- iOS: Xcode 26 / iOS-26-SDK, `PrivacyInfo.xcprivacy` inkl. SDK-Manifeste; **kein ATT-Prompt nötig** ohne Tracking.
- IAP: Preise in Landeswährung, Wiederherstellen-Button, Supporter-Entitlement serverseitig (RevenueCat).
- Keine Kinder-Zielgruppe; keine UGC-Features (sonst Play-UGC-Richtlinie: Melden/Sperren).

## 9. Typische Fallen

- `int` im Web ist eine 64-Bit-Gleitkommazahl: Bit-Operationen nur mit `& 0xFFFFFFFF`; Hashes/RNG darauf auslegen; CI testet mit `-p chrome`.
- Pathfinding-Kosten je Gelände sind Daten – nicht im Algorithmus hart kodieren.
- KI-Zeitbudget: Suche abbrechbar machen; nie „bis fertig“ auf dem Gerät rechnen.
- Flame-API-Versionen pinnen; Doku der gepinnten Version lesen.
- Goldens nur auf Linux; `--update-goldens` nie „zur Sicherheit“.
