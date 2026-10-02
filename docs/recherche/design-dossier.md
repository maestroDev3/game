# Design-Dossier: Was an Mobile-Games fesselt, und ein Baukasten für ein systemisches 2D-Casual-Game

Stand: 02.10.2026 · Quellen in eckigen Klammern [n], Liste am Ende.

## TL;DR

- Hits verbinden fast immer eine **kurze, saftige Kernhandlung** (30 s bis 3 min), eine **langsame Meta-Schicht** und einen **zeitbasierten Grund, morgen wiederzukommen**.
- Kleine Teams gewinnen mit **Kombinatorik statt Content**: Balatro (1 Entwickler) [9], Vampire Survivors (ca. 1.100 £ Assets) [7], Egg, Inc. (Solo-Studio) [22], Stumble Guys (5–6 Leute) [27].
- Messlatte: Top-25 % erreichen D1 > 30 % und D7 6–7 % [30].
- Recht: CPC-Verfahren gegen 9 Publisher seit 01.10.2026 [43], Digital Fairness Act voraussichtlich Q4 2026 [46]. Daraus folgt: **keine bezahlten Lootboxen**, Preise immer in Euro.

---

## 1. Zerlegung der Referenzspiele

QF = Quantic-Foundry-Motivationen (6 Cluster: Action, Social, Mastery, Achievement, Immersion, Creativity) [29].

| Spiel | Core Loop (Dauer) | Meta | Session/Gating | Hook (warum morgen?) | QF |
|---|---|---|---|---|---|
| **Candy Crush Saga** | Tauschen, Match-3, Ziel in X Zügen; Level 30 s–2 min [13] | Saga-Karte mit Freunden, > 23.000 Level [16]; Episoden-Gate nach 35 Leveln (0,99 $ oder 3 Freunde) [13] | 5 Leben, je ca. 30 min Regeneration; Sessions 10–20 min [13][16] | Leben wieder voll, „+5 Züge" für 0,99 $ beim Beinahe-Sieg, Freunde auf der Karte | Mastery (Challenge), Achievement (Completion) |
| **Royal Match** | Schnellster Match-3-Switcher, Fair Shuffle, „intelligente" Propeller [1][2] | Sterne → Deko („puzzle & decorate lite") [1] | Leben; das Brett bleibt vor dem Kauf von Extra-Zügen sichtbar [1] | Events (Turniere, Win-Streak, Teams), Near-Miss-Angebote [1][2] | Mastery, Achievement |
| **Clash of Clans** | Sammeln → Bauen/Trainieren → Angreifen/Plündern [17] | Rathaus-Stufen, Gebäude, Clan | 30-s-Sammelsession oder Voll-Session < 5 min; Bau-Timer wachsen exponentiell, Armee < 1 h [17] | Timer fertig, Angst vor Plünderung, Clan-Krieg [17] | Social, Mastery (Strategy), Achievement (Power) |
| **PvZ 1 / 2** | Lane-Defense: Sonne sammeln → pflanzen → Welle halten | PvZ1: fast jedes Level eine neue Pflanze. PvZ2: Welten, Sterne, Pflanzen-Upgrades, Premium-Pflanzen [19] | PvZ1 Premium ohne Gate; PvZ2 F2P (Plant Food, Gems) [19] | Nächste Pflanze/Welt freischalten; PvZ2 zusätzlich Events | Mastery (Strategy), Creativity (Discovery) |
| **Monopoly Go** | Würfeln (Multiplikator wählen) → Felder → Geld → Wahrzeichen bauen → neues Board [11] | Boards, tauschbare Sticker-Alben [11] | Würfel regenerieren stündlich bis zu einem Cap; „Snack-" und „Meal-Sessions" [11] | Volle Würfel, tägliche plus 3–4-Tage-Events, Heists/Shutdowns [11] | Social, Achievement (Completion), Action (Excitement) |
| **Archero** | Raum säubern, Level-up: 1 aus 3 von ca. 50 Skills, 50 Räume pro Kapitel [3] | Talente, Ausrüstung (3 gleiche → nächste Seltenheit) [3] | Energie pro Run [3] | Nächster Kapitel-Versuch; später stockt es (Hauptkritik) [3] | Achievement (Power), Mastery, Action |
| **Vampire Survivors / Survivor.io** | Nur bewegen, Auto-Angriff, XP → Wahl 1 aus 3 → Evolutionen. VS 15/20/30 min Soft-Limit [7]; Survivor.io bis 15 min, Boss alle 5 min [4] | VS: Gold → permanente Upgrades, Charaktere, Achievement-Liste [6][8]; Survivor.io: Gear-Merge, Pass, Gacha [4] | VS ohne Gate; Survivor.io mit Energie | „Noch ein Run", Unlock-Liste; Survivor.io: Pass/Events | Action (Destruction), Achievement (Power), Creativity (Discovery) |
| **Balatro** | Pokerhand → Chips × Mult → Blind schlagen → Shop (Joker); 8 Antes à 3 Blinds [9] | ca. 150 Joker [10], Decks, Stakes | Premium, keine Gates, Runs jederzeit pausierbar | Neue Synergien entdecken, nächster Stake | Mastery (Strategy), Creativity (Discovery) |
| **Brawl Stars** | 3v3-Matches, ca. 2–3 min, rotierende Modi | Brawler, Power-Level, Hypercharges, Pass [20][21] | Keine Energie | Starr Drops (Zufallsbelohnung), Quests, Freunde [20] | Social (Competition), Action |
| **Idle (Egg, Inc., AFK Arena)** | Kaufen → Produktion wächst → Prestige (Soul Eggs) [22] | Epic Research und Prestige-Währung überleben den Reset [22] | Offline-Ertrag; AFK-Truhe mit 12-h-Cap → 2 Sessions/Tag [23] | Truhe voll, Prestige-Schwelle erreicht | Achievement (Power), Mastery (Strategy) |
| **Merge (Dragons, Mansion)** | Energie → Generator → mergen → Auftrag [25] | Story/Renovierung | Energie **und Boardplatz** als Engpass [26] | Energie voll, Story-Cliffhanger, Events [25] | Achievement (Completion), Immersion (Story), Creativity |
| **Stumble Guys** | Party-Royale bis 24 Spieler in 3 Runden (24 → 16 → 8) [28] | Skins, Emotes, Pass, Ranked | Keine Energie | Freunde/Party, Creator-Turniere [27] | Social, Action (Excitement) |

**Zahlen, die die Muster stützen**

- **Royal Match**: 4 Mrd. $ Lifetime, 55 Mio. MAU. Der Vorsprung kommt aus der Ausführung, 80–90 % Qualität reichen nicht. 50–60 % der Downloads stammen aus Paid UA, ein Hebel, den ein Solo-Team nicht hat [2].
- **Monopoly Go**: 6 Mrd. $ in ca. 2 Jahren [12], getragen von personalintensivem Live-Ops.
- **Brawl Stars**: Die Lootboxen wurden 12/2022 entfernt, weil ein Legendary 10 Monate dauerte. Mit Starr Drops kamen Zufallsbelohnungen zurück, danach **8,8× Umsatz und 3,9× DAU** [20]. Zufall ist Kern-Fun.
- **Archero**: über 35 Mio. $ in 3 Monaten. Die stockende Meta (Item-Fusion) lässt laut DoF etwa gleich viel liegen [3].
- **Survivor.io**: über 500 Mio. $ IAP [5]. D1 liegt trotzdem nur bei ca. 45 %, 15-min-Runs gelten als „hardcore" [4].
- **Balatro**: Solo-Entwicklung, 2,5 Jahre, über 5 Mio. Verkäufe. Mobile brachte 4,4 Mio. $ in 2 Monaten [9].

---

## 2. Retention-Muster: Belege und Kosten (Teil 2 und 3)

**Benchmarks Mobile** (GameAnalytics 2026, 16.262 Spiele) [30]:

| Kennzahl | Median | Top 25 % | Top 10 % |
|---|---|---|---|
| D1 | ca. 20 % | > 30 % | ca. 40 % |
| D7 | < 4 % | 6–7 % | 11–12 % |
| Sessionlänge | – | 5,2 min | 8 min |
| Sessions/Tag | – | 5,3–5,7 | 9,6 |

Die Zahlen sagen: **Das Spiel wird in vielen kurzen Sessions gespielt**, nicht in langen.

| Muster | Beleg | Kostenart | Für Solo/KI? |
|---|---|---|---|
| **Daily Reward/Streak** | Duolingo: Wer einen 7-Tage-Streak erreicht, schließt 3,6× häufiger den Kurs ab. Ein zweiter Streak-Freeze brachte +0,38 % DAU, neue Streak-Animationen +1,7 % D7 [33] | systemisch | **ja**, mit Freeze und ohne harte Strafe |
| **Energie/Leben** | ca. ⅓ der Casual-Bookings; Funktionen: Gewohnheit, Pacing, Monetarisierung, Entscheidungen [34]. Royal Match: „nothing else I could do" [1] | systemisch | **eher nein**; besser flexible Sessions mit abnehmendem Ertrag [35] |
| **Near-Miss / „noch ein Zug"** | Beinahe-Treffer sind unangenehm, steigern aber die Spiellust (Striatum/Insula) [39]. CC/RM verkaufen „+5 Züge" genau dann [1][13] | systemisch | **ja**, nur echte, skillbasierte |
| **Variable Rewards** | Brawl Stars 8,8× [20]; VS-Truhenanimation nach Slot-Vorbild [7][8] | systemisch | **ja** als Gameplay-Belohnung, nicht für Echtgeld |
| **Progressionskurven** | Kosten = Basis × Rate^Anzahl; Prestige bei +50–200 % Prestigewährung; Multiplikator-Sprünge bei 25/50/100 [24]. Archero: späte Kurve bricht ein [3] | systemisch (Formel) | **ja**, per Simulation balancieren |
| **Sammeln/Collections** | Monopoly-Go-Sticker mit Tausch [11]; VS-Achievement-Liste: „kein Run ist verschwendet" [8] | günstig, wenn parametrisch | **ja** |
| **Live-Ops/Events** | Monopoly Go: Events täglich, 3–4-tägig, stündlich [11]; Royal Match: zu dünne Event-Bibliothek [1] | **teuer** als Themen-Content, **günstig** als Regel-Mutator | Mutatoren ja |
| **Battle Pass** | 21 % der US-iOS-Top-100 (12/2019). Clash of Clans machte 27 Mio. $ in einer Woche nach Einführung [36] | mittel (braucht Belohnungs-Items) | ab Version 1.x |
| **Leaderboards/Teams** | Monopoly Go: globale und Freundes-Boards [11]; Clans bei CoC [17] | async-LB günstig; Teams/Chat teuer (Moderation, USK-Risiko) [50] | LB ja, Teams später |
| **Fail-Pressure vs. Flow** | King: Je länger ein Level, desto weniger Spaß; schwere Level kürzer halten. Überarbeitung der 100 unspaßigsten Level → deutliches Engagement-Plus [14]. Stellschrauben: Layout, Farbanzahl (4–6), Blocker [15] | systemisch mit Bot-Tests | **ja** |
| **Onboarding/FTUE** | Core Gameplay < 60 s, „Aha" < 90 s, ≤ 2 Tour-Schritte: +5–10 Pp. D1 [32]; kein Account-Zwang [31]. PvZ: ≤ 8 Wörter pro Hinweis, neue Mechanik ca. alle 5 Level [18] | einmalig | **Pflicht** |
| **Core-Loop-Dauer** | CC 30 s–2 min [13], CoC 30 s–5 min [17], Top-25-%-Session 5,2 min [30] | – | Kerneinheit 1–3 min, Run ≤ 8 min |
| **Juice** | „Juice it or lose it" (GDC EU 2012) [37]; VS-Truhe [7]; Balatro-Score „brennt" [10] | einmalig, systemisch wiederverwendbar | **Pflicht**, größter Hebel für Solo-Entwickler |

### Content-Treadmill (teuer) vs. systemisch (günstig)

**Teuer** (Kosten wachsen linear mit der Spielzeit; Spieler verbrauchen schneller, als produziert wird [38]): handgebaute Level (Candy Crush: über 23.000 [16]), Story-/Renovierungs-Meta, neue Helden mit Animation, Themen-Events mit Asset-Paketen, Echtzeit-PvP-Maps, Chat-Moderation.

**Günstig** (kombinatorisch): Regeln × Objekte × Zufall (Balatro ca. 150 Joker [10], Archero ca. 50 Skills [3]), Seeds und Daily Challenges, Mutatoren als Events, prozedurale Level mit Solver-Bot für Lösbarkeit und Win-Rate (analog zu King [14][15]), Idle-Mathe, parametrische Sammlungen, asynchrone Leaderboards.

**Faustregel:** Content **datengetrieben** anlegen (JSON plus generische Effekt-Hooks). Jedes neue Objekt soll mit allen bestehenden interagieren. Ziel: über 100 h Spielzeit aus unter 100 Objekten.

---

## 3. Ethik, Recht und Store-Regeln (EU 2025/2026)

| Regel | Inhalt | Konsequenz für uns |
|---|---|---|
| **CPC Key Principles** (03/2025) [41][42] | Echtgeld-Preise zeigen; keine verschleiernden Mehrfachwährungen; keine Packgrößen, die Restguthaben erzwingen; 14 Tage Widerruf für unbenutzte Währung; Kinderschutz (keine direkten Kaufappelle, Elternkontrolle per Default) | höchstens 1 Premiumwährung, Packs = Preise, €-Anzeige |
| **CPC-Durchsetzung** | 03/2025 Star Stable (Kaufdruck auf Kinder, Zeitdruck-Angebote) [42]. **01.10.2026**: 9 Firmen, u. a. King (Candy Crush), Supercell (CoC), Playrix (Gardenscapes), Mojang, Riot, Ubisoft, separat Activision Blizzard. Themen: Währungspreise, erzwungene Käufe, suchtförderndes Design, Daten Minderjähriger, Elternkontroll-Defaults [43] | Vorbilder selbst auf dem Prüfstand |
| **DSA Art. 28 Leitlinien** (14.07.2025) [44][45] | keine Lootboxen/glücksspielähnlichen Features für Minderjährige; Transaktionswert transparent; suchtfördernde Features per Default aus; keine Pushes in Kern-Schlafzeiten; Selbstauskunft zum Alter reicht bei Risiko nicht | gilt direkt nur für Plattformen (UGC/Chat), trotzdem als Best Practice übernehmen |
| **Digital Fairness Act** [46][47] | Vorschlag erwartet Q4 2026; Konsultation: über 3.300 Antworten, 70 % für verbindliche Regeln zu In-Game-Ausgaben. Fokus: Dark Patterns, suchtförderndes Design, Lootboxen, Währungen | jetzt zukunftssicher bauen |
| **COPPA (USA)**, Compliance ab 22.04.2026 [48] | separate Elterneinwilligung für Weitergabe an Dritte inkl. Targeted Ads; Speicherfristen | bei U13: nur kontextuelle Ads, minimale Daten |
| **Stores** [49] | Apple (12/2017) und Google Play (05/2019) verlangen, dass Lootbox-Odds **vor dem Kauf** angezeigt werden | – |
| **Deutschland/USK** [50] | Seit 2023 gelten In-Game-Käufe, Lootboxen und Chat als Nutzungsrisiken; ca. 30 % der Spiele mit Online-Features wurden deshalb höher eingestuft | Lootbox/Chat kann Reichweite kosten |
| **PEGI-Präzedenz** [9] | Balatro wegen Glücksspiel-Bildsprache erst 18+, nach Einspruch 12+ | Casino-Optik meiden |
| **Forschung** | Lootbox-Ausgaben ↔ Glücksspielprobleme r = 0,26 (15 Studien) [40] | – |

**Dark-Pattern-Verbotsliste für unser Projekt:**
- falsche oder zurückgesetzte Countdowns
- Confirmshaming („Nein, ich mag keine Belohnungen")
- bezahlte Zufallsitems
- „Pay to continue"-Timer bei Kindern
- Streak-Verlust ohne Freeze
- Pushes zwischen 22 und 7 Uhr
- Pflicht-Ads mitten im Core Loop

---

## 4. Baukasten

| | Mechanik | Begründung |
|---|---|---|
| **Pflicht** | Kerneinheit 1–3 min, jederzeit unterbrechbar mit Autosave | Sessionlänge 5,2 min, über 5 Sessions/Tag [30] |
| | Core Gameplay < 60 s, Aha < 90 s, kein Login, ≤ 8 Wörter pro Hinweis | [18][31][32] |
| | Wahl 1 aus 3 mit Zufall (Build-Entscheidungen) | Archero/VS/Balatro [3][6][9] |
| | Zwei Loops: Run (kurz) + permanente Meta | VS-Gold, Royal-Match-Sterne [1][6] |
| | Juice-Paket: Tweening, Squash & Stretch, Partikel, Hit-Stop, geschichteter Sound, eskalierende Zahlen | [7][10][37] |
| | Fairer Schwierigkeits-Sägezahn, Bot-getestet, mit Pity/Fair-Shuffle | [2][14][15] |
| | Täglicher Grund zurückzukommen: Daily Seed + Streak mit Freeze | [33] |
| | Analytics: FTUE-Funnel, D1/D7, Win-Rate pro Stufe | [14][32] |
| | Compliance-Basis: €-Preise, keine bezahlten Lootboxen, Push-Ruhezeiten | [41][45] |
| **Soll** | Sammel-Album (parametrisch) | [8][11] |
| | Wöchentliche Mutator-Events | [11][38] |
| | Idle-/Offline-Truhe mit Cap von 8–12 h | AFK Arena [23] |
| | Async-Leaderboard und Ghost-Vergleich | [11] |
| | Prestige-Schicht | [24] |
| | Rewarded Ads (opt-in) | Egg, Inc. [22] |
| | Saison-Pass mit kostenloser und Premium-Spur, 4–6 Wochen | [36] |
| **Kann** | Teams/Clubs | teuer: Chat, Moderation, USK [50] |
| | Echtzeit-PvP | Netcode |
| | Story-/Deko-Meta | Content-Treadmill [38] |
| | Energie | nur falls Pacing nötig [34] |
| | UGC-Editor | DSA-Plattformpflichten [44] |
| | Gacha | rechtliches Risiko [43][47] |

---

## 5. Drei Konzept-Skizzen

### A) „Rune Rush": Puzzle-Roguelite (Balatro × Match-3)

- **Pitch:** Match-3, bei dem du die Regeln brichst: Matches zählen Basis × Multiplikator, Runen schreiben das Spiel um.
- **Core Loop:**
  1. Ein 7×7-Brett entsteht aus einem Seed, mit Zielpunktzahl und 12 Zügen.
  2. Matches und Kaskaden ergeben Basis × Mult.
  3. Ziel erreicht: Münzen für übrige Züge.
  4. Shop: 1 aus 3 Runen, Reroll gegen Münzen.
  5. Jedes 3. Brett hat eine Boss-Regel (z. B. „Rot zählt nicht"). 8 Stufen ergeben einen Run.
- **Meta:** Runen-Album (über 60, per Run-Ziel freigeschaltet), Start-Varianten, Stakes, Themes.
- **Session:** Brett 60–120 s, Run 15–20 min, nach jedem Zug pausierbar; 1 Daily-Seed-Run mit Leaderboard.
- **Monetarisierung:** Free-Demo plus ca. 4,99 € Vollversion (Balatro-Modell [9]), alternativ F2P mit Rewarded-Reroll (max. 3/Run) und Kosmetik. Keine Leben, keine Zufallskäufe.
- **Warum wiederkommen:** Daily Seed und Streak, Lücken im Album, nächster Stake, echte Beinahe-Siege.
- **QF:** Mastery (Strategy), Creativity (Discovery), Achievement (Completion).
- **Content-Kosten: niedrig.** Eine Rune = Datensatz + Icon + Effekt-Hook, ca. 1–3 h. Risiko Balancing, daher Monte-Carlo-Bot Pflicht; keine Casino-Optik (PEGI-Fall).

### B) „Lantern Swarm": One-Thumb-Survivor mit 5-Minuten-Runs

- **Pitch:** Vampire Survivors für die Bushaltestelle: ein Daumen, fünf Minuten, ein Bildschirm voller Glühwürmchen.
- **Core Loop:**
  1. Mit einem Daumen bewegen, Angriff automatisch.
  2. Gegner droppen XP-Funken.
  3. Level-up: 1 aus 3 (Pool ca. 40 Fähigkeiten, 8 Evolutionen).
  4. Jede Minute eine Elite-Welle, bei 5:00 der Boss.
  5. Ende: Glut (Meta-Währung) und eine Truhe mit Slot-Animation, nur erspielbar.
- **Meta:** Laternen-Dorf (Kosten = Basis × 1,15^n), Ausrüstungs-Merge (3 → 1), Charaktere mit Startwaffe, Biome als Gate. Item-Zufuhr großzügig halten, hier ist Archero gescheitert [3].
- **Session:** 5-min-Runs statt 15 min wie bei Survivor.io [4]; Idle-Laterne mit 8-h-Cap für 2–3 Sessions/Tag.
- **Monetarisierung:** Rewarded Revive (1/Run), Truhen-Verdopplung, 28-Tage-Pass (gratis + ca. 4,99 € Premium, Kosmetik/Komfort), Starter-Pack. Keine Energie.
- **Warum wiederkommen:** volle Laterne, Tages-Mutator, Pass-Quests, unentdeckte Evolutionen.
- **QF:** Action (Destruction), Achievement (Power), Creativity (Discovery).
- **Content-Kosten: mittel-niedrig.** Waffe = Sprite + Partikel + Stat-Tabelle; Biom = Palette + Gegner-Regeln; Wellen prozedural aus Budget-Tabellen. Risiken: Performance bei über 300 Sprites (Object-Pooling) und Juice-Aufwand.

### C) „Moosgarten": Cozy Idle-Merge mit genetischen Pflanzen

- **Pitch:** Merge Pflanzen, kreuze Mutationen, fülle dein Herbarium; der Garten wächst weiter, während du schläfst.
- **Core Loop:**
  1. Beete produzieren passiv Samen.
  2. 3 gleiche ergeben die nächste Stufe; Boardplatz ist der Engpass [26].
  3. Zwei Pflanzen kreuzen: Mutation aus 6 Farben × 6 Formen × 8 Mustern (288 Varianten aus Sprite-Layern).
  4. Aufträge der Waldtiere, prozedural aus einem Rezeptgraph: Münzen + Deko.
  5. Münzen in Beete und Gewächshaus investieren.
- **Meta:** Herbarium-Album, Prestige „Jahreszeitenwechsel" (Reset bei +50–200 % Prestigewährung für permanenten Dünger-Multiplikator [24]), freie Deko.
- **Session:** Check-ins von 2–4 min, 3–5×/Tag, Offline-Produktion bis 8 h, wöchentliches Gemeinschaftsbeet.
- **Monetarisierung:** Rewarded „2-h-Zeitsprung" (max. 5/Tag), kleine Deko-/Beet-Packs, Gärtner-Pass. Eine Premiumwährung, Packgrößen = Preise [41].
- **Warum wiederkommen:** Produktion voll, Kreuzung fertig, Album-Lücken, Wochen-Twist („nur blaue Mutationen zählen").
- **QF:** Achievement (Completion), Creativity (Design), Immersion (Fantasy).
- **Content-Kosten: niedrig** (Mutationen), **mittel** (Deko). Idle-Balancing per Simulator. Gegen Late-Game-Langeweile: zweite Prestige-Schicht und Mutator-Events.

**Empfehlung:** A hat das geringste Content- und Rechtsrisiko (Mastery, Premium). B hat das höchste F2P-Potenzial, aber den meisten Juice- und Performance-Aufwand. C erreicht die breiteste Zielgruppe mit der längsten Retention, braucht aber die meiste Mathe-Arbeit.

---

## Quellen

1. Deconstructor of Fun – Royal Match: The New King from Turkey? https://www.deconstructoroffun.com/blog/2021/3/21/royal-match-the-new-king-from-turkey
2. Naavik – The Royal Blueprint: Easy to Copy… Or Not? https://naavik.co/digest/why-dream-games-success-is-a-challenge-to-replicate/
3. Deconstructor of Fun – How Archero Shot to the Top https://www.deconstructoroffun.com/blog/2019/8/9/why-archero-banked-25m-but-leaves-25m-hanging-hlx9n
4. Naavik – Survivor.io: Will It Follow in Archero's Footsteps? https://naavik.co/deep-dives/survivorio-archeros-footsteps/
5. WN Hub – Survivor.io IAP > 500 Mio. $ https://wnhub.io/news/finance/item-43301
6. Kokutech – Vampire Survivors Design Analysis https://www.kokutech.com/blog/gamedev/design-patterns/power-fantasy/vampire-survivors
7. Wikipedia – Vampire Survivors https://en.wikipedia.org/wiki/Vampire_Survivors
8. University of Portsmouth – Vampire Survivors & Glücksspielpsychologie https://www.port.ac.uk/news-events-and-blogs/blogs/popular-culture/vampire-survivors-how-developers-used-gambling-psychology-to-create-a-bafta-winning-game
9. Wikipedia – Balatro https://en.wikipedia.org/wiki/Balatro
10. GamesHub – Balatro is pushing the roguelike deckbuilder https://www.gameshub.com/news/features/balatro-roguelike-deckbuilder-2637397/
11. A. SV (Medium) – Deconstructing Monopoly GO! https://arvindhsv.medium.com/deconstructing-monopoly-go-will-it-be-a-100m-hit-f0272f4e08e8
12. Sensor Tower – Monopoly GO! hits $6B https://sensortower.com/blog/monopoly-go-app-revenue-milestone
13. Game Developer – Candy Crush Saga: A Sweet Journey into Monetization https://www.gamedeveloper.com/design/candy-crush-saga-a-sweet-journey-into-monetization
14. MobileGamer.biz – How King defines a 'good' Candy Crush level https://mobilegamer.biz/how-king-defines-a-good-candy-crush-saga-level-and-why-it-constantly-prunes-the-bad-ones/
15. GDC 2020 (King) – Blockers: Analyzing Difficulty Drivers in Candy Crush https://media.gdcvault.com/gdcsummer2020/presentations/GDC2020%20Final%20PPT.pdf
16. TechSpot – Candy Crush generates nearly $1B annually https://www.techspot.com/news/113475-candy-crush-generates-nearly-1-billion-annually-14.html
17. Game Developer – Mid-Core Success Part 1: Core Loops https://www.gamedeveloper.com/design/mid-core-success-part-1-core-loops
18. GDC Vault – George Fan: How I Got My Mom to Play Through PvZ https://www.gdcvault.com/play/1015541/How-I-Got-My-Mom (Notizen: https://notes.hamatti.org/sources/talks/how-i-got-my-mom-to-play-through-plants-vs.-zombies)
19. Udonis – Plants vs. Zombies Stats https://www.blog.udonis.co/statistics/plants-vs-zombies
20. MobileGamer.biz – Supercell explains Brawl Stars' comeback (8,8×) https://mobilegamer.biz/supercell-explains-brawl-stars-big-comeback-from-an-all-time-low-to-8-8x-revenue/
21. Deconstructor of Fun – Brawl Stars, to the moon! https://www.deconstructoroffun.com/blog/2024/2/11/brawl-stars-to-the-moon
22. Wikipedia – Egg, Inc. https://en.wikipedia.org/wiki/Egg,_Inc.
23. Game Developer – Flexible time session design in AFK Arena https://www.gamedeveloper.com/design/flexible-time-session-design-in-afk-arena
24. GDC Europe 2016 – A. Pecorella: Quest for Progress (Idle-Mathe) https://media.gdcvault.com/gdceurope2016/presentations/Pecorella_Anthony_Quest%20for%20Progress.pdf
25. Udonis – Merge Mansion Monetization https://www.blog.udonis.co/mobile-marketing/mobile-games/merge-mansion-monetization
26. Deconstructor of Fun – How EverMerge Made $50M in 7 Months https://www.deconstructoroffun.com/blog/2020/12/6/how-evermerge-made-50m-in-just-7-months
27. MobileGamer.biz – How Stumble Guys beat Fall Guys https://mobilegamer.biz/how-stumble-guys-beat-fall-guys-at-its-own-game/
28. Stumble Guys Help Center – Players per match https://stumbleguys.helpshift.com/hc/en/4-stumble-guys/faq/220-how-many-players-per-match/
29. Quantic Foundry – Gamer Motivation Model https://quanticfoundry.com/wp-content/uploads/2015/12/Gamer-Motivation-Model-Overview.pdf
30. GameAnalytics – 2026 Mobile & PC Benchmarks https://www.gameanalytics.com/reports/2026-mobile-pc-gaming-benchmarks (Zusammenfassung: https://gamedevreports.substack.com/p/gameanalytics-mobile-and-pc-game)
31. GameAnalytics – 10 Tips for a Great FTUE https://www.gameanalytics.com/blog/tips-for-a-great-first-time-user-experience-ftue-in-f2p-games
32. Playio – Onboarding Decides Your D1 https://blog.playio.co/mobile-game-onboarding-retention
33. Duolingo Blog – How the streak builds habit https://blog.duolingo.com/how-duolingo-streak-builds-habit
34. Mobile Free To Play – Understanding Energy Systems https://mobilefreetoplay.com/understanding-and-eliminating-energy-systems/
35. Mobile Free To Play – Flexible Sessions https://mobilefreetoplay.com/mobile-session-design-flexible-sessions-2/
36. GameRefinery – Battle Pass trend https://www.gamerefinery.com/battle-pass-trend-mobile-games/
37. GDC Vault – Jonasson & Purho: Juice It or Lose It https://www.gdcvault.com/play/1016487/juice-it-or-lose
38. Playtank – Stepping Off the Content Treadmill https://playtank.io/2024/03/12/stepping-off-the-content-treadmill/
39. ScienceDaily – Clark et al. 2009, Near-Misses https://www.sciencedaily.com/releases/2009/02/090211122130.htm
40. Garea et al. 2021 – Meta-Analyse Lootboxen & Problemspiel https://www.researchgate.net/publication/351107695_Meta-analysis_of_the_relationship_between_problem_gambling_excessive_gaming_and_loot_box_spending
41. Esports Legal News – CPC Key Principles (7 Prinzipien) https://esportslegal.news/2025/03/25/eu-virtual-currencies-guidelines/
42. EU-Kommission IP/25/831 – Star Stable / Key Principles https://ec.europa.eu/commission/presscorner/api/files/document/print/en/ip_25_831/IP_25_831_EN.pdf
43. European Sting – CPC-Aktion vom 01.10.2026 https://europeansting.com/2026/10/01/consumer-protection-authorities-ramp-up-action-to-protect-gamers-rights/
44. Freshfields – DSA Art. 28 Guidelines https://www.freshfields.com/en/our-thinking/blogs/technology-quotient/dsa-decoded-6-the-european-commission-finalises-guidelines-on-the-protection-of-102kv4s
45. Eurochild – DSA Guidelines Policy Briefing https://eurochild.org/uploads/2025/11/The-DSA-Guidelines-for-the-protection-of-minors-online.pdf
46. Europäisches Parlament – Legislative Train: Digital Fairness Act https://www.europarl.europa.eu/legislative-train/theme-protecting-our-democracy-upholding-our-values/file-digital-fairness-act
47. Chambers – DFA: What the Consultation Tells the Games Industry https://chambers.com/articles/digital-fairness-act-what-the-public-consultation-tells-the-video-game-industry
48. Hunton – COPPA Compliance Deadline https://www.hunton.com/privacy-and-cybersecurity-law-blog/coppa-rule-amendment-compliance-deadline-approaches
49. Fenwick – Google Play requires loot box odds https://www.fenwick.com/insights/publications/google-play-now-requires-disclosure-of-loot-box-odds
50. USK – Jahresrückblick 2023 (neue Prüfregeln) https://usk.de/usk-pressemitteilung-jahresruckblick-2023/

*Hinweis zur Methodik:* r/gamedesign war für das Recherche-Tool gesperrt (Site blocked). Praktiker-Perspektiven stammen daher aus Mobile Free To Play, Game Developer und Playtank. Die Match-Länge von Brawl Stars (ca. 2–3 min) ist Erfahrungswissen und nicht belegt. Die Würfel-Regenerationsraten von Monopoly Go stammen aus einer Analyse von 2023 und können sich seitdem geändert haben.
