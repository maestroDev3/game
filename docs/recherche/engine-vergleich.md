# Engine-Entscheidung für ein monetarisiertes 2D-Casual-Mobile-Game (Solo + Flutter-Vorwissen + KI-Agent)

*Stand: 2. Oktober 2026. Versionsangaben stammen von pub.dev, GitHub und den Hersteller-Blogs (Quellen am Ende).*

## TL;DR

**Empfehlung: Flutter + Flame (flame 1.38.x)** in einer **Hybrid-Architektur**. Shop, Battle Pass, Menüs und Progression laufen als normale Flutter-Widgets, nur die Gameplay-Szene als Flame-`GameWidget`. Die Spiellogik liegt in einem **reinen Dart-Package**, das ohne Flutter testbar ist. Dafür sprechen:
- Ads, IAP und Firebase: die offiziellen Plugins von Google, Firebase, RevenueCat und Unity werden aktiv gepflegt.
- Der KI-Agent arbeitet am besten mit diesem Stack: alles ist Code, Tests laufen headless, CI auf Linux.
- Das vorhandene Flutter-Wissen lässt sich direkt nutzen.

**Der eine harte Vorbehalt:** Ein Survivor-like mit 500+ Gegnern und vielen Partikeln geht in Flame nur, wenn man datenorientiert arbeitet: Batch-Rendering über `drawAtlas`, kein Component-Objekt pro Gegner, eigene Spatial-Hash-Kollision. Das wird in Sprint 1 mit einem Benchmark-Spike auf einem Mittelklasse-Android-Gerät geprüft. Fällt der Test durch, ist **Godot 4.7** der Plan B.

---

## 1. Kandidaten im Überblick (Stand 2026)

| Engine | Aktueller Stand | Lizenz/Kosten |
|---|---|---|
| **Flutter + Flame** | flame 1.38.2 (27.08.2026), braucht Flutter ≥ 3.41. Prerelease 2.0.0-dev.0 mit Breaking Changes ist erschienen | MIT/BSD, kostenlos |
| **Reines Flutter** | Flutter 3.44 (Mai 2026). Impeller ist auf Android Standard (Vulkan, Fallback OpenGL ES) | BSD, kostenlos |
| **Unity 6** | 6.3 LTS. Die Runtime Fee wurde am 12.09.2024 gestrichen | Personal kostenlos bis 200.000 $ Umsatz und Funding, Splash-Screen optional. Pro kostet seit 12.01.2026 2.310 $/Jahr pro Seat |
| **Godot** | 4.6 (Jan. 2026), 4.7 (Juni 2026), 4.8 in Entwicklung | MIT, kostenlos |
| **Defold** | 1.13.0 (H1 2026). Vulkan ist auf Android Standard, offizielle Crashlytics-Extension | Defold License (Apache-2.0-Derivat), keine Royalties |
| **Cocos** | Creator 3.8 LTS. „COCOS 4“ ist seit 04.01.2026 komplett MIT-Open-Source | MIT, kostenlos |
| **Bevy** | 0.18. Mobile laut Maintainern „möglich, aber nicht einfach“ | MIT/Apache, kostenlos |

## 2. Bewertungsmatrix (1 = schwach, 5 = stark)

| Kriterium | Flutter+Flame | Flutter pur | Unity 6 | Godot 4.6/4.7 | Defold | Cocos | Bevy |
|---|---|---|---|---|---|---|---|
| 1. Mobile-Reife / 500+ Sprites @60 fps | 3 | 2 | **5** | 4 | 4 | 4 | 2 |
| 2. Ads/IAP/Analytics-Plugins | **5** | **5** | **5** | 2–3 | 4 | 3 | 1 |
| 3. Eignung für KI-Agent und CI | **5** | **5** | 2 | 4 | 3 | 3 | 4 |
| 4. Kosten/Compliance | 5 | 5 | 3 | 5 | 5 | 5 | 5 |
| 5. UI-lastige Meta-Screens | **5** | **5** | 3 | 3–4 | 2 | 3 | 1 |
| 6. Community/kommerzielle Referenzen | 2–3 | 3 | **5** | 3 | 3 | 4 (Asien) | 1 |
| 7. Risiko (5 = gering) | 3 | 4 | 3 | 3 | 3 | 2 | 1 |

### Begründung je Kriterium

**1. Performance.** Ein Benchmark von Filip Hráček (Aug. 2024, bisher der einzige direkte Vergleich) hat identische 2D-Szenen gemessen. Grenze für 60 fps auf einem iPad Air 4:
- Unity: etwa 3.000+ Entities
- Flame: etwa 800
- reines Flutter: etwa 600
- Godot: auf iOS keine verlässlichen Werte

Auf Flutter-Seite hat sich seither einiges verbessert:
- Flame 1.35 bis 1.37 bringen SpriteBatch-Optimierungen (Free List, Bleed), `ComponentPool` und das Mixin **`HasAutoBatchedChildren`** („ein Draw-Call pro Atlas“).
- Impeller ist auf Android Pflicht. Laut State of Flutter 2026 kann man es seit Flutter 3.38 auf Android nicht mehr abschalten.

Ein Mittelklasse-Android ist deutlich schwächer als ein A14-iPad. **Meine Schätzung:** Mit naiven `SpriteComponent`s pro Gegner wird es bei 500 Gegnern knapp. Datenorientiert (Arrays plus ein Renderer mit `drawAtlas`) sind mehrere Tausend Sprites realistisch. Das muss gemessen werden.

Für Match-3, Merge, Idle und Tower Defense ist Flame mehr als ausreichend. Godot und Defold sind bei Sprite-Massen klar stärker. Godot hatte auf Android lange eine Crashrate von etwa 4 %. Mit 4.5.2/4.6 liegt sie unter 1 % (Fixes an Vulkan und GPU-Treibern).

**2. Monetarisierung.** Flutter hat das reifste Ökosystem außerhalb von Unity:
- `google_mobile_ads` 9.1.0 (verifiziert google.dev, ca. 900k Downloads pro Woche), inklusive UMP-Consent
- offizielle Mediation-Adapter wie `gma_mediation_applovin` 2.6.4
- `applovin_max` 4.6.4 (Repo von AppLovin)
- `unity_levelplay_mediation` 9.2.0 (ironSource/LevelPlay, verifiziert unity.com)
- `purchases_flutter` 10.14.0 (RevenueCat, Release vom 01.10.2026)
- `in_app_purchase` 3.3.1 (flutter.dev, StoreKit 2 als Standard)
- FlutterFire: `firebase_core` 4.15.0, `firebase_analytics` 12.6.0, `firebase_crashlytics` 5.4.0, `firebase_remote_config` 6.7.0

Godot im Vergleich:
- Die Foundation pflegt nur Play Billing, Play Games Services und StoreKit 2.
- AdMob gibt es nur über Community-Plugins (poingstudios, 625 Sterne, ab Godot 4.5).
- Firebase und RevenueCat gibt es nur als kleine Community-Ports (godot-x/revenuecat: 31 Sterne).
- Laut einer Analyse liefern GameAnalytics, Amplitude, Adjust und AppsFlyer keine Godot-Bindings.

Defold hat dagegen offizielle Extensions für AdMob, AppLovin MAX, ironSource, IAP, Firebase Analytics/Remote Config/Crashlytics und Push.

**3. KI-Agent und CI.** Flutter und Flame bestehen zu 100 % aus Code: keine Szenen-Binärdateien, keine GUIDs, kein Editor nötig. Gut geeignet sind:
- `dart test` für die Logik
- `flame_test` 2.3.1 mit `testWithFlameGame` und `testGolden`
- Widget- und Golden-Tests
- Builds für APK/AAB auf `ubuntu-latest`

Godot ist ebenfalls gut geeignet: `.tscn`/`.tres` sind Textdateien, es gibt einen Headless-Modus und die gdUnit4-Action (v1.3.2). Aus meiner Erfahrung verwechseln LLMs aber häufig die APIs von Godot 3 und 4.

Unity ist für einen autonomen Agenten am schwächsten:
- YAML-Szenen und Prefabs mit GUIDs und `.meta`-Dateien
- schwere Editor-Images in der CI
- Lizenzaktivierung per `.ulf` über GameCI

Defold hat Text-Protobuf-Dateien und baut headless mit `bob.jar`. Die Tests (DefTest/Telescope) sind aber weniger etabliert, und Lua ist dynamisch typisiert. Das schwächt den TDD-Feedback-Loop.

**IPA-Builds brauchen bei allen Engines einen macOS-Runner** (Xcode 26).

**4. Compliance (alle Engines erfüllbar, man muss aber aktiv werden).**
- **Google Play:** Seit 31.08.2026 müssen neue Apps und Updates **API 36** anpeilen. Eine Verlängerung ist bis 01.11.2026 möglich.
- **16 KB Page Size:** Laut Android-Doku werden Updates ohne 16-KB-Support ab **01.02.2027** blockiert. Die Frist wurde schon zweimal verschoben (zuvor 01.11.2025 und 31.05.2026).
  - Flutter ist ab etwa 3.24 konform.
  - Unity ab 6000.0.38f1 bzw. 2022.3.56f1.
  - Godot ab 4.5.
  - Problematisch sind native Fremd-SDKs.
- **Apple:** Seit 28.04.2026 Pflicht ist Xcode 26 mit iOS-26-SDK. Seit 09.09.2026 muss das Minimum-Target iOS 13 oder höher sein. Außerdem braucht jede App `PrivacyInfo.xcprivacy` inklusive der Manifeste aller SDKs. Die offiziellen Flutter-Plugins liefern diese mit.
- **Flutter 3.44** nutzt SwiftPM als Standard statt CocoaPods und bringt AGP 9 mit eingebautem Kotlin.

**5. Meta-Screens.** Hier liegt der größte Hebel für Flutter. Shop, Battle-Pass-Leiste, Daily Rewards, Inventar und Settings sind Standard-Widgets. Sie sind schnell gebaut und mit Golden-Tests absicherbar. In Unity, Godot und Defold ist diese UI-Arbeit erfahrungsgemäß deutlich zäher. Bei Defold hilft die GUI-Library Druid nur teilweise.

**6. Referenzen.**
- **Flame:** keine bekannten Top-Grosser. Die awesome-flame-Liste nennt viele kleine Store-Titel (Casual, Tower Defense, Puzzle). Das Flutter Casual Games Toolkit zeigt u. a. I/O Flip, I/O Pinball und 4 Pics 1 Word und liefert Templates mit Ads, IAP und Crashlytics.
- **Godot:** Brotato (auch mobil), Rift Riff, Kamaeru, Spin Hero. Überwiegend Premium-Titel.
- **Defold:** Family Island (Melsoft, 50 Mio.+ Installationen auf Android), Merge Hotel, Hero Village. Partner sind u. a. MoonActive, Poki und Rive.
- **Cocos:** stark im asiatischen Top-Grossing-Segment, englische Doku dünn.
- **Unity:** Branchenstandard für Hybrid-Casual.

**7. Risiken.**
- **Flame:** Bus-Faktor beim Blue-Fire-Team (Finanzierung über OpenCollective und Sponsoren). Die 2.0-Migration bringt Breaking Changes (u. a. Umbenennungen, neues Partikelsystem). Es gibt keinen Szenen- oder Partikel-Editor.
- **Flutter:** Laut State of Flutter 2026 hat u. a. der Impeller-Gründer das Team verlassen.
- **Unity:** Vertrauensschaden durch die Runtime Fee (2023 angekündigt, 2024 gestrichen). Jährliche Preiserhöhungen: Pro +8 % 2025, +5 % 2026.
- **Godot:** fragmentierte Mobile-Plugins, Plugin-Templates ändern sich zwischen Versionen.
- **Defold:** kleine Community, Lua.
- **Cocos:** Strategie der Firma SUD, Doku.
- **Bevy:** Mobile ist in absehbarer Zeit nicht priorisiert.

---

## 3. Empfehlung: Flutter + Flame, aber richtig geschnitten

**Warum genau dieser Kontext Flame begünstigt:**
1. Casual und Hybrid-Casual sind zu 50–70 % Meta-UI und LiveOps. Das ist Flutters Kernkompetenz.
2. Alle nötigen Monetarisierungs-SDKs gibt es als offizielle, aktuell gepflegte Plugins.
3. Der Agent bekommt einen schnellen, deterministischen Test-Loop ohne Editor, auf Linux.
4. Das Flutter-Wissen reduziert das Risiko für einen Solo-Entwickler.

**Leitplanken gegen die Flame-Risiken:**
- **Gameplay-Simulation in reinem Dart** (`game_core`): fester Zeitschritt, seeded RNG, keine Flame-Imports. Flame ist nur Renderer und Input. Damit bleibt im Notfall der Wechsel des Renderers möglich, und Tests laufen in Millisekunden.
- **Massen-Entities datenorientiert:** Struct-of-Arrays (`Float32List` für Positionen), ein `EnemyRenderer` mit `SpriteBatch`/`canvas.drawAtlas`, Spatial-Hash statt der Flame-Hitboxen, Pooling über `ComponentPool`.
- **Benchmark-Szene als CI-Artefakt** und manuell auf einem Referenzgerät (Mittelklasse, z. B. Snapdragon-6-Klasse): 500/1.000/2.000 Gegner, Frametimes im Profile-Modus.
- **Versionen pinnen** (`flame: 1.38.x`). Die Migration auf 2.0 erst nach dem Stable-Release als eigenes Issue.

### Konkrete Packages (Stand Okt. 2026)

```yaml
dependencies:
  flame: ^1.38.2
  flame_riverpod: ^5.5.5        # Brücke Riverpod <-> Flame (offiziell, flame-engine.org)
  flutter_riverpod: ^3.4.3
  flutter_soloud: ^5.1.5        # Low-Latency-Game-Audio (Alternative: flame_audio)
  google_mobile_ads: ^9.1.0     # inkl. UMP-Consent
  gma_mediation_applovin: ^2.6.4  # weitere gma_mediation_*-Adapter nach Bedarf
  # Alternative Mediation: applovin_max ^4.6.4 oder unity_levelplay_mediation ^9.2.0
  purchases_flutter: ^10.14.0   # RevenueCat: IAP, Battle Pass, Entitlements, Server-Validierung
  firebase_core: ^4.15.0
  firebase_analytics: ^12.6.0
  firebase_crashlytics: ^5.4.0
  firebase_remote_config: ^6.7.0  # + Firebase A/B Testing (Konsole)
  firebase_messaging: any         # Push, aktuelle Version pinnen
  go_router: any                  # aktuelle Version pinnen
dev_dependencies:
  flame_test: ^2.3.1
  flutter_test: { sdk: flutter }
  integration_test: { sdk: flutter }
  very_good_analysis: any         # strenge Lints, gut für den Agenten
```

Zusätzlich sinnvoll: `app_tracking_transparency` für den ATT-Prompt auf iOS. MMP-SDKs (Adjust/AppsFlyer) erst, wenn bezahlte User-Akquise startet.

**Mediation:** Mit AdMob plus Bidding-Adaptern starten, weil die Integration am einfachsten ist und Consent eingebaut ist. Ab nennenswerten DAU auf AppLovin MAX umsteigen. Deshalb alles hinter einem `AdService`-Interface kapseln.

### Projektstruktur (Pub-Workspace-Monorepo)

```
/
├─ pubspec.yaml              # workspace: [app, packages/*]
├─ CLAUDE.md                 # Regeln für den Agenten (s. u.)
├─ docs/adr/                 # Architekturentscheidungen
├─ app/                      # Flutter-App (android/, ios/)
│  ├─ lib/
│  │  ├─ main.dart / bootstrap.dart   # Firebase-Init, Crashlytics, DI
│  │  ├─ app/                # Router (go_router), Theme, Provider-Overrides
│  │  ├─ features/
│  │  │  ├─ gameplay/        # Flame: MyGame, Renderer, Input -> game_core
│  │  │  ├─ shop/  battle_pass/  progression/  settings/  # Widgets + Notifier
│  │  └─ services/           # ads/ iap/ analytics/ remote_config/ push/ save/
│  │                         #   je: interface + impl + fake (für Tests)
│  ├─ test/                  # unit/, widget/, goldens/, flame/
│  └─ integration_test/
├─ packages/
│  └─ game_core/             # reines Dart: Simulation, Economy, Balancing, Save-Schema
│     └─ test/               # dart test, ohne Flutter
├─ assets/                   # Texture-Atlanten, Audio, balancing/*.json
└─ .github/workflows/ ci.yml, release.yml
```

**State-Management:**
- **Riverpod 3** für Meta, Services und Economy. Notifier sind über `ProviderContainer` testbar.
- **Kein Riverpod im Frame-Loop.** Der Spielzustand lebt in `game_core`.
- Flame liest diesen Zustand und meldet Events (z. B. „Level geschafft“) über `flame_riverpod` zurück.
- Balancing-Werte kommen aus Remote Config mit lokalen JSON-Defaults.

**Test-Pyramide:**
1. `game_core`: TDD mit `dart test`, deterministisch (Seed, fester Zeitschritt). Ziel ≥ 90 % Coverage.
2. Flame: `testWithFlameGame` für Komponenten-Lifecycle und Input; `testGolden` für Rendering.
3. Meta-UI: Widget-Tests und Golden-Tests. **Goldens nur auf Linux erzeugen und prüfen** (Font-Rendering unterscheidet sich je Plattform).
4. Services: Fakes in Unit-Tests. Echte SDKs nur in `integration_test` (nightly, Android-Emulator, optional Firebase Test Lab).

**CLAUDE.md-Regeln für den Agenten:**
- `flutter analyze --fatal-infos` muss grün sein; Deprecations gelten als Fehler. Das verhindert veraltete Flame-APIs.
- `--update-goldens` nur, wenn das Issue eine visuelle Änderung verlangt.
- Keine neuen Dependencies ohne ADR.
- Performance-Änderungen immer mit Benchmark-Zahlen im PR.

### CI-Workflow (Skizze)

```yaml
name: ci
on: [pull_request, push]
jobs:
  test-android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with: { channel: stable, flutter-version: 3.44.x, cache: true }
      - run: dart pub get
      - run: dart format --output=none --set-exit-if-changed .
      - run: flutter analyze --fatal-infos
      - run: dart test packages/game_core
      - run: flutter test --coverage
        working-directory: app
      - run: flutter build appbundle --release   # Debug-Signing im PR
        working-directory: app
      - run: flutter build apk --release && $ANDROID_HOME/build-tools/*/zipalign -c -P 16 -v 4 build/app/outputs/flutter-apk/app-release.apk
        working-directory: app                   # 16-KB-Check
  build-ios:
    if: github.ref == 'refs/heads/main'          # macOS-Minuten sind teuer
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with: { channel: stable, flutter-version: 3.44.x, cache: true }
      - run: flutter build ios --release --no-codesign
        working-directory: app
```

**`release.yml` (auf Tag):**
- AAB mit dem Keystore aus Secrets signieren und auf den Play-Internal-Track hochladen.
- `flutter build ipa` mit fastlane match und App-Store-Connect-API-Key, Upload zu TestFlight.
- `targetSdk = 36` in `android/app/build.gradle.kts` explizit setzen.

---

## 4. Wann die Entscheidung anders ausfiele

- **Survivor-like/Bullet-Hell mit über 1.000 Entities, viel Partikel-Shader-Effekt oder Physik, und der Spike in Sprint 1 schafft keine 60 fps:**
  - → **Godot 4.7.** Textbasierte Szenen und der Headless-Modus funktionieren gut mit dem Agenten, Lizenz MIT.
  - Dafür kommen Mehraufwand bei Ads und Analytics über Community-Plugins und ein schwächeres UI-Tempo dazu.
  - Alternativ Defold, wenn Lua in Ordnung ist: Dort sind die Monetarisierungs-Extensions besser als bei Godot.
- **Publisher-Deal oder skalierte UA bei Hybrid-Casual:** Viele Publisher-SDKs sind nach meiner Branchenerfahrung Unity-first. Dazu kommt dichtes Mediation-Netzwerk-Tuning und ein späteres Team mit Unity-Know-how.
  - → **Unity 6.** Personal reicht bis 200.000 $ Umsatz und ist ohne Splash-Pflicht.
  - Preis dafür: Der KI-Agent ist mit YAML-Szenen deutlich weniger autonom.
- **Extrem kleine Binaries, Low-End-Märkte oder Web-Instant-Games (Poki):** → **Defold**.
- **China oder WeChat-Mini-Games:** → **Cocos**.
- **Match-3, Merge oder Idle ohne Massen-Sprites:** Flame bleibt die Wahl. Möglicherweise reicht auch **reines Flutter** (Grid plus `CustomPainter` und Animationen). Flame lohnt sich dann vor allem für Effekte und Partikel.
- **Bevy:** Für dieses Ziel 2026 nicht geeignet.

---

## Quellen

1. Flame Changelog (pub.dev): https://pub.dev/packages/flame/changelog
2. Flame Versionen: https://pub.dev/packages/flame/versions
3. Flame Releases / 2.0.0-dev.0: https://github.com/flame-engine/flame/releases/tag/flame-v2.0.0-dev.0
4. Flame Docs, SpriteBatch/HasAutoBatchedChildren: https://docs.flame-engine.org/latest/flame/rendering/images.html
5. Flame GitHub: https://github.com/flame-engine/flame
6. awesome-flame (Store-Titel): https://github.com/flame-engine/awesome-flame
7. Benchmark Flutter/Flame/Unity/Godot (F. Hráček): https://filiph.net/text/benchmarking-flutter-flame-unity-godot.html
8. Flutter Casual Games Toolkit: https://flutter.dev/games
9. What's new in Flutter 3.44: https://flutter.dev/blog/whats-new-in-flutter-3-44
10. State of Flutter 2026: https://devnewsletter.com/p/state-of-flutter-2026/
11. google_mobile_ads: https://pub.dev/packages/google_mobile_ads
12. gma_mediation_applovin: https://pub.dev/packages/gma_mediation_applovin
13. applovin_max: https://pub.dev/packages/applovin_max
14. unity_levelplay_mediation: https://pub.dev/packages/unity_levelplay_mediation
15. purchases_flutter: https://pub.dev/packages/purchases_flutter
16. in_app_purchase: https://pub.dev/packages/in_app_purchase
17. firebase_core / firebase_analytics / firebase_crashlytics / firebase_remote_config: https://pub.dev/packages/firebase_core, https://pub.dev/packages/firebase_analytics, https://pub.dev/packages/firebase_crashlytics, https://pub.dev/packages/firebase_remote_config
18. flame_test: https://pub.dev/packages/flame_test
19. flame_riverpod / flutter_riverpod: https://pub.dev/packages/flame_riverpod, https://pub.dev/packages/flutter_riverpod
20. flutter_soloud: https://pub.dev/packages/flutter_soloud
21. Unity Pricing Updates 2026: https://unity.com/products/pricing-updates
22. CG Channel, Unity-Preise 2026: https://www.cgchannel.com/2025/11/price-of-paid-unity-subscriptions-to-rise-but-free-subs-extended/
23. Unity cancels Runtime Fee: https://unity.com/blog/unity-is-canceling-the-runtime-fee
24. Unity 16 KB Support: https://discussions.unity.com/t/android-unity-engine-support-for-16-kb-memory-page-sizes-android-15/1589588
25. GameCI Unity-Aktivierung: https://game.ci/docs/github/activation/
26. Godot Release-Blog: https://godotengine.org/blog/release/
27. Godot Mobile Update April 2026: https://godotengine.org/article/godot-mobile-update-apr-2026/
28. Godot Mobile in 2026 (Ziva): https://ziva.sh/blogs/godot-mobile
29. Godot AdMob Plugin (poingstudios): https://github.com/poingstudios/godot-admob-plugin
30. Godot AdMob (godot-sdk-integrations): https://github.com/godot-sdk-integrations/godot-admob
31. Godotx RevenueCat: https://github.com/godot-x/revenuecat
32. gdUnit4 Action: https://github.com/marketplace/actions/gdunit4-test-runner-action
33. Godot und 16 KB (Forum): https://forum.godotengine.org/t/godot-and-google-play-policy-warning-about-16-kb-memory-page-size/120934
34. Defold H1 2026: https://defold.com/2026/06/30/Defold-H1-2026/
35. Defold License: https://defold.com/license/
36. Is Defold production ready?: https://defold.com/2023/09/28/Is-Defold-Production-Ready/
37. awesome-defold (Extensions/Testing): https://github.com/astrochili/awesome-defold
38. Defold Bob (CLI-Builds): https://defold.com/manuals/bob/
39. COCOS 4 Open Source (Jan. 2026): https://www.prnewswire.com/news-releases/cocos-4-is-here-fully-open-source-302652264.html
40. Cocos Creator Review 2026: https://engineranked.com/article/cocos-creator-review-2026/
41. Bevy Mobile-Diskussion: https://github.com/bevyengine/bevy/discussions/20998
42. Android 16 KB Page Sizes: https://developer.android.com/guide/practices/page-sizes
43. Google Play Policy-Deadlines 2026: https://primetestlab.com/blog/google-play-policy-updates-2026
44. Target API 36: https://median.co/blog/google-plays-target-api-level-requirement-for-android-apps
45. Flutter und 16 KB: https://medium.com/top-rail/you-have-until-may-31-2026-heres-how-to-fix-16kb-page-size-issue-on-flutter-apps-f2dbf6c2a6a3
46. Apple Upcoming Requirements: https://developer.apple.com/news/upcoming-requirements/
47. iOS-26-Compliance / Privacy Manifests: https://www.isyncevolution.com/blog/apple-app-store-purge
48. 2D-Mobile-Engines 2026 (Egmatic): https://egmatic.com/blog/best-mobile-game-engines-2d-2026

**Grenzen der Recherche:** Der Performance-Benchmark ist von 2024. Die Flame-Werte für 500+ Gegner auf Mittelklasse-Android sind meine Hochrechnung und müssen im Spike gemessen werden. Die Fps-Angaben im Cocos-Review sind nicht unabhängig geprüft.
