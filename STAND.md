# Stand

Aktueller Projektstand. Wird vom Agenten nach jeder Statusänderung gepflegt.
Maßgeblich sind die GitHub-Issues; diese Datei ist die Kurzfassung.

**Zuletzt aktualisiert:** 2026-10-03

**Projekt:** „Small Realms“ (Arbeitstitel) – rundenbasierte Pixel-Strategie für Android und iOS, kostenlos ohne Werbung. Konzept: `docs/spielkonzept.md`. Zweites Spiel des Portfolios (Beschluss: `maestroDev3/game`, `docs/entscheidungen/0005`).

**Stufe:** A (nur Doku). Stufe B1 (`packages/game_core`, Dart-CI) folgt nach Bestätigung des Konzepts; Stufe B2 (`app/`, Flutter-CI, Web-Build) sobald Rune-Rush-Epic #6 grün ist.

## Portfolio

- **Rune Rush** (`maestroDev3/game`): Planung steht, noch kein Code; nächste Story #14 (Monorepo + CI) ab 08.10.2026. Rune Rush hat Vorrang auf die Zeit des Menschen bis 1.0.
- Stories in `test` über beide Repos: 0 von max. 2.
- Dieses Spiel: ≈ 1 h/Woche vom Menschen; Headless-Entwicklung läuft ohne ihn.

## In Arbeit

- –

## Zum Test

- –

## Als Nächstes

- Issues anlegen (Initiativen, erstes Headless-Epic), sobald das Konzept bestätigt ist.

## Backlog nach Initiative → Epic

Noch keine Issues. Geplante Initiativen (werden nach Bestätigung angelegt):

1. **Fesselndes Kernspiel** – Regeln, Einheiten, Gelände, Schadensvorschau, Karten, Generator, KI, Bot-Turniere, Juice
2. **Langzeitmotivation** – Kampagne (≤ 8), Skirmish-Varianten, Sterne, Daily Skirmish, Seed-Codes, Statistik
3. **Faire Einnahmen** – Supporter-Kauf, Kosmetik (RevenueCat), Compliance
4. **Technisches Fundament und Release** – Dart-CI, Web-Build, App-Hülle aus Rune-Rush-Vorlage, Store-Builds, Analytics, Crashlytics
5. **Spieler finden und halten** – Closed Test (gleicher Tester-Pool wie Rune Rush), Store-Listing, Community

Erstes Epic (Headless): „Spielbare Regeln ohne Oberfläche – KI schlägt Zufalls- und Greedy-Bots“ mit Stories: Kartenformat + Generator + Validator · Einheiten-Daten + Schadensmatrix · Zugablauf + Siegbedingungen · KI-Heuristik + 3 Bots · Bot-Turnier in der CI.

**Ruht**

- –

## Zuletzt erledigt

- Startpaket Stufe A: CLAUDE.md, Konzept, Genre-Recherche, Entscheidungen, Vorlagen, Projektanweisung (2026-10-03)

## Offene Entscheidungen (nur der Mensch)

1. **Konzept bestätigen** (`docs/spielkonzept.md`, `docs/entscheidungen/0002-spielkonzept.md`): Advance-Wars-Loop, 2 Fraktionen, ≤ 8 Missionen, ~10 Handkarten, Generator als Content-Hebel.
2. **Monetarisierung bestätigen** (`0003`): ohne Werbung, Supporter 4,99 € / 9,99 €, Kosmetik 1,99–2,99 €, Deckel ~30 €. Alternative: Fraktion 3+ als IAP.
3. **Name und Paketname** (`0004`): Arbeitstitel „Small Realms“, Vorschlag `de.maestrodev.smallrealms`. Markenprüfung nötig.
4. **Pixel-Art-Quelle** (`0004`): Kenney „Tiny Battle“ (CC0, 16 px) als Start, oder eigene/gekaufte Assets?
5. **Content-Hebel langfristig** (Restdissens der Debatte): nur Generator + Seed-Codes, oder später Editor + Community-Upload (3–5 h/Woche Moderation)?
6. **Repo-Name und Claude-Projekt**: Repo öffentlich; Projektanweisung aus `docs/PROJEKTANWEISUNG.md` übernehmen.
