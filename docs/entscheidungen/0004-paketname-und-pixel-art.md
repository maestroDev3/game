# Entscheidung 0004: Paketname und Pixel-Art-Quelle

**Status:** Vorschlag, **Entscheidung durch den Menschen offen** · **Datum:** 2026-10-03

## Paketname / Bundle-ID
- Vorschlag: `de.maestrodev.smallrealms` (Android `applicationId`, iOS Bundle-ID). Lässt sich nach dem ersten Store-Upload **nicht** mehr ändern – deshalb vor Stufe B2 festlegen, auch wenn der Spielname später wechselt.
- Arbeitstitel „Small Realms“: neutral, beschreibend; Markenprüfung (Stores, DPMA/EUIPO-Suche) vor dem Store-Listing.

## Pixel-Art
| Quelle | Lizenz | Einsatz |
|---|---|---|
| Kenney „Tiny Battle“ (16×16 px, 190 Assets: Einheiten, Gebäude, Gelände) | CC0 | **Startwahl** für 0.1–0.3; Credits trotzdem nennen |
| itch.io-Tilesets (z. B. „Basic Tileset Strategy Tactical“, 32 px) | CC-BY 4.0 (je Paket prüfen) | Nur mit Namensnennung; nicht mit 16-px-Sets mischen |
| OpenGameArt | CC0 / CC-BY / OGA-BY | Nur diese drei Lizenzen; **kein** GPL (verlangt offenen Quellcode), **kein** CC-BY-SA (vererbt sich), **kein** NC (verbietet IAP) |

Regeln: eine Kachelgröße (16 px, ganzzahlig skaliert), jede Quelle mit URL, Lizenz und Datum in `assets/CREDITS.md`; keine erkennbar KI-generierten Store-Assets (Spielerakzeptanz). Eigene oder gekaufte Art ab 1.0 ist eine Entscheidung des Menschen.

Quellen: `docs/recherche/genre.md`, Abschnitt 8.
