# Entscheidung 0002: Engine und Tech-Stack – Flutter + Flame

**Status:** angenommen (vom Agenten, Bestätigung durch den Menschen offen) · **Datum:** 2026-10-02
**Grundlage:** `docs/recherche/engine-vergleich.md` (Vergleich von Flutter+Flame, reinem Flutter, Unity 6, Godot 4.7, Defold, Cocos, Bevy)

## 1. Ausgangslage

Ein Solo-Entwickler mit Flutter/Dart-Vorwissen baut mit einem autonomen KI-Agenten (Claude Code, GitHub Issues, TDD, CI) ein 2D-Handyspiel für Android und iOS, das später Geld verdienen soll (Rewarded Ads, In-App-Käufe, Analytics, Remote Config). Die Frage war: Passt Flutter/Dart, oder ist eine andere Engine/Sprache besser?

## 2. Entscheidung

1. **Flutter + Flame** (Flame 1.38.x, Flutter ≥ 3.44) in einer **Hybrid-Architektur**: Meta-Screens (Menü, Shop, Album, Einstellungen) als normale Flutter-Widgets, nur die Spielszene als Flame-`GameWidget`.
2. **Spiellogik als reines Dart-Package** (`packages/game_core`): Brett, Matching, Scoring, Runen, Run-Ablauf, Seeded-RNG, Save-Schema. Keine Flutter- oder Flame-Imports. Testbar mit `dart test` in Millisekunden.
3. **State-Management:** Riverpod 3 für Meta und Services; kein Riverpod im Frame-Loop.
4. **Monetarisierung/Backend:** `google_mobile_ads` (AdMob inkl. UMP-Consent), RevenueCat (`purchases_flutter`) für IAP, FlutterFire (Analytics, Crashlytics, Remote Config). Alles hinter Service-Interfaces mit Fakes für Tests.
5. **Monorepo als Pub-Workspace:** `app/` (Flutter-App) + `packages/game_core/`.
6. **Versionen pinnen.** Migration auf Flame 2.0 erst nach dem Stable-Release als eigenes Issue.

## 3. Begründung

- **Das gewählte Spielkonzept (Match-3-Roguelite, siehe 0003) ist Flames Komfortzone:** ein 7×7-Brett, wenige Dutzend Sprites, Partikel punktuell. Der einzige echte Flame-Nachteil (Massen-Sprites, 500+ Gegner bei 60 fps auf Mittelklasse-Android) spielt keine Rolle.
- **Monetarisierungs-Ökosystem:** Außerhalb von Unity hat Flutter die reifsten, offiziell gepflegten Plugins (Google, Firebase, RevenueCat, AppLovin, Unity LevelPlay). Godot hat hier nur Community-Ports.
- **Eignung für den KI-Agenten:** Alles ist Code, kein Binär-Editor, keine Szenen-GUIDs. Tests laufen headless auf Linux, Golden-Tests für UI, `flame_test` für Komponenten. Unity wäre für autonome Arbeit (YAML-Szenen, Editor-Images in CI, Lizenzaktivierung) deutlich zäher.
- **Meta-UI ist 50–70 % eines Casual-Spiels.** Shop, Album, Daily-Screen, Einstellungen sind in Flutter Standardarbeit mit Golden-Tests; in Unity/Godot/Defold erfahrungsgemäß zäher.
- **Vorwissen des Entwicklers** reduziert das Risiko bei Store-Builds, Signing und Plattform-Eigenheiten.
- **Kosten/Lizenz:** MIT/BSD, keine Runtime-Fee-Diskussion wie bei Unity (2023/2024).

## 4. Verworfene Alternativen

| Alternative | Warum verworfen |
|---|---|
| Unity 6 | Für den Agenten am schwächsten (YAML-Szenen, Editor-CI, Lizenz-Aktivierung); Personal-Lizenz reicht zwar bis 200 k$, aber Vertrauensschaden und jährliche Preiserhöhungen. Wäre erst sinnvoll bei Publisher-Deal/skalierter UA. |
| Godot 4.7 | Technisch gut (Textszenen, Headless), aber Ads/IAP/Analytics nur über Community-Plugins (AdMob-Plugin 625 Sterne, RevenueCat-Port 31 Sterne), kein GameAnalytics/Adjust/AppsFlyer-Binding. LLMs verwechseln häufig Godot-3- und -4-APIs. **Plan B**, falls das Spiel je Massen-Sprites braucht. |
| Defold | Gute Monetarisierungs-Extensions, aber Lua (dynamisch typisiert → schwächerer TDD-Loop), kleine Community, UI-Arbeit zäh. |
| Cocos | Stark in Asien, englische Doku dünn, Firmenstrategie unklar. |
| Bevy (Rust) | Mobile 2026 „möglich, aber nicht einfach“, nicht priorisiert. |
| Reines Flutter ohne Flame | Für ein Grid-Spiel grundsätzlich möglich (`CustomPainter`), aber Flame liefert Partikel, Effekte, Sprite-Batching, Game-Loop und `flame_test` – das lohnt sich für den „Juice“. |

## 5. Grenzfälle / Revision

- **Wenn** später ein Modus mit über 500 gleichzeitigen Entities nötig wird: Benchmark-Spike mit `drawAtlas`/`SpriteBatch` und Struct-of-Arrays in Flame; scheitert er, Wechsel des Renderers auf Godot 4.x – die Logik in `game_core` bleibt.
- **Wenn** ein Publisher-Deal mit Unity-first-SDKs kommt: neu bewerten.
- Flame 2.0 (Breaking Changes) erst migrieren, wenn stabil; eigenes Epic.

## 6. Konkrete Versionen (Stand 2026-10-02)

Siehe Package-Liste und Projektstruktur in `docs/recherche/engine-vergleich.md`, Abschnitt 3, sowie `.claude/skills/flutter-dart/SKILL.md`.
