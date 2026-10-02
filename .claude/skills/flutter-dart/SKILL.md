---
name: flutter-dart
description: Technische Regeln für dieses Flutter/Flame-Spielprojekt – Stack, Projektstruktur, Umgebung, Befehle, Architektur, Tests, Definition of Done (Abschnitt 7), Store-Compliance. Vor jedem Implementierungs-Task lesen.
---

# Flutter/Dart-Regeln für „Rune Rush“

## 1. Stack und Versionen (Stand 2026-10-02, gepinnt in `pubspec.yaml`)

| Baustein | Package / Version | Zweck |
|---|---|---|
| Flutter | stable ≥ 3.44 (Impeller, SwiftPM, AGP 9) | App |
| Flame | `flame: ^1.38.2` (**nicht** 2.0.0-dev) | Spielszene, Partikel, Sprite-Batching |
| Tests Flame | `flame_test: ^2.3.1` | `testWithFlameGame`, `testGolden` |
| State | `flutter_riverpod: ^3.4.3`, `flame_riverpod: ^5.5.5` | Meta/Services; Brücke zu Flame |
| Routing | `go_router` (aktuelle Version pinnen) | Screens |
| Audio | `flutter_soloud: ^5.1.5` | Low-Latency-Sound |
| Ads | `google_mobile_ads: ^9.1.0` (+ `gma_mediation_*` nach Bedarf) | AdMob inkl. UMP-Consent |
| IAP | `purchases_flutter: ^10.14.0` (RevenueCat) | Werbefrei, Kosmetik, Pass |
| Firebase | `firebase_core ^4.15`, `firebase_analytics ^12.6`, `firebase_crashlytics ^5.4`, `firebase_remote_config ^6.7` | Analytics, Crashes, Balancing-Overrides |
| Lints | `very_good_analysis` | strenge Regeln, Deprecations = Fehler |

Neue Dependencies nur mit Eintrag in `docs/entscheidungen/` (kurze ADR) und Begründung im PR.

## 2. Projektstruktur (Pub-Workspace-Monorepo)

```
/
├─ pubspec.yaml                 # workspace: [app, packages/game_core]
├─ app/                         # Flutter-App (android/, ios/)
│  ├─ lib/
│  │  ├─ main.dart, bootstrap.dart        # Firebase-Init, Crashlytics, ProviderScope
│  │  ├─ app/                  # Router, Theme, Lokalisierung (ARB: EN, DE)
│  │  ├─ features/
│  │  │  ├─ gameplay/          # Flame: RuneRushGame, Board-Renderer, Input → game_core
│  │  │  ├─ shop/ album/ run_summary/ daily/ settings/ paywall/   # Widgets + Notifier
│  │  └─ services/             # ads/ iap/ analytics/ remote_config/ save/ audio/
│  │                           #   je: abstract class + Impl + Fake (für Tests)
│  ├─ test/                    # unit/, widget/, goldens/, flame/
│  └─ integration_test/        # echte SDKs, nightly
├─ packages/game_core/          # REINES DART – keine Flutter-/Flame-Imports
│  ├─ lib/src/
│  │  ├─ board/                # Grid, Gem, Match-Erkennung, Gravity, Spezialsteine
│  │  ├─ scoring/              # Basis × Mult, Kaskaden
│  │  ├─ runes/                # Rune (Daten), Hooks, Registry, Loader (JSON)
│  │  ├─ run/                  # RunState, Stufen, Bosse, Shop, Münzen
│  │  ├─ rng/                  # SeededRandom (deterministisch)
│  │  ├─ save/                 # Save-Schema, Versionierung, Migration
│  │  └─ sim/                  # Bot-Simulator für Balancing
│  └─ test/
├─ assets/                      # balancing/*.json (Runen, Bosse, Zielkurven), audio/, images/
├─ docs/                        # Konzept, Entscheidungen, Recherche
└─ .github/workflows/           # ci.yml, release.yml
```

## 3. Umgebung

**Lokale Session (Claude Code auf dem Rechner des Entwicklers, Normalfall für Implementierung):** Flutter stable installiert, `flutter doctor` grün, Android-Emulator oder Gerät vorhanden. Alle Befehle aus Abschnitt 4 laufen lokal.

**Cloud-Session (claude.ai / Remote-Container):** Flutter und `pub.dev` sind dort **nicht erreichbar** (Netz-Allowlist: nur GitHub und Package-Registries wie npm/pip; `storage.googleapis.com`, `pub.dev`, `dl.google.com` sind gesperrt – geprüft am 2026-10-02). Vorgehen:
1. Vor dem Start `which flutter` prüfen. Fehlt Flutter → **nicht** versuchen, es zu installieren.
2. Code und Tests schreiben, Branch pushen, CI als Testlauf nutzen: `gh run watch` bzw. `gh run view --log-failed`.
3. Reines Dart (`packages/game_core`) ist davon ebenso betroffen (Dart-SDK kommt von Google). Deshalb: kleine Commits, CI-Feedback abwarten, dann weiter.
4. Planung, Issues, Docs, STAND.md, Reviews gehen in Cloud-Sessions uneingeschränkt.

## 4. Befehle

```bash
dart pub get                                   # Workspace
dart format --output=none --set-exit-if-changed .
flutter analyze --fatal-infos                  # muss grün sein, Deprecations = Fehler
dart test packages/game_core                   # Logik, schnell, deterministisch
(cd app && flutter test --coverage)            # Widget-, Golden-, Flame-Tests
(cd app && flutter test --update-goldens)      # NUR wenn das Issue eine visuelle Änderung verlangt
(cd app && flutter build apk --debug)          # Smoke-Build
dart run packages/game_core/bin/simulate.dart --runs 2000 --stake 1   # Balancing-Report
```

## 5. Architektur-Regeln

1. **`game_core` ist pur.** Keine `dart:ui`, kein Flutter, kein Flame. Alles, was Regeln, Zahlen und Zustand betrifft, lebt hier. Flame rendert und nimmt Eingaben entgegen, mehr nicht.
2. **Determinismus.** Jede Zufallsquelle geht durch `SeededRandom`. Gleicher Seed + gleiche Züge = gleiches Ergebnis. Das ist Voraussetzung für Daily Seeds, Replays und Tests.
3. **Runen sind Daten + Hooks.** Neue Rune = JSON-Eintrag in `assets/balancing/runes.json` + ggf. Handler für einen bestehenden Hook (`onMatch`, `onCascade`, `onBoardStart`, `onBoardEnd`, `onMoveUsed`, `onShop`). Neue Hooks nur mit Begründung.
4. **Services hinter Interfaces** (`AdService`, `IapService`, `AnalyticsService`, `RemoteConfigService`, `SaveService`). Jede hat eine `Fake…`-Implementierung für Tests. Echte SDKs werden nur in `bootstrap.dart` verdrahtet.
5. **Keine Logik in Widgets.** Widgets lesen Riverpod-Provider und senden Intents an Notifier.
6. **Kein Riverpod im Frame-Loop.** Flame hält eine Referenz auf den `RunState` aus `game_core` und meldet Ereignisse (Brett gewonnen, Run beendet) über `flame_riverpod` nach oben.
7. **Save-Schema versioniert.** Jede Änderung am Save-Format bekommt eine Migration + Test.
8. **Balancing-Werte nie hart im Code.** Zielkurven, Preise, Seltenheiten, Zugbudgets stehen in `assets/balancing/*.json`; Remote Config darf sie überschreiben.
9. **Lokalisierung von Anfang an.** Kein Text im Code; ARB-Dateien EN (Quelle) und DE.
10. **Monetarisierungs-Verbotsliste** (CLAUDE.md, Abschnitt „Design-Leitplanken“) ist technisch bindend: Es gibt keinen Code-Pfad für Leben, Energie oder bezahlte Zufallsitems.

## 6. Tests (TDD)

Ablauf je Task: Akzeptanzkriterium → Test schreiben (Testname = Kriterium) → rot → minimal implementieren → grün → refaktorieren. Erst dann der nächste Punkt.

| Ebene | Werkzeug | Regeln |
|---|---|---|
| `game_core` | `dart test` | Deterministisch (Seed), keine Zeit, kein I/O. Ziel ≥ 90 % Coverage. Property-Tests für Match-Erkennung und Generator („nie Match im Start“, „immer ein gültiger Zug“). |
| Flame | `flame_test` | `testWithFlameGame` für Lifecycle/Input; `testGolden` sparsam, nur für Render-Regressionen. |
| Meta-UI | Widget-Tests, Golden-Tests | Goldens **nur auf Linux** erzeugen und vergleichen (Font-Rendering). Golden-Updates nur, wenn das Issue eine visuelle Änderung verlangt, und mit Vorher/Nachher-Bild im PR. |
| Services | Unit-Tests mit Fakes | Echte SDKs nur in `integration_test/` (nightly, Emulator). |
| Balancing | Simulator | Jede Änderung an Runen/Zielkurve: Simulator-Report (Win-Rate je Stufe, Pick-Rate) im PR. |

## 7. Definition of Done (für jeden Task)

Ein Task ist fertig, wenn **alles** zutrifft:

1. Jedes Akzeptanzkriterium des Tasks hat genau einen Test mit dem Kriterium als Testnamen; alle Tests sind grün.
2. `dart format`, `flutter analyze --fatal-infos`, `dart test packages/game_core` und `flutter test` laufen in der CI grün.
3. Keine neuen Deprecation-Warnungen, keine `// ignore:` ohne Begründung in derselben Zeile.
4. Keine neue Dependency ohne ADR in `docs/entscheidungen/`.
5. Keine Logik in Widgets, keine Flutter-Imports in `game_core`, keine hart kodierten Balancing-Werte, keine Strings außerhalb der ARB-Dateien.
6. Bei Änderungen an Runen, Bossen oder Zielkurven: Simulator-Report im PR.
7. Bei visuellen Änderungen: Golden-Tests aktualisiert und Screenshot im PR.
8. Bei Änderungen am Save-Format: Migration + Test.
9. Bei Performance-relevanten Änderungen (Renderer, Partikel): Frametime-Messung im Profile-Modus auf dem Referenzgerät im PR genannt.
10. Der PR verweist auf den Task (`Closes #nr`), die CI ist grün, und der Task ist über das Merge geschlossen – nicht von Hand.
11. `STAND.md` ist aktualisiert, falls sich dadurch ein Story-Status ändert.

## 8. Store-Compliance-Checkliste (vor jedem Release)

- Android: `targetSdk = 36` (Pflicht seit 31.08.2026), 16-KB-Page-Size-Check (`zipalign -c -P 16`), App Bundle signiert, Data-Safety-Formular passt zu den SDKs.
- iOS: Xcode 26 / iOS-26-SDK, Minimum iOS 13+, `PrivacyInfo.xcprivacy` inkl. aller SDK-Manifeste, ATT-Prompt vor personalisierter Werbung.
- Consent: UMP-Formular (EU) vor dem ersten Ad-Request; Ads nur nicht-personalisiert ohne Einwilligung.
- IAP: Preise in Landeswährung, Wiederherstellen-Button, keine Pakete, die Restguthaben erzwingen (es gibt keine Währung zu kaufen).
- Keine Kinder-Zielgruppe: Store-Einträge „nicht an Kinder gerichtet“, keine Mixed-Audience-Deklaration.
- Push (falls vorhanden): keine Zustellung 22–7 Uhr Ortszeit.

## 9. Typische Fallen

- Flame-APIs ändern sich oft: vor Nutzung einer API die gepinnte Version in `pubspec.lock` prüfen und die Doku dieser Version lesen (`docs.flame-engine.org/1.38.x`). Deprecations sind Analyze-Fehler.
- Goldens unterscheiden sich zwischen macOS und Linux – CI ist Linux, also lokal mit Linux-Goldens arbeiten oder Goldens nur in CI erzeugen.
- `flutter test --update-goldens` nie „zur Sicherheit“ laufen lassen.
- Impeller ist auf Android Pflicht; Shader-Tricks aus Skia-Zeiten funktionieren nicht mehr.
- Kein `Random()` ohne Seed in `game_core`; kein `DateTime.now()` in `game_core` (Zeit kommt als Parameter).
