# Stand

Aktueller Projektstand. Wird vom Agenten nach jeder Statusänderung gepflegt.
Maßgeblich sind die GitHub-Issues; diese Datei ist die Kurzfassung.

**Zuletzt aktualisiert:** 2026-10-02

**Projekt:** „Rune Rush“ (Arbeitstitel) – Match-3-Roguelite für Android und iOS, Flutter + Flame. Konzept: `docs/spielkonzept.md`. Entscheidungen: `docs/entscheidungen/`.

## In Arbeit

- – (noch keine Story in Umsetzung)

## Zum Test

- –

## Als Nächstes

- #14 Flutter-Monorepo mit game_core und CI-Pipeline (`ready`, Tasks #41 → #42 → #43) – **braucht eine Session mit Flutter-SDK** (Cloud-Sessions haben keins; siehe `.claude/skills/flutter-dart/SKILL.md`, Abschnitt 3) oder Arbeit über CI-Feedback.
- #15 Hauptmenü, leere Spielszene und Einstellungen
- #17 Brett mit Matches, Nachrutschen und Kaskaden

## Backlog nach Initiative → Epic

**#4 Technisches Fundament und Release**

| Epic | Stand | Stories (Reihenfolge) |
|---|---|---|
| #6 Projektgerüst – App startet auf Android und iOS mit grüner CI | 0 von 3 zu | #14 → #15 → #16 |
| #12 Messbar – Analytics und Crash-Reporting | 0 von 2 zu | #36 → #37 |

**#1 Fesselndes Kernspiel**

| Epic | Stand | Stories (Reihenfolge) |
|---|---|---|
| #7 Spielbarer Prototyp – ein kompletter 8-Stufen-Run mit Runen | 0 von 7 zu | #17 → #18 → #19 → #20 → #21 → #22 → #23 |
| #8 Juice – das Spiel fühlt sich gut an | 0 von 2 zu | #24 → #25 |

**#2 Langzeitmotivation**

| Epic | Stand | Stories (Reihenfolge) |
|---|---|---|
| #9 Runen-Album, Freischaltungen und Stakes | 0 von 3 zu | #26 → #27 → #28 |
| #10 Täglicher Grund zurückzukommen – Daily Seed, Streak und Leaderboard | 0 von 3 zu | #29 → #30 → #31 |

**#3 Faire Einnahmen**

| Epic | Stand | Stories (Reihenfolge) |
|---|---|---|
| #11 Erste Einnahmen – Rewarded Ads und Werbefrei-Kauf | 0 von 4 zu | #32 → #33 → #34 → #35 |

**#5 Spieler finden und halten**

| Epic | Stand | Stories (Reihenfolge) |
|---|---|---|
| #13 Geschlossener Test mit 12 Testern über 14 Tage läuft | 0 von 3 zu | #38 → #39 → #40 |

**Empfohlene Reihenfolge über Epics hinweg:** #6 → #7 → #12 → #8 → #9 → #13 → #11 → #10 (Version 0.1 = #6 + #7; Version 0.2 = + #12, #8, #9, #13; Version 0.3 = + #11, #10).

**Ruht**

- –

## Zuletzt erledigt

- Planungsstruktur, Recherche (Markt, Engine, Design), Spielkonzept, CLAUDE.md, Skill-Datei, Issue-Vorlagen, Labels, 5 Initiativen, 8 Epics, 27 Stories, 3 Tasks angelegt (2026-10-02, ohne PR – Initial-Commit)

## Offene Entscheidungen (nur der Mensch)

1. **Spielkonzept bestätigen** – Match-3-Roguelite „Rune Rush“ (`docs/entscheidungen/0003-spielkonzept.md`). Alternativen B (One-Thumb-Survivor) und C (Cozy Idle-Merge) sind dort beschrieben. Alle Initiativen #1–#5 und Epics #6–#13 sind neu angelegt – bitte bestätigen oder umsortieren.
2. **Engine bestätigen** – Flutter + Flame mit reinem Dart-`game_core` (`docs/entscheidungen/0002-engine-flutter-flame.md`).
3. **Monetarisierung** – Free-to-Play fair (empfohlen) oder Premium 4,99 € + Demo? Preis für „Werbefrei“ (Vorschlag 3,99 €).
4. **Name** – „Rune Rush“ ist Arbeitstitel; endgültiger Name braucht Marken-/Store-Prüfung. Paketname-Vorschlag `de.maestrodev.runerush`.
5. **Art-Richtung** – flache Vektorformen (vom Agenten in Code/SVG erzeugbar, Vorschlag in `docs/spielkonzept.md`, Abschnitt 7) oder gekaufte/gezeichnete Assets? Spieler lehnen erkennbar KI-generierte Grafik ab.
6. **Status-Label `test`** – projektspezifische Ergänzung zur Planungsstruktur (Story wartet auf Test durch den Menschen, damit der Agent nicht blockiert). Siehe CLAUDE.md, „Mergen“. Bestätigen oder streichen.
7. **Arbeitsumgebung des Agenten** – Cloud-Sessions erreichen `pub.dev`/`storage.googleapis.com` nicht (Flutter nicht installierbar, geprüft 2026-10-02). Optionen: (a) Implementierungs-Tasks in lokalen Claude-Code-Sessions mit Flutter, (b) Netz-Allowlist der Organisation um `storage.googleapis.com`, `pub.dev`, `dl.google.com`, `maven.google.com`, `repo1.maven.org`, `services.gradle.org` erweitern, (c) Agent arbeitet in der Cloud nur über CI-Feedback (langsam, aber möglich).
8. **Accounts anlegen** (Mensch): Google Play Developer (25 $, danach 14-Tage-Test mit 12 Testern Pflicht), Apple Developer Program (99 $/Jahr), Firebase-Projekt, AdMob, RevenueCat. Secrets als GitHub-Secrets, nie im Repo.
9. **Repo-Einstellungen** (Mensch): Branch-Protection auf `main` (Required check `check`), „Automatically delete head branches“ aktivieren.
10. **Projektanweisung** für das Claude-Projekt „Game“ aus `docs/PROJEKTANWEISUNG.md` in die Projekt-Einstellungen übernehmen.
