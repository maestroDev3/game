# Entscheidung 0002: Spielkonzept – rundenbasierte Pixel-Strategie „Small Realms“ (Arbeitstitel)

**Status:** vom Agenten vorgeschlagen, **Bestätigung durch den Menschen offen** · **Datum:** 2026-10-03
**Grundlage:** `docs/recherche/genre.md`, `docs/spielkonzept.md`; Wunsch des Menschen (03.10.2026): Vorbild Age of Strategy.

## 1. Ausgangslage
Der Mensch will als zweites Spiel ein Pixel-Strategiespiel in der Richtung von Age of Strategy (Zero Touch group: 1,7 Mio. Downloads, 4,6 Sterne, kostenlos ohne Werbung, Community-Content, sechs Spiele auf einer Engine). Rahmen: Solo + KI-Agent, Rune Rush hat Vorrang, dieses Spiel bekommt ≈ 1 h/Woche vom Menschen.

## 2. Entscheidung
1. **Advance-Wars-Loop:** Rasterkarte, Einheiten einmal pro Runde bewegen und angreifen/einnehmen, Gebäude bringen Einkommen, Rekrutieren im HQ/Kaserne; Sieg durch HQ-Einnahme oder Vernichtung, Rundenlimit.
2. **Deterministisch, perfekte Information:** exakte Schadensvorschau, kein Glückswurf (Lehre aus Into the Breach); ermöglicht Replays, Bot-Turniere, später asynchrones PvP.
3. **Einheiten als Daten:** 2 Fraktionen mit je 6–8 Typen (JSON: Kosten, Bewegung, Reichweite, Angriff, Verteidigung, Rüstungsklasse), Schadensmatrix Stein-Schere-Papier, Gelände-Boni.
4. **Content-Hebel = Kartengenerator** mit Validator (Erreichbarkeit, Symmetrie/Fairness per Bot-Turnier). Handgebaut nur: ≤ 8 Onboarding-Missionen und ~10 Skirmish-Karten für 1.0. Seed-Codes zum Teilen statt Editor.
5. **KI per Heuristik** (Bedrohungs-/Einflusskarten, Utility-Scoring), 3 Stufen, schlagbar ohne versteckte Boni; Bot-Turniere in der CI als Balancing-Instrument.
6. **Headless zuerst:** `game_core` in reinem Dart, Spaß-Check per Flutter-Web-Build im Handy-Browser, App erst danach.
7. **Lesbarkeit vor Umfang:** ganzzahlig skalierte 16-px-Kacheln, HP immer sichtbar, KI-Zug < 5 s und überspringbar, Partie 10–20 min, Autosave nach jedem Zug.

## 3. Begründung
- Meistgenannte Kritik an Age of Strategy/Age of Fantasy: Mini-Sprites, Mini-Schrift, lange KI-Züge → Lesbarkeit und Tempo als Prinzip (Polytopia, Wargroove).
- Content-Treadmill vermeiden (0004): Zero Touch kuratiert seit 13 Jahren Community-Karten; Warbits hat 5 500 $ in einen nie genutzten Editor gesteckt; Polytopia skaliert mit Generator.
- Determinismus macht das Spiel für den Agenten testbar und für Spieler planbar (perfekte Information erzeugt Spannung).
- Rundenbasiert = kein Performance-Risiko in Flame, keine Server, kein Echtzeit-Netcode.

## 4. Verworfene Alternativen
| Alternative | Warum verworfen |
|---|---|
| Age-of-Strategy-Klon mit 350+ Einheiten und Community-Editor in 1.0 | Content- und Moderationslast (3–5 h/Woche) trifft genau den Engpass; Umfang ist der häufigste Scheitergrund. |
| Hex-Felder statt Quadrat-Raster | Schöner, aber Pathfinding, Generator und Touch-Treffer sind aufwendiger; 1.x-Option. |
| Glückswurf wie Advance Wars (Schadensstreuung) | Verhindert exakte Vorschau und Replays; Into the Breach zeigt, dass Determinismus trägt. |
| Echtzeit-Strategie | Netcode, Server, Anti-Cheat; nicht Solo-tauglich. |
| 3+ Fraktionen in 1.0 | Je Fraktion Balancing- und Art-Aufwand; Fraktion 3 erst nach Daten, ggf. als IAP. |

## 5. Offen (Mensch)
Konzept bestätigen; Hex vs. Raster (Empfehlung Raster); Name.
