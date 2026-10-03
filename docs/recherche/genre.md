# Genre-Recherche: Rundenbasierte Pixel-Strategie auf Mobile

**Stand:** 2026-10-03 · **Zweck:** Grundlage für `docs/spielkonzept.md` („Small Realms“) · Store- und AppBrain-Zahlen sind Momentaufnahmen, Umsatzzahlen Dritter sind Schätzungen.

## Kurzfazit

- **Die Nische ist klein, aber treu.** Age of Strategy kommt nach 13 Jahren auf 1,7 Mio. Downloads und 4,61 Sterne bei rund 39 000 Bewertungen. Es holt weiterhin rund 140 Downloads pro Tag, ohne Werbung und ohne Marketing [2].
- **Der Ausreißer nach oben ist Polytopia** mit 25 Mio. Downloads [11]. Dort gibt es kein einziges handgebautes Gefecht: Content entsteht aus Kartengenerator und Stämmen, Geld aus kleinen Einmalkäufen [12][14].
- **Was fesselt, ist überall gleich:** zwei Verben (bewegen, angreifen), eine lesbare Konter-Matrix, Gebäude als Wirtschaft und „noch eine Runde“ [9].
- **Was scheitert:** handgebaute Karten als Treadmill, unlesbare Mini-Sprites, lange KI-Züge und eine Monetarisierung, die nachträglich kippt (UniWar [20]).

## 1. Age of Strategy und die Zero-Touch-Familie

**Mechanik.** Advance-Wars-Loop im Mittelalter: Einheiten bewegen, Gebäude einnehmen, mit Arbeitern Gebäude errichten, Einheiten rekrutieren. Dazu kommen 120+ Technologien und Zauber [1][7]. Jede Karte vergibt Sterne für schnelle Siege, Sterne bringen Gems [1][7].

**Umfang.** 500+ Kampagnen- und 140+ Skirmish-Karten, 350+ Einheiten und Gebäude, Map-Editor (Beta), Online-Multiplayer [1]. Die Schwester Age of Fantasy (seit 11/2015, ~260 000 Downloads, 4,71 Sterne) hat 1 100+ Einheiten/Gebäude, 6 Völker und 390+ Kampagnen-Karten, „including fan-made“ [4]. Zusammen: 6 Spiele, ~3 Mio. Downloads, 62 000 Bewertungen, Ø 4,65 Sterne [3].

**Monetarisierung.** Keine Werbung [2]. Laut Store ist IAP „for donations only … NOT a pay to win game“ [1]. Tatsächlich werden Gem-Pakete von 0,99 $ (10 Gems) bis 44,99 $ (3 200 Gems) verkauft [5]. Gems bezahlen auch Zauber-Upgrades [1]. Nach unserer Verbotsliste wäre das eine zweite Währung mit Spielwirkung. Das Vorbild ist fairer als der Markt, aber nicht unser Maßstab.

**Community-Pipeline.** Im Forum hat jede Kampagne einen eigenen Bereich. Ein Entwickler-Account markiert Themen als IMPLEMENTED oder FIXED. Allein zu Kampagnen-Karten gibt es 157 Themen, das meistgelesene hat 57 691 Aufrufe [8]. Fans schreiben ganze Kampagnen (z. B. „History of Hungary“), der Entwickler kuratiert sie und liefert sie per Update aus [7]. Die Versionsnummer 1.1946 und Updates bis September 2026 [2] zeigen den Preis dafür: 13 Jahre ununterbrochene Pflege. Der Treadmill ist nicht verschwunden, er besteht jetzt aus Kuratieren.

**Kritik in Reviews:**
- Kleine Sprites, Teamfarben schwer erkennbar [7].
- „Micro-sized font“, schlechte iPhone-Skalierung, im Multiplayer muss man die Partie nach jedem Zug verlassen [6].
- Editor-Abstürze, fehlender Zurück-Knopf [5].
- KI „simplistic“, lange KI-Züge auf großen Karten (ein Skip-Knopf hilft) [7].

**Lob:** „no ads“, gute Balance, Strategie zählt, Spieler seit 6+ Jahren [5][6].

## 2. Advance Wars: warum der Loop trägt

- **Zwei Verben, ein Zugende-Knopf.** Kleine Belohnungen (Einheit zerstört, Stadt eingenommen) erzeugen „reward momentum“, also „one more turn“ [9].
- **Heuristiken statt Zahlen.** „Numbers are scary and many players prefer to think in terms of heuristics“ [9]. Die Klassen haben klare Faustregeln, indirektes Feuer erzwingt Formationen [9].
- **Schadensformel.** Basiswert aus der Matrix (Angreifer × Ziel) × (1 + Angriffsbonus + Glück 0–9 % − Verteidigungsbonus − Gelände 0–40 %) × Angreifer-HP/10. Der Geländeschutz skaliert mit den HP des Verteidigers [10]. Weil geschwächte Einheiten schwächer zurückschlagen, lohnt sich der Erstschlag.
- **Schwächen laut Cook:** Versteckte Information zwingt zu Neustarts, die lineare Kampagne bietet keinen Ausweg, viele Karten sind Rätsel statt Strategie. „Never force the player into a dead end challenge“ [9].

## 3. The Battle of Polytopia: Solo-Start, Generator, kleine Käufe

- **Start:** Felix af Ekenstam begann allein; iOS 02/2016, Android 12/2016. 20 Mio. Downloads im März 2024, 25 Mio. 2025 [11].
- **Monetarisierung:** 4 Stämme sind dauerhaft gratis, „no actual paywall“. Käufe kosten 0,99–3,99 $, alle zusammen ~32 $, ausschließlich Einmalkäufe. Die „overwhelming majority“ der Downloads kommt aus Mundpropaganda [12].
- **Team:** zum Zeitpunkt des Interviews fünf Angestellte [12]. „About 80 % of ideas get scrapped“ [13].
- **Generator als Content-Hebel:** 6 Kartentypen (Drylands bis Water World) und 6 Größen von 11×11 (121 Felder) bis 30×30 (900 Felder). Hauptstädte liegen in gleich großen Domänen, 2 Felder vom Domänenrand entfernt. Jeder Stamm hat an der Hauptstadt mindestens zwei gleiche Ressourcen [14].
- **Lesbarkeit als Stilprinzip:** „you should instantly see what's going on“ [12].

## 4. Weitere Referenzen

| Spiel | Team / Modell | Zahlen | Lehre |
|---|---|---|---|
| **Wargroove** (2019) | Chucklefish, Kaufspiel PC/Konsole | Entwicklungskosten nach 3 Tagen eingespielt [16]; Metacritic 84 (Switch) [15] | Kampagnen-Editor mit Verzweigungen [15]; Ziel „snappier“ Partien [17] |
| **Into the Breach** (Mobile 2022) | Subset Games, über Netflix | Google Play: 1,1 Mio. Downloads, 4,77 Sterne, 28 280 Bewertungen [19] | 8×8-Raster, Gegnerangriffe vorher angezeigt, perfekte Information [18] |
| **UniWar** (2009) | Javaground; Werbung + Pro-Abo + IAP | 1 Mio.+ Downloads, 4,1 Sterne, 45 100 Bewertungen [20] | Async-Züge von 3 min bis 3 Tage, 100 000+ Community-Karten, 3 Völker × 10 Einheiten [20], bis zu 30 Partien parallel [21]; Reviews kritisieren den Wechsel zu Abo und IAP [20] |
| **Warbits** (2016) | 2 Personen, Premium iOS | 52 000 Kopien, 173 000 $ brutto, 116 000 $ netto bis Ende 2016. Editor-Backend für 5 500 $ gebaut, nie genutzt. Nach 2 Wochen Editor's Choice stark fallende Verkäufe [22] | Premium = Launch-Spitze, dann Flaute; ein Editor allein schafft keine Community |
| **Hex of Steel** (2020) | Kleinstudio, Kaufspiel PC + Mobile | ~230 000 $ geschätzter Steam-Umsatz bei 24,99 $ [23] | Mod-Support, „no season pass or microtransactions“ [24]; die Nische zahlt für Tiefe |
| **Rusted Warfare** (2011) | Solo-Entwickler, Echtzeit | Android 2011, Steam 2017, iOS 2020 [25] | Einheiten als `.ini`-Textdateien → tausende Community-Mods [25] |

## 5. Was fesselt, was Treadmill ist

**Fesselt:**
- In jeder Runde kleine, sichtbare Gewinne [9].
- Eine Konter-Matrix, die man in zwei Partien lernt [9][20].
- Gebäude bringen Einkommen, Einkommen bringt Tempo.
- Sterne und Zuglimits als Meisterschaftsziel [1][7].
- Asynchrones Spiel gegen Menschen, bei UniWar mit Zugzeiten von 3 min bis 3 Tage [20].

**Treadmill sind handgebaute Kampagnen.**
- Age of Strategy löst das über Community und Kuratierung, braucht dafür aber 13 Jahre laufende Updates [2][8].
- UniWar setzt auf 100 000+ Spielerkarten [20].
- Polytopia umgeht das Problem mit dem Generator [14].
- Warbits zeigt, dass ein Editor allein keine Community schafft [22].

Community-Inhalte bedeuten außerdem dauerhaft Menschenzeit: Meldungen bearbeiten, Inhalte prüfen und löschen.

## 6. Zahlen und Retention

| Titel | Downloads | Bewertung | Modell |
|---|---|---|---|
| Age of Strategy | 1,7 Mio. (13 J.), ~4 200 / 30 Tage | 4,61 (39 000) | gratis, keine Werbung, Gems [2] |
| Zero Touch gesamt | ~3 Mio. (6 Spiele) | Ø 4,65 (62 000) | wie oben [3] |
| Polytopia | 25 Mio. | – | Stämme als IAP, Deckel ~32 $ [11][12] |
| UniWar | 1 Mio.+ | 4,1 | Werbung, Abo, IAP [20] |
| Into the Breach (Netflix) | 1,1 Mio. (Android) | 4,77 | Abo-Plattform [19] |

**Retention:** Öffentliche Werte speziell für Strategie haben wir nicht gefunden. GameAnalytics 2026 über alle Genres (oberes Viertel): D1 knapp über 30 %, D7 6–7 %, D30 1,6–1,8 %, Spielzeit 22–24 min pro Tag. Im Median liegt D7 knapp unter 4 % [32]. **Unser Ziel zum Vergleich:** 10 000 Installs im ersten Jahr sind ≈ 27 pro Tag, also etwa ein Fünftel der heutigen Tagesrate von Age of Strategy (~140).

## 7. KI-Ansätze bei Indies

- **Utility-Scoring statt Entscheidungsbaum.** TinyGenerals (12×12-Hex) begann mit Entscheidungsbäumen wie in Civ 1, die auf kleinen Karten versagten. Stattdessen wird jede mögliche Aktion bewertet, z. B. +400 Kill-Chance, +800 geschwächter Gegner, +500 ungeschütztes Ziel, −220 schlechte Position [26].
- **Einflusskarten.** Der Durchbruch bei TinyGenerals waren Einflusskarten für Bedrohung, Kontrolle und Front. Flankieren entstand dadurch, ohne dass es programmiert wurde. Die KI trennt strategische und taktische Ebene [26]. Dave Mark beschreibt Bedrohungs- und Nähe-Karten anstelle von n²-Distanzberechnungen. Karten werden kombiniert: addieren (Konzentration), invertieren (sichere Felder), multiplizieren (Front). Vorberechnete Templates werden „gestempelt“ [27].
- **Schlagbar ist erwünscht.** Der Reviewer mag, dass „the human has an upper hand“ [7]. Into the Breach erzeugt Spannung durch Transparenz, nicht durch eine kluge KI [18].
- **Kartenfairness per Bot-Turnier.** Lara-Cabrera et al. bewerten generierte Karten mit Turnieren zwischen Bots [28].

## 8. Pixel-Art: Quellen und Lizenzen

| Quelle | Beispiel | Lizenz | Bewertung |
|---|---|---|---|
| Kenney | „Tiny Battle“: 16×16 px, 190 Assets (Einheiten, Gebäude, Gelände) [29] | CC0 | Erste Wahl. Namensnennung nicht nötig, trotzdem in den Credits |
| itch.io | „Basic Tileset Strategy Tactical“: 32×32 px, 100 Tiles, Aseprite-Quelle, Preis frei wählbar [30] | CC-BY 4.0 | Brauchbar mit Namensnennung. Die Lizenz unterscheidet sich je Paket [33] |
| OpenGameArt | gemischt | CC0, CC-BY, OGA-BY, CC-BY-SA, GPL [31] | Nur CC0, CC-BY und OGA-BY. GPL verlangt offenen Quellcode, CC-BY-SA vererbt sich auf abgeleitete Assets, NC verbietet IAP [31] |

Regel: Kacheln aus 16- und 32-px-Sets nicht mischen. Jede Quelle kommt mit URL, Lizenz und Datum in die Credits-Datei.

## 9. Fünf Lehren für unser Spiel

1. **Lesbarkeit und kurze Partien vor Umfang.**
   - Die häufigste Kritik an Age of Strategy und Age of Fantasy betrifft Mini-Sprites, Mini-Schrift und lange KI-Züge [6][7].
   - Polytopia und Wargroove machen Klarheit und Tempo zum Prinzip [12][17].
   - → Für uns: ganzzahlig skalierte Kacheln, HP immer sichtbar, Rundenlimit, KI-Zug überspringbar.
2. **Deterministisch und transparent.**
   - Into the Breach zeigt, dass perfekte Information Spannung erzeugt [18]. Der Glückswurf aus Advance Wars [10] ist verzichtbar.
   - → Für uns: exakte Schadensvorschau. Diese ermöglicht zugleich Replays, Bot-Turniere und asynchrones PvP.
3. **Generator statt Treadmill, Editor nur bewusst.**
   - Polytopia skaliert ohne Handkarten [14].
   - Age of Strategy kuratiert seit 13 Jahren [2][8], Warbits hat 5 500 $ in einen ungenutzten Editor gesteckt [22].
   - → Für uns: Seeds als teilbare Codes kosten keine Moderation.
4. **Fair ohne Währung.**
   - „No ads“ ist das meistgenannte Lob [5].
   - Kleine Einmalkäufe mit Deckel funktionieren (Polytopia [12]). Ein späterer Wechsel zu Abo und IAP kostet Vertrauen (UniWar [20]).
   - → Für uns: Supporter-Kauf und Kosmetik, keine Gems.
5. **KI über Utility-Scoring und Einflusskarten, gemessen per Bot-Turnier.**
   - Das reicht für Skirmish [26][27] und macht Balance und Kartenfairness messbar [28].
   - Die KI darf schlagbar sein [7]. Unfair darf sie nicht sein: keine versteckten Boni.

## Quellen

1. Google Play – Age of Strategy: https://play.google.com/store/apps/details?id=com.zts.ageofstrategy&hl=en
2. AppBrain – Age of Strategy: https://www.appbrain.com/app/age-of-strategy/com.zts.ageofstrategy
3. AppBrain – Zero Touch group: https://www.appbrain.com/dev/Zero+Touch+group/
4. AppBrain – Age of Fantasy: https://www.appbrain.com/app/age-of-fantasy/com.zts.ageoffantasy
5. App Store – Age of Strategy: https://apps.apple.com/us/app/age-of-strategy/id6448704688
6. App Store – Age of Fantasy: https://apps.apple.com/us/app/age-of-fantasy/id6452240753
7. David Sherlock – Age of Strategy Android: https://davidsherlock.co.uk/age-strategy-android/
8. Age of Strategy Forum – Campaign map discussions: https://server.androidutils.com/forum/viewforum.php?f=4
9. Lost Garden (Daniel Cook) – Game Design Review: Advance Wars: https://lostgarden.com/2005/09/14/game-design-review-advance-wars-dual-strike/
10. Advance Wars Wiki – Damage Formula: https://advancewars.fandom.com/wiki/Damage_Formula
11. Wikipedia – The Battle of Polytopia: https://en.wikipedia.org/wiki/The_Battle_of_Polytopia
12. GamingOnPhone – Midjiwan-Interview: https://gamingonphone.com/interviews/midjiwan-interview-delves-into-the-battle-of-polytopias-early-days-concept-stage-monetization-strategies/
13. Pocket Tactics – Polytopia-Interview: https://www.pockettactics.com/the-battle-of-polytopia/interview
14. Polytopia Wiki – Map Generation: https://polytopia.fandom.com/wiki/Map_Generation
15. Wikipedia – Wargroove: https://en.wikipedia.org/wiki/Wargroove
16. Game Developer – Wargroove breaks even after three days: https://www.gamedeveloper.com/business/-i-wargroove-i-breaks-even-after-three-days-on-sale
17. TechRaptor – The Design of Wargroove: https://techraptor.net/gaming/features/the-design-of-wargroove
18. Wikipedia – Into the Breach: https://en.wikipedia.org/wiki/Into_the_Breach
19. AppBrain – Into the Breach (Netflix): https://www.appbrain.com/app/into-the-breach/com.netflix.NGP.IntoTheBreach
20. Google Play – UniWar: https://play.google.com/store/apps/details?id=android.uniwar&hl=en
21. Droid Gamers – UniWar Review: https://www.droidgamers.com/reviews/uniwar-review/
22. Wikipedia – Warbits: https://en.wikipedia.org/wiki/Warbits
23. games-stats – Hex of Steel: https://games-stats.com/steam/game/operation-citadel/
24. Hex of Steel – Website: https://hex-of-steel.fr/
25. Wikipedia – Rusted Warfare: https://en.wikipedia.org/wiki/Rusted_Warfare
26. TinyGenerals – The AI Journey: https://tinygenerals.com/blog/02-ai-journey/
27. Dave Mark – Modular Tactical Influence Maps (Game AI Pro 2, Kap. 30): https://www.gameaipro.com/GameAIPro2/GameAIPro2_Chapter30_Modular_Tactical_Influence_Maps.pdf
28. Lara-Cabrera, Cotta, Fernández-Leiva (2013) – Procedural Balanced Map Generator for Planet Wars: https://link.springer.com/chapter/10.1007/978-3-642-37192-9_28
29. Kenney – Tiny Battle: https://kenney.nl/assets/tiny-battle
30. itch.io – Basic Tileset Strategy Tactical Pixel Art: https://piposchpatz.itch.io/basic-tileset-strategy-tactical-pixel-art
31. Cinevva – Game Asset Licenses Explained: https://app.cinevva.com/guides/game-asset-licenses
32. GameDev Reports – GameAnalytics Mobile and PC Benchmarks 2026: https://gamedevreports.substack.com/p/gameanalytics-mobile-and-pc-game
33. itch.io – Free Assets „Pixel Art“ + „Turn-based Strategy“: https://itch.io/game-assets/free/tag-pixel-art/tag-turn-based-strategy
