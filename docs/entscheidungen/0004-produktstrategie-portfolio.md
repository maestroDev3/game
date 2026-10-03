# Entscheidung 0004: Produktstrategie – Portfolio kleiner Spiele auf einer gemeinsamen Basis

**Status:** vom Menschen am 03.10.2026 geäußert, vom Agenten festgehalten; Details (Zielgröße) offen · **Datum:** 2026-10-03
**Bezug:** 0003 (Spielkonzept Rune Rush)

## 1. Ausgangslage

Der Mensch hat die Zielsetzung präzisiert: „Wir müssen keine 100 Millionen verdienen. Wenn wir mit 10 000 anfangen, passt das. Erfahrung sammeln, mehr auf den Markt bringen.“ Als Vorbild nannte er **Age of Strategy** (Zero Touch group): ein Solo-Entwickler, rundenbasierte Pixel-Strategie, seit 2013, 1,7 Mio. Downloads, 4,6 Sterne, kostenlos ohne Werbung, Gems als faire Spende, 350+ Einheiten und 500+ Karten zu großen Teilen aus der Community – und aus derselben Engine fünf weitere thematische Spiele (Age of Fantasy, Modern Wars, World Wars, Galaxy, Alder; zusammen ~3 Mio. Installs).

## 2. Entscheidung

1. **Portfolio statt Einzelwette.** Das Ziel ist nicht ein Hit, sondern mehrere kleine, saubere Spiele, die jeweils eine Nische besetzen und voneinander lernen. Erstes Umsatzziel in der Größenordnung **10 000** (Einheit zu bestätigen: € Umsatz oder Spieler), nicht Millionen.
2. **Eine gemeinsame Basis.** Rune Rush wird so gebaut, dass das zweite Spiel die Hälfte geschenkt bekommt: Seeded-RNG, Save/Migration, Service-Interfaces (Ads, IAP, Analytics, Remote Config), Lokalisierung, Shop-/Album-UI, CI/Release-Pipeline, Compliance-Checkliste. Technisch: wiederverwendbare Teile liegen in eigenen Packages (`packages/game_core` bleibt spielspezifisch; Querschnitt wandert nach `packages/foundation`, sobald das zweite Spiel beginnt – nicht vorher).
3. **Content-Hebel bewusst wählen.** Pro Spiel genau einer: kombinatorisch (Rune Rush: Runen × Bretter), prozedural (Tower Defense: Pfade/Wellen) oder Community (Pixel-Strategie: Editor + Forum). Kein Spiel mit handgebautem Level-Treadmill.
4. **Faire Monetarisierung bleibt Marke.** Age of Strategy zeigt, dass „kostenlos, ohne Werbung, Gems als Dank“ über Jahre Vertrauen und Bewertungen bringt. Für Rune Rush bleibt F2P fair (0003); pro Spiel wird entschieden, ob Rewarded Ads überhaupt nötig sind.
5. **Erfahrung ist ein Ergebnis.** Jede Veröffentlichung liefert Zahlen (D1/D7, ARPDAU, Store-Prozess) in `docs/recherche/` oder `docs/entscheidungen/`, die das nächste Spiel nutzt.
6. **Reihenfolge:** Rune Rush zuerst bis Version 1.0 (Store-Erfahrung, Pipeline, Community). Parallel nur Konzeptskizzen für Kandidaten (#45 Tower Defense, #48 Pixel-Strategie). Das zweite Spiel startet erst, wenn Rune Rush im Store ist und die Basis-Packages extrahiert sind.

## 3. Begründung

- **Risikostreuung:** Die Marktanalyse zeigt 1 von 100 Indie-Spielen über 10 000 $/Monat. Mehrere Versuche mit sinkenden Grenzkosten (gemeinsame Basis) erhöhen die Trefferchance mehr als ein längerer Einzelversuch.
- **Lernkurve:** Store-Prozesse, Consent, Signing, Tester-Phase und Community-Aufbau müssen einmal gelernt werden; danach kosten sie pro Spiel wenig.
- **Vorbild bestätigt das Modell:** Zero Touch hat mit einer Engine und Community-Content sechs Spiele mit ~3 Mio. Installs ohne Werbung und ohne Marketingbudget aufgebaut.
- **Passt zu Solo + KI-Agent:** Systemische Spiele mit Daten-Content sind für den Agenten günstig; Pixel-Art hält den Grafikaufwand klein und ist bei Spielern akzeptiert.

## 4. Verworfene Alternativen

| Alternative | Warum verworfen |
|---|---|
| Alles auf ein Spiel setzen, bis es „groß“ ist | Hohe Varianz, keine Lernzyklen; die Vorbilder im Solo-Bereich sind kleine, lange gepflegte Titel. |
| Sofort mit mehreren Spielen parallel starten | Zersplittert einen Solo-Entwickler; die Basis existiert noch nicht. Erst ein Spiel in den Store. |
| Gemeinsame Basis von Tag 1 als eigenes Framework bauen | Abstraktion ohne zweiten Nutzer wird falsch; erst extrahieren, wenn das zweite Spiel sie braucht. |

## 5. Offen (Mensch)

- Einheit des ersten Ziels: 10 000 € Umsatz (Zeitraum?) oder 10 000 Spieler/Downloads?
- Reihenfolge der Kandidaten für das zweite Spiel: Tower Defense (#45) oder Pixel-Strategie (#48)?
- Werbung grundsätzlich: Rune Rush mit Rewarded Ads (0003) oder nach Age-of-Strategy-Vorbild ganz ohne Werbung, nur Werbefrei-/Supporter-Kauf und Kosmetik?

## 6. Quellen

- AppBrain – Age of Strategy (1,7 Mio. Downloads, 4,61 Sterne, seit 10/2013): https://www.appbrain.com/app/age-of-strategy/com.zts.ageofstrategy
- AppBrain – Zero Touch group (6 Spiele, ~3 Mio. Installs): https://www.appbrain.com/dev/Zero+Touch+group/
- Google Play – Age of Strategy (500+ Kampagnenkarten, 350+ Einheiten, „not pay to win“, Map-Editor, Forum): https://play.google.com/store/apps/details?id=com.zts.ageofstrategy&hl=en
- David Sherlock – Age of Strategy Android (Community-Kampagnen, Gem-Modell): https://davidsherlock.co.uk/age-strategy-android/
