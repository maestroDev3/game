# Spielkonzept: „Rune Rush“ (Arbeitstitel)

**Genre:** Match-3-Roguelite · **Plattform:** Android, iOS · **Monetarisierung:** Free-to-Play, fair
**Stand:** 2026-10-02 · Entscheidung: `docs/entscheidungen/0003-spielkonzept.md` · Pflege: wird vom Agenten aktualisiert, wenn der Mensch Entscheidungen trifft (Datum notieren).

> **Elevator-Pitch:** Match-3, bei dem du die Regeln brichst. Jedes Match zählt Basis × Multiplikator. Runen schreiben das Spiel um. Schaffst du acht Bretter, bevor dir die Züge ausgehen?

---

## 1. Spielerfahrung in 90 Sekunden

1. App öffnen → **„Spielen“** → sofort ein 7×7-Brett. Kein Login, kein Tutorial-Text über 8 Wörter.
2. Zwei Steine tauschen, drei gleiche in einer Reihe → Punkte fliegen hoch, das Brett rutscht nach, eine Kaskade zündet, der Multiplikator springt auf ×2. **Aha-Moment nach spätestens 60 s.**
3. Ziel erreicht → Münzen → **Shop: drei Runen, eine darf mit.** „Rote Steine zählen doppelt“ – ab jetzt jagt man Rot.
4. Nächstes Brett: Ziel höher, aber mit der Rune ist es machbar. Die Spannung kommt aus „reicht es in 12 Zügen?“.

## 2. Core Loop

```
 ┌──────────────────────────────────────────────────────────────┐
 │  Brett (60–120 s)  →  Münzen  →  Shop (1 aus 3 Runen)  →  … │
 │      ↑                                            │          │
 │      └──────── Stufe 3, 6 und 8: Boss-Regel ◄─────┘          │
 └──────────────────────────────────────────────────────────────┘
   8 Bretter = 1 Run (15–20 min) → Run-Ergebnis → Album/Freischaltungen
```

### 2.1 Brett

- 7×7 Felder, 5 Steinfarben (Stufe 1–2: 4 Farben). Seed-basiert erzeugt; der Generator garantiert mindestens einen gültigen Zug und kein Match im Startzustand.
- **Zug:** zwei benachbarte Steine tauschen; nur gültig, wenn ein Match (≥ 3 in Reihe/Spalte) entsteht. Ungültige Tausche kosten keinen Zug (Wackel-Animation).
- **Spezialsteine:** 4er → Linienstein (räumt Zeile/Spalte), L/T → Bombe (3×3), 5er → Farbstein (entfernt eine Farbe). Standard-Match-3-Vokabular, kein neues Lernen.
- **Zugbudget** je Brett (Standard 12), **Zielpunktzahl** steigt pro Stufe. Ziel erreicht → Brett sofort gewonnen, übrige Züge werden zu Bonus-Münzen. Züge aufgebraucht ohne Ziel → **Run endet**.
- **Beinahe-Sieg** (≥ 80 % des Ziels): einmal pro Run „+3 Züge“ gegen Rewarded Ad oder Münzen. Das Brett bleibt sichtbar, der Spieler sieht, was er damit schaffen könnte.

### 2.2 Scoring (das Herz des Spiels)

```
Punkte(Match) = Basis × Mult
  Basis = Σ Steinwert (Standard 10 je Stein) + Boni aus Runen
  Mult  = 1 + Kaskadenstufe + Boni aus Runen
Brett-Punkte = Σ Punkte(alle Matches)
```

- Jede Kaskade (Matches, die durch Nachrutschen entstehen) erhöht Mult um +1 für den ganzen Zug.
- Spezialsteine geben feste Basis-Boni (Linie +30, Bombe +50, Farbstein +100).
- Runen greifen über **Effekt-Hooks** ein: `onMatch`, `onCascade`, `onBoardStart`, `onBoardEnd`, `onMoveUsed`, `onShop`. Jede Rune ist ein Datensatz (JSON) + ein Hook-Handler; neue Runen brauchen keinen neuen Code, solange der Hook existiert.
- **Zahlen eskalieren sichtbar** (Balatro-Prinzip): Ziel Stufe 1 ≈ 300, Stufe 8 ≈ 15 000. Ohne Runen-Synergien unschaffbar, mit ihnen „ein Gefühl von Betrug zu eigenen Gunsten“.

### 2.3 Shop

- Nach jedem Brett: **3 Runen** zur Auswahl (Seltenheit gewichtet), eine kaufbar mit Münzen; **Reroll** kostet Münzen (steigend) – zusätzlich bis zu 3 Rerolls pro Run gegen Rewarded Ad.
- **5 Runen-Slots.** Runen verkaufen gibt die Hälfte zurück.
- Später (nicht MVP): Verbrauchsgegenstände („Tränke“: Mischen, +2 Züge, Farbe tauschen) und Brett-Modifikatoren (6×6, 8×8, 4 Farben).

### 2.4 Boss-Bretter (Stufe 3, 6, 8)

Eine Sonderregel, vorher angekündigt, damit der Spieler im Shop darauf reagieren kann:

| Boss | Regel |
|---|---|
| Der Blinde | Eine zufällige Farbe zählt 0 Punkte |
| Der Geizige | Nur 8 Züge |
| Der Zöllner | Jedes Match kostet 1 Münze |
| Der Spiegel | Nur vertikale Matches zählen |
| Der Hastige | Jeder zweite Zug ohne Match kostet 2 Züge |
| Der Nebel | Das Brett ist bis zum ersten Zug verdeckt |
| Der Richter (Stufe 8) | Ziel ×1,5, aber Mult startet bei 3 |

### 2.5 Runen (MVP: 15, Ziel v1.0: 60+)

Seltenheit: gewöhnlich (60 %), selten (30 %), episch (9 %), legendär (1 %).

| Rune | Seltenheit | Effekt (Hook) |
|---|---|---|
| Glutrune | gewöhnlich | Rote Steine +15 Basis (`onMatch`) |
| Frostrune | gewöhnlich | Blaue Steine +15 Basis |
| Moosrune | gewöhnlich | Grüne Steine +15 Basis |
| Kettenrune | gewöhnlich | Jede Kaskade +2 Mult statt +1 (`onCascade`) |
| Geduld | gewöhnlich | +3 Münzen je übrigem Zug (`onBoardEnd`) |
| Vierer | selten | 4er-Matches ×3 Mult |
| Echo | selten | Der erste Zug jedes Bretts wird doppelt gewertet (`onBoardStart`) |
| Gier | selten | +1 Münze je Match, Ziel +10 % |
| Sammler | selten | Zähler: je 10 gematchte Steine einer gewählten Farbe +1 Mult dauerhaft |
| Wachstum | selten | +1 Mult dauerhaft je geschafftem Brett |
| Risiko | episch | Zugbudget −3, Mult ×2 |
| Zwilling | episch | Kopiert den Effekt der linken Nachbar-Rune |
| Phönix | episch | Einmal pro Run: Züge aufgebraucht → +5 Züge, Rune verbrennt |
| Leere | legendär | Spezialsteine zählen ×5 Basis |
| Krone | legendär | Mult wird am Brettende quadriert, aber Shop-Preise ×2 |

Regel für neue Runen: **jede neue Rune muss mit mindestens zwei bestehenden sinnvoll interagieren** (Synergie oder Spannung).

## 3. Meta-Progression (warum morgen wieder?)

| Element | MVP | v1.0 |
|---|---|---|
| **Runen-Album** – jede gesehene Rune wird eingetragen, mit Statistik „gewonnen mit“ | ja | ja |
| **Freischaltungen** – Runen durch Run-Ziele („Gewinne mit 3 gewöhnlichen Runen“, „Erreiche 50 000 Punkte auf einem Brett“) | 5 Ziele | 40+ Ziele |
| **Stakes** – Schwierigkeitsstufen 1–8, je Sieg die nächste; ändern Ziel-Kurve, Shop-Preise, Boss-Häufigkeit | Stufe 1–3 | 1–8 |
| **Brett-Varianten** – 6×6 mit 4 Farben, 8×8, „Nur Spezialsteine zählen“ … | – | ja |
| **Daily Seed** – ein Run pro Tag für alle gleich, Streak mit Freeze (1 Freeze/Woche gratis), asynchrones Leaderboard | – | ja (Epic „Täglicher Grund“) |
| **Wöchentlicher Mutator** – eine Regel der Woche (z. B. „Kaskaden ×2“) als günstiger Event-Ersatz | – | ja |
| **Themes** – Kosmetik (Steinformen, Hintergründe, Partikel), Teil freischaltbar, Teil kaufbar | 1 | 6+ |
| **Statistik** – Siege, beste Bretter, Lieblingsrunen | einfach | voll |

Kein Spielvorteil ist kaufbar. Fortschritt gibt es nur durch Spielen.

## 4. Session-Design

- **Kerneinheit:** ein Brett, 60–120 s. **Run:** 15–20 min, nach jedem Zug pausierbar, Autosave – ein Run kann über den Tag verteilt gespielt werden.
- Ziel-Kennzahlen (GameAnalytics-Top-25 % als Messlatte): Sessionlänge ≈ 5 min, 5+ Sessions/Tag, **D1 ≥ 35 %, D7 ≥ 10 %**, Aha-Moment < 60 s, Tutorial-Abbruch < 10 %.
- Keine Energie, keine Leben, keine Wartezeiten.

## 5. Monetarisierung (fair, EU-konform)

| Hebel | Platzierung | Regel |
|---|---|---|
| **Rewarded Ad** (opt-in) | Shop-Reroll (max. 3/Run), „+3 Züge“ beim Beinahe-Sieg (1×/Run), Tagesbonus verdoppeln | Immer freiwillig, nie im Core Loop erzwungen |
| **Werbefrei** (IAP, ~3,99 €) | Entfernt alle Werbung; Rewarded-Vorteile bleiben ohne Ad erhalten | Wichtigster IAP bei Ad-getragenen Spielen |
| **Kosmetik** (1,99–2,99 €) | Themes, Partikel-Sets, Steinformen | Kein Spielvorteil |
| **Supporter-Pack** (~4,99 €) | Werbefrei + 2 Themes + Danke-Badge | – |
| **Saison-Pass** (später, ~4,99 €, 4–6 Wochen) | Gratis-Spur + Premium-Spur, nur Kosmetik/Komfort | Erst, wenn Mutator-Events laufen |
| **Interstitials** | **MVP: keine.** Später ggf. nach Run-Ende mit Frequenz-Cap, per Remote Config schaltbar, datengetrieben entscheiden | Nie mitten im Brett |

**Verbotsliste** (bindend, siehe CLAUDE.md): Leben/Energie · bezahlte Zufallsitems · zweite Premiumwährung · Countdown-Angebote · Confirmshaming · Streak-Verlust ohne Freeze · Push zwischen 22 und 7 Uhr · Pflicht-Ads im Core Loop · Casino-Optik (Slot-Walzen, Chips, Jetons).

Preise werden in Landeswährung angezeigt (Store-Preise), keine verschleiernden Pakete.

## 6. Technik (Kurzfassung, Details in `.claude/skills/flutter-dart/SKILL.md`)

- Flutter ≥ 3.44, Flame 1.38.x, Riverpod 3, go_router; reines Dart-Package `game_core` für Simulation, Scoring, Runen, Run-Ablauf, Seeded-RNG, Save-Schema.
- Runen und Balancing-Werte als JSON in `assets/balancing/`, später über Firebase Remote Config überschreibbar.
- **Simulator/Bot** (`game_core`): spielt Tausende Runs mit einfacher Heuristik → Win-Rate je Stufe, Runen-Pick-Rate, Ziel-Kurve. Pflicht vor jeder Balancing-Änderung.
- Analytics-Events (Firebase): `board_start`, `board_end(win, moves_left, score, target)`, `run_end(stage, cause)`, `shop_pick(rune, rarity)`, `shop_reroll(source)`, `rewarded_ad(placement, completed)`, `ftue_step`.
- Lokalisierung EN/DE (ARB). Farbenblind-Modus: Steine unterscheiden sich zusätzlich in der Form.

## 7. Art-Richtung (offen, Vorschlag)

Flache, kräftige Vektorformen auf dunklem Grund; Steine = geometrische „Runensteine“ mit eingraviertem Symbol (Form + Farbe = doppelt kodiert). Partikel und Tweens tragen den „Juice“: Squash & Stretch beim Nachrutschen, Hit-Stop bei Kaskaden, Zahlen, die größer und wärmer werden, je höher der Mult. Sound: geschichtete Töne, die mit jeder Kaskade eine Stufe höher gehen.

## 8. Umfang nach Versionen

| Version | Enthält | Ziel |
|---|---|---|
| **0.1 Prototyp** (intern) | Brett, Matching, Spezialsteine, Scoring, Zugbudget, 8-Stufen-Run, Shop mit 15 Runen, 3 Bosse, Bot-Simulator, Platzhalter-Grafik | „Macht es Spaß?“ – 5 Tester, Beobachtung |
| **0.2 Geschlossener Test** (Play Internal/Closed) | Juice-Paket, Album, 5 Freischaltungen, Stakes 1–3, Analytics, Crashlytics, EN/DE, Settings, Autosave | D1/D7 messen, 12 Tester über 14 Tage (Play-Pflicht) |
| **0.3 Soft Launch** (Android, 1–2 Länder) | Rewarded Ads, Werbefrei-IAP, 30 Runen, 7 Bosse, Daily Seed + Streak, Remote Config | Monetarisierung und Retention validieren |
| **1.0 Launch** (Android + iOS) | 60+ Runen, Stakes 1–8, Mutator-Woche, Themes, Leaderboard, Store-Listing, Community-Start (Reddit, Discord) | Organisches Wachstum |
| **1.x** | Saison-Pass, Brett-Varianten, Tränke, weitere Bosse, ggf. Steam | Einnahmen |

## 9. Risiken und Gegenmaßnahmen

| Risiko | Gegenmaßnahme |
|---|---|
| Balancing kippt (zu leicht/zu schwer, dominante Runen) | Bot-Simulator in CI, Ziel-Win-Rate je Stake definiert, Pity-Mechanik im Shop (nach 3 Shops ohne seltene Rune garantiert eine) |
| Match-3 fühlt sich „alt“ an | Scoring-Eskalation und Runen tragen die Neuheit; früher Tester-Check in 0.1 |
| Zu wenig Juice (Solo, kein Art-Team) | Juice-Paket als eigenes Epic mit Checkliste; Sound/Partikel-Bibliotheken; Vektor-Stil statt Illustration |
| Niemand findet das Spiel | Community vor Launch (Balatro-/Roguelite-Subreddits, Creator), Daily-Seed als Share-Anlass, Store-Listing-Tests |
| Store-Ablehnung/Compliance | Privacy Manifest, UMP-Consent, Target-SDK 36, 16-KB-Pages, keine Kinder-Zielgruppe – Checkliste im Release-Epic |

## 10. Ideenspeicher (Initiative #44 „Neue Spielmodi und Folgespiele“)

Ideen durchlaufen immer denselben Weg: Konzeptskizze → Spike → Entscheidung (Modus in Rune Rush, eigenes Spiel, verworfen). Sie konkurrieren nicht mit Version 0.1.

| Idee | Herkunft | Stand | Kurzbild |
|---|---|---|---|
| **Roguelike Tower Defense** | Wunsch des Menschen (03.10.2026) | Epic #45, Stories #46 (Konzept), #47 (Spike) | Prozedurale Pfade, Türme als Daten mit Synergien, 1-aus-3-Wahl nach jeder Welle, Runs. Zwei Varianten zu prüfen: Modus „Runen-Verteidigung“ in Rune Rush (Türme = Runen, Wellen = Bretter, gleicher Shop) oder eigenes Spiel. Vorbilder: PvZ, Isle of Arrows, Rogue Tower, Kingdom Rush, Emberward. Flame-Grenze beachten (Gegnerzahl, siehe 0002). |
| **„Lantern Swarm“** – One-Thumb-Survivor, 5-Minuten-Runs | Design-Dossier, Skizze B | Idee | Höchstes F2P-Potenzial, aber Massen-Sprites (Benchmark nötig) und viel Juice/Art. |
| **„Moosgarten“** – Cozy Idle-Merge mit genetischen Pflanzen | Design-Dossier, Skizze C | Idee | Breiteste Zielgruppe, längste Retention; Deko-Content und Idle-Mathe sind der Aufwand. |
