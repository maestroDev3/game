# Entscheidung 0005: Portfolio-Betrieb – zwei Spiele parallel entwickeln, versetzt launchen

**Status:** Beschluss zweier unabhängiger Agenten (PORTFOLIO = Produktstrategie, FOKUS = Engineering/Solo-Dev-Realismus) nach drei Debattenrunden am 03.10.2026, von beiden unterzeichnet; **Bestätigung durch den Menschen offen** · **Ändert:** 0004, Abschnitt 6 („zweites Spiel erst nach Rune Rush 1.0“) · **Bezug:** 0003, 0004

## 1. Ausgangslage

Der Mensch will Rune Rush (Match-3-Roguelite, F2P mit Rewarded Ads + Werbefrei-Kauf) und ein zweites, eigenständiges Spiel (rundenbasierte Pixel-Strategie nach Vorbild Age of Strategy) **getrennt und parallel entwickeln und parallel launchen**, um zu sehen, welches mehr Erfolg bringt. Er fragt, ob dafür ein zweites Repo nötig ist und was es als Startpaket braucht. Rahmen: Solo-Entwickler mit 3–6 h/Woche, KI-Agent mit praktisch unbegrenzter Parallelität, Cloud-Sessions ohne Flutter (CI als Testlauf), Google-Play-Pflicht von 14 Tagen Closed Test mit 12 Testern je App.

Beide Agenten kamen unabhängig zum selben Kern: **Der Engpass ist die Zeit des Menschen, nicht die des Agenten.** Deshalb: parallel bauen ja, parallel launchen nein.

## 2. Beschluss

### (1) Entwicklung
- Rune Rush (RR) läuft nach Plan (Versionen 0.1 → 0.2 → 0.3 → 1.0).
- Spiel 2 („Small Realms“, Arbeitstitel) beginnt mit dem Konzept (ehemals Story #49, jetzt in Repo 2). Danach folgt eine **Headless-Spur** in reinem Dart über die CI: Regeln, Kartenformat, KI-Heuristik, Bot-Turniere. Das kostet den Menschen keine Zeit.
- **Spaß-Check**, sobald die KI Zufalls- und Greedy-Bots schlägt: Der Mensch spielt 30 Minuten einen Flutter-Web-Build (GitHub Pages) im Handy-Browser – ohne APK.
- **Umfang 1.0 von Spiel 2:** 2 Fraktionen · höchstens 8 Kampagnen-Missionen als Onboarding (einmalig gebaut) · etwa 10 handgebaute Skirmish-Karten · ein Kartengenerator mit Validator (Erreichbarkeit, Fairness per Bot-Turnier). Karten sind versioniertes JSON. Nach 1.0 kommen keine handgebauten Missionen mehr dazu: **Der Generator ist der eine Content-Hebel nach 0004.** Editor und Community-Inhalte gibt es erst, wenn der Mensch das ausdrücklich entscheidet (dauerhaft 3–5 h/Woche Moderation).

### (2) Launch
- Spiel 2 beginnt eine Phase, die viel Zeit des Menschen braucht (Closed Test, Soft Launch, 1.0), erst, wenn die vorige RR-Phase seit **mindestens 4 Wochen stabil** läuft (keine offenen Crash-Bugs, Store-Arbeit erledigt).
- Nie laufen zwei 14-Tage-Tests oder zwei erste Live-Wochen gleichzeitig. Abstand mindestens 6–8 Wochen.
- Verzug bei RR verschiebt Spiel 2 nur, solange RR nicht pausiert oder über ein Gate gestoppt ist (siehe (5)).

### (3) Repos und Basis
- **Getrennte, öffentliche Repos** (Actions kostenlos, kein Lese-Token für Git-Abhängigkeiten). Repo 1: `maestroDev3/game`. Repo 2: legt der Mensch an (Vorschlag: `maestroDev3/strategy`).
- Gemeinsamer Code wird zunächst **kopiert**; Herkunft mit Commit-Hash in `docs/basis.md`. Ein eigenes Repo `foundation` (per Git-Tag eingebunden) entsteht erst, wenn Spiel 2 die Services (Ads/IAP/Analytics/Save) braucht.

### (4) Regeln für den Agenten über zwei Repos
- Eine Session **schreibt in genau ein Repo** und liest das andere nur (`add_repo`). Ausnahme: `foundation`-Tasks.
- Je Repo höchstens eine Story `in-progress`.
- **Über beide Repos zusammen höchstens 2 Stories in `test`.** Prüfung vor jedem Wechsel nach `test`: `gh issue list -R maestroDev3/<anderes Repo> -l test`. Der Mensch sieht sie auf einem GitHub-Project-Board „Mensch“.
- Ist das Limit erreicht oder läuft gerade eine RR-Launch-Phase: nur Arbeit, die die CI prüfen kann (Regeln, KI, Simulator, Daten, Doku).
- Jede `STAND.md` hat einen Abschnitt „Portfolio“ mit dem Stand des anderen Spiels.

### (5) Zeit des Menschen
- RR hat Vorrang bis 1.0. Spiel 2 bekommt einen festen Slot von **etwa 1 h/Woche** (Entscheidungen, Spaß-Check).
- Verfehlt RR ein Gate (Spaß-Check in 0.1: „noch einen Run“ bei 4 von 5 Testern; D1 ≥ 30 % / D7 ≥ 8 % in 0.2), wird neu entschieden – Spiel 2 ist Plan B.
- Liegen Soft-Launch-Daten beider Spiele vor, wird die Zeit nach vorab festgelegten Schwellen verteilt (z. B. 70/30). Ein Spiel unter der Kill-Schwelle bekommt nur noch Wartung (Crash-Fixes).

### (6) Erfolgsmessung
Kein Direktvergleich der beiden Spiele (Genre, Monetarisierung, Reifegrad und Aufmerksamkeit des Menschen verzerren ihn; bei wenigen Hundert Installs ist D7 Rauschen). Stattdessen je Spiel **vor dem Soft Launch** Schwellen gegen Genre-Werte:
- D1/D7/D30 (oberes Viertel: D1 > 30 %, D7 6–7 %)
- Store-Konversion, organische Installs pro Tag ohne Werbebudget
- Bewertung ≥ 4,3
- Umsatz je 1 000 Installs
- **Installs und € je Arbeitsstunde des Menschen** (Portfolio-Kennzahl)

Auswertung 60 Tage nach Soft Launch, sobald ≥ 1 000 Installs; bei Spiel 2 zusätzlich nach 90 Tagen (Strategie-Communities wachsen langsamer).

### (7) Startpaket Repo 2
**Stufe A – jetzt (nur Doku, vom Agenten vorbereitet):** `CLAUDE.md` (Regeln aus Repo 1, Leitplanken angepasst: Zug 1–3 min, Mission 10–20 min, Autosave nach jedem Zug; Verbotsliste unverändert) · `STAND.md` · `docs/spielkonzept.md` · `docs/recherche/genre.md` · `docs/entscheidungen/` (Verweise auf 0001/0002/0004/0005 in Repo 1; neu: Konzept, Monetarisierung, Paketname, Pixel-Art-Lizenz) · `docs/basis.md` · `docs/PROJEKTANWEISUNG.md` · `.github/ISSUE_TEMPLATE/*` · Labels.
**Stufe B1 – nach Bestätigung des Konzepts:** `packages/game_core/`, Dart-CI (`setup-dart`, `dart test`, zusätzlich `-p chrome` wegen Web-Determinismus), Technik-Teil der Skill-Datei.
**Stufe B2 – sobald RR-Epic #6 grün ist:** `app/`, Flutter-CI, Web-Build-Workflow (GitHub Pages).

### (8) Nächste Schritte
**Bis 8.10. (Handy):** Mensch bestätigt Beschluss, legt öffentliches Repo 2 und Claude-Projekt an (~10 min), beantwortet die Fragen unter (9). Agent pusht Stufe A, schließt #48/#49 in Repo 1 mit Verweis, aktualisiert `STAND.md`.
**Ab 8.10. (PC):** Mensch startet Play-Identitätsprüfung (dauert Tage), richtet Branch-Protection und Board „Mensch“ ein, lokale Flutter-Session. Agent setzt RR #14 um; nach Konzept-Bestätigung Stufe B1 und erstes Headless-Epic; sobald #6 grün: Stufe B2.

### (9) Entscheidungen des Menschen (mit Empfehlung der Agenten)
1. Beschluss bestätigen? *(ja)*
2. Repo 2 jetzt anlegen, öffentlich, neutraler Arbeitstitel? *(ja; umbenennen geht später)*
3. Was heißt „10 000“? *(Installs je Spiel im ersten Jahr; Umsatz als zweites Ziel)*
4. Monetarisierung Spiel 2? *(ohne Werbung; Supporter-Kauf + Kosmetik)*
5. Umfang 1.0 wie in (1)? *(ja)*
6. **Restdissens:** Content-Hebel für Spiel 2 langfristig – nur Generator (keine Zeit des Menschen) oder zusätzlich Community-Inhalte wie beim Vorbild (Bindung, aber 3–5 h/Woche Moderation)? *(Generator zuerst; Community erst nach 1.0 und nur mit Zeitbudget)*

## 3. Begründung (Kurzfassung der Debatte)

- **Zwei Ressourcen, nicht eine:** Agentenzeit ist parallelisierbar, Menschzeit nicht. Beide Spiele in Entwicklung kosten den Menschen 4–6 h/Woche (passt knapp); eins im Launch + eins in Entwicklung 8–12 h (kippt); beide im Launch 12–18 h (kippt sicher). Daraus folgt „parallel bauen, versetzt launchen“ zwingend.
- **Paralleler Launch misst das Falsche:** Zwei Einzelfälle sind kein Experiment. Versetzt lernt man mehr, weil Store-, Consent- und ASO-Fehler nur einmal passieren.
- **Einmalkosten amortisieren sich:** Accounts 6–10 h einmalig, danach ~3 h je weiterer App; Tester-Pool (~15 Personen) wird einmal rekrutiert und für beide Closed Tests genutzt.
- **Spiel 2 ist größer als Spiel 1** (KI, Kampagne, Kartenformat). Headless-Start und harter Umfangsschnitt halten es im Rahmen; der Generator statt Editor vermeidet den Level-Treadmill und die Moderationslast.

## 4. Verworfene Alternativen

| Alternative | Warum verworfen |
|---|---|
| Beide Spiele parallel launchen (Vorschlag des Menschen) | Überlastet den Menschen in den Launch-Fenstern (12–18 h/Woche), liefert keinen sauberen Vergleich, wiederholt Anfängerfehler zweimal. |
| Spiel 2 erst nach RR 1.0 beginnen (0004, Abschnitt 6) | Lässt Agentenkapazität monatelang ungenutzt; Headless-Arbeit kostet den Menschen nichts. |
| Monorepo | Jede Session trägt den Kontext des anderen Spiels mit; getrennte Issue-Bäume und Store-Identitäten sind sauberer. |
| Repo 2 erst nach grüner CI in Repo 1 | Ein Doku-Repo kostet am Handy 10 Minuten und ist der richtige Ort für das Konzept; Technik folgt gestuft. |
| Map-Editor + Community-Content in 1.0 | Warbits-Lehre (5 500 $ für einen nie genutzten Editor); Moderation 3–5 h/Woche belastet genau den Engpass. Erst nach ausdrücklicher Entscheidung. |

## 5. Quellen

- Debattenprotokoll (3 Runden, beide Agenten): Sitzung vom 03.10.2026, Zusammenfassung oben; Marktzahlen aus `docs/recherche/marktanalyse.md` und `docs/recherche/design-dossier.md`.
- GitHub Actions: Standard-Runner sind für öffentliche Repositories kostenlos: https://docs.github.com/en/billing/managing-billing-for-your-products/about-billing-for-github-actions
