# Entscheidung 0003: Spielkonzept – Match-3-Roguelite „Rune Rush“ (Arbeitstitel)

**Status:** angenommen (vom Agenten, Bestätigung durch den Menschen offen) · **Datum:** 2026-10-02
**Grundlage:** `docs/recherche/marktanalyse.md`, `docs/recherche/design-dossier.md`

## 1. Ausgangslage

Ziel ist ein Handyspiel (Android + iOS), das Menschen so fesselt wie Candy Crush, Plants vs. Zombies oder Clash of Clans, und das irgendwann Geld verdient. Entwickelt wird es von einem Solo-Entwickler mit einem KI-Agenten – ohne Marketingbudget, ohne Art-Team, ohne Live-Ops-Mannschaft.

Was die Recherche gezeigt hat:

- **Die genannten Vorbilder sind als Genre unerreichbar.** Von 213 neuen Match-3-Titeln 2025 kamen 3 über 100 000 $/Monat, bei Merge 0 von 91. Royal Match und Candy Crush kaufen Spieler für über 10 $ pro Installation; 4X (Clash-of-Clans-Nachfolger) hängt an Walen und Live-Ops-Teams. Casual-Casino (Coin Master, Monopoly Go) ist rechtlich und ethisch heikel (CPC-Verfahren der EU seit 01.10.2026 gegen King, Supercell, Playrix u. a.).
- **Was bei Solo-Entwicklern funktioniert hat:** Balatro (1 Entwickler, 4,4 Mio. $ mobil in 2 Monaten), Vampire Survivors (3 Mio. Downloads in 6 Wochen), Magic Research (400 000 $ mit zwei Reddit-Posts), Idle Slayer, Retro Bowl. Gemeinsam: **tiefe Systeme statt teurer Grafik, Kombinatorik statt Content-Treadmill, organische Verbreitung, faire Monetarisierung.**
- **Was fesselt (unabhängig vom Genre):** Kerneinheit 1–3 Minuten, Aha-Moment unter 90 Sekunden, Wahl 1-aus-3 mit Zufall, zwei Loops (kurzer Run + dauerhafte Meta), echte Beinahe-Siege, variable Belohnungen im Gameplay, täglicher Grund zurückzukommen, Sammeln, „Juice“.

## 2. Entscheidung

**Wir bauen ein Match-3-Roguelite:** die vertraute Candy-Crush-Mechanik (jeder kann sofort spielen) mit der Balatro-Tiefe (Multiplikatoren, Runen, die die Regeln umschreiben, 1-aus-3-Shop, Boss-Regeln, Runs von 15–20 Minuten).

Kernpunkte (Details in `docs/spielkonzept.md`):

1. **Core Loop:** Brett (60–120 s, Zugbudget, Zielpunktzahl) → Münzen → Shop (1 aus 3 Runen) → nächstes Brett; jedes dritte Brett ist ein Boss mit Sonderregel; 8 Bretter = 1 Run.
2. **Content ist kombinatorisch:** Eine Rune = Datensatz + Icon + Effekt-Hook. Bretter entstehen prozedural aus Seeds. Kein handgebauter Level-Content.
3. **Meta:** Runen-Album, Schwierigkeitsstufen (Stakes), Brett-Varianten, Daily-Seed-Run mit Streak (mit Freeze) und asynchronem Leaderboard, wöchentlicher Mutator.
4. **Monetarisierung: Free-to-Play, fair und EU-konform.** Rewarded Ads (Reroll, Extra-Züge beim Beinahe-Sieg, Tagesbonus), Werbefrei-Kauf, Kosmetik, später Saison-Pass ohne Spielvorteil. **Keine** Leben/Energie, **keine** bezahlten Zufallsitems, **keine** zweite Premiumwährung, **keine** Casino-Optik.
5. **Zielgruppe:** Erwachsene Casual-Puzzle-Spieler (Kernzielgruppe 25–45), nicht an Kinder gerichtet (kein Mixed-Audience-Store-Eintrag).
6. **Reihenfolge:** Android zuerst (geschlossener Test mit 12 Testern über 14 Tage ist Pflicht), iOS direkt danach. Steam/Desktop optional später.
7. **Sprache des Spiels:** Englisch und Deutsch von Anfang an (ARB-Lokalisierung).

## 3. Begründung

- **Vertrautheit + Tiefe:** Match-3 braucht kein Tutorial (Aha < 60 s). Die Roguelite-Schicht liefert die Mastery-/Discovery-Motivation, die Balatro zum Solo-Hit gemacht hat, und ist für den KI-Agenten ideal: Systeme, Regeln, Simulation, Balancing per Monte-Carlo-Bot.
- **Kein Content-Treadmill:** Candy Crush hat über 23 000 handgebaute Level. Wir brauchen ~60–100 Datensätze, die miteinander interagieren – Ziel „über 100 Stunden Spielzeit aus unter 100 Objekten“.
- **Geringes Rechtsrisiko:** Keine Lootboxen, keine Mehrfachwährungen, keine Zeitdruck-Angebote – die Punkte, die die EU-Verbraucherschützer gerade gegen die großen Publisher verfolgen.
- **Flutter + Flame reichen aus:** ein 7×7-Brett, kein Massen-Sprite-Problem (siehe 0002).
- **Monetarisierung passt zum Genre:** Reroll und Extra-Züge sind natürliche Rewarded-Ad-Plätze; „Werbefrei“ ist bei Ad-getragenen Spielen der wichtigste IAP.
- **Organische Reichweite ist möglich:** Balatro-Likes und Roguelite-Deckbuilder haben aktive Communities (Reddit, YouTube-Creator), die neue Titel aufnehmen.

## 4. Verworfene Alternativen

| Alternative | Warum verworfen |
|---|---|
| Klassisches Match-3 (Candy-Crush-Klon) | 1,4 % Erfolgsquote neuer Titel, >10 $ CPI, 23 000+ Level-Treadmill, Leben-System. Ohne Marketingbudget chancenlos. |
| 4X/Strategie (Clash-of-Clans-Richtung) | PvP, Server, Anti-Cheat, Clans mit Chat (Moderation, USK), Live-Ops-Team, CPI 4–5,50 $, Wal-abhängig. |
| Tower Defense (PvZ-Richtung) | Handgebaute Level + viele Einheiten mit Animation = Content-Treadmill, dazu Art-lastig. Bleibt als Rune/Modus-Idee denkbar, nicht als Kern. |
| One-Thumb-Survivor „Lantern Swarm“ (5-Minuten-Runs) | Höchstes F2P-Potenzial, aber: Massen-Sprites (Flame-Grenzfall, Benchmark nötig), sehr juice-/art-lastig, Habby dominiert mit Marketingbudget. **Plan B / spätere Initiative.** |
| Cozy Idle-Merge „Moosgarten“ | Breiteste Zielgruppe, längste Retention, aber Deko-Content (Art) und Idle-Balancing-Mathe sind für Solo + KI der aufwendigere Weg. **Kandidat für ein zweites Spiel.** |
| Premium-Verkauf (4,99 € Vollversion) | Funktioniert mobil fast nur mit PC-Bekanntheit (Balatro). Bleibt als Option offen (siehe 5). |
| Casual-Casino/Spin-Mechanik | Rechtliches Risiko (CPC, DFA, PEGI-Einstufung), ethisch nicht gewollt. |

## 5. Offene Entscheidungen für den Menschen

1. Konzept bestätigen oder umsortieren (A: Match-3-Roguelite · B: Survivor-like · C: Idle-Merge).
2. Endgültiger Name (Arbeitstitel „Rune Rush“; Markenprüfung nötig).
3. F2P fair (empfohlen) **oder** Premium + Demo.
4. Art-Richtung: flache Vektorformen (vom Agenten in Code/SVG erzeugbar) vs. gekaufte/gezeichnete Assets. Hinweis: Spieler lehnen erkennbar KI-generierte Grafik ab.
5. Accounts: Google Play Developer (25 $), Apple Developer Program (99 $/Jahr), Firebase-Projekt, AdMob, RevenueCat – anlegen muss der Mensch.

## 6. Quellen

Siehe Quellenlisten in `docs/recherche/marktanalyse.md` und `docs/recherche/design-dossier.md`.
