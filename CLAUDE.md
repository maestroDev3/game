# CLAUDE.md – Small Realms (Arbeitstitel)

Mobile-Spiel für Android und iOS: **rundenbasierte Pixel-Strategie** (Advance-Wars-Loop, Vorbild Age of Strategy), kostenlos ohne Werbung, Supporter-Kauf + Kosmetik. Zweites Spiel des Portfolios neben Rune Rush (`maestroDev3/game`). Ein Mensch (Produktentscheidungen, Tests, Accounts, Community) und ein KI-Agent (Planung, Umsetzung, Tests, Doku) arbeiten über GitHub Issues zusammen. Der Agent arbeitet weitgehend autonom.

## Dokumentenkarte

| Datei | Inhalt |
|---|---|
| `STAND.md` | Kurzfassung des Projektstands – **zuerst lesen** |
| `docs/spielkonzept.md` | Was wir bauen: Core Loop, Einheiten, Karten, Generator, KI, Kampagne, Meta, Monetarisierung, Versionen |
| `docs/recherche/genre.md` | Genre-Recherche mit Quellen (Age of Strategy, Advance Wars, Polytopia, Wargroove, Into the Breach, UniWar, Warbits) |
| `docs/entscheidungen/` | Entscheidungen dieses Repos; Grundlagen (Planungsstruktur, Engine, Produktstrategie, Portfolio-Betrieb) per Verweis auf `maestroDev3/game` |
| `docs/basis.md` | Was aus Rune Rush übernommen wurde, mit Commit-Hash |
| `.claude/skills/flutter-dart/SKILL.md` | Technische Regeln, Projektstruktur, Befehle, **Definition of Done (Abschnitt 7)** |
| `.github/ISSUE_TEMPLATE/` | Vorlagen für Initiative, Epic, Story, Task |
| `docs/PROJEKTANWEISUNG.md` | Text für die Anweisungen des Claude-Projekts zu diesem Spiel |

## Portfolio-Regeln (aus `maestroDev3/game`, `docs/entscheidungen/0005`)

- **Rune Rush hat Vorrang** auf die Zeit des Menschen bis Rune Rush 1.0. Dieses Spiel bekommt etwa 1 h/Woche (Entscheidungen, Spaß-Check).
- Eine Session schreibt in genau ein Repo und liest das andere nur (`add_repo`). Je Repo eine Story `in-progress`. **Über beide Repos zusammen höchstens 2 Stories in `test`** – vor jedem Wechsel nach `test`: `gh issue list -R maestroDev3/game -l test`. Ist das Limit erreicht oder läuft eine Rune-Rush-Launch-Phase (Closed Test, Soft Launch, 1.0): nur CI-prüfbare Arbeit (Regeln, KI, Generator, Simulator, Daten, Doku).
- **Entwicklung headless zuerst:** Regeln, Kartenformat, Generator, KI, Bot-Turniere in reinem Dart über die CI. App und Gerätetests erst nach dem Spaß-Check (Flutter-Web-Build, Handy-Browser) und erst, wenn Rune-Rush-Epic #6 (CI) grün ist (Stufe B2).
- **Launch versetzt:** Eine Phase mit hohem Zeitbedarf des Menschen beginnt hier erst, wenn die vorige Rune-Rush-Phase seit ≥ 4 Wochen stabil läuft; nie zwei 14-Tage-Tests gleichzeitig.
- Gemeinsamer Code wird zunächst kopiert (Herkunft in `docs/basis.md`); ein `foundation`-Repo entsteht erst, wenn beide Spiele dieselben Services brauchen.
- `STAND.md` führt einen Abschnitt „Portfolio“ mit dem Stand von Rune Rush.

## Sprache und Konventionen

- Issues, STAND.md, Docs, PR-Beschreibungen: **Deutsch**. Code, Bezeichner, Kommentare, Commit-Messages: **Englisch** (Conventional Commits: `feat:`, `fix:`, `test:`, `docs:`, `chore:`).
- Spieltexte: Englisch (Quelle) und Deutsch, nur in ARB-Dateien.
- Kein Gherkin in Issues; bei Verhalten „Wenn …, dann …“.

## Session-Ablauf des Agenten

1. `STAND.md` lesen, dann die betroffenen Issues.
2. Portfolio-Regeln prüfen (Stories in `test` im anderen Repo, Rune-Rush-Phase).
3. Prüfen, ob Dart/Flutter verfügbar ist (`which dart flutter`). In Cloud-Sessions fehlt beides – dann gilt Abschnitt 3 der Skill-Datei (CI als Testlauf).
4. Arbeiten laut „Arbeitsablauf“. Nach jeder Statusänderung `STAND.md` aktualisieren und committen.
5. Am Ende: kurze Zusammenfassung an den Menschen – was erledigt, was er testen/entscheiden muss.

## Arbeitsablauf (Task → PR → Merge)

- **Ein Task = ein Branch = ein PR.** Branch `task/<nr>-kurztitel` von `main`. TDD laut Skill-Datei, Abschnitt 6.
- PR-Titel: Task-Titel; Beschreibung: Zweck, Umsetzung, Testnachweis, `Closes #<task>`. Attributions-Zeilen laut Session-Vorgabe anhängen.
- Kleine Commits, früh pushen. Niemals `--force` auf `main`. Niemals Secrets committen.
- Geschlossene Issues werden nie angepasst oder wieder geöffnet. Neue Erkenntnis → neues Issue mit „Bezug: #nr“.

## Mergen

| Ebene | Wer schließt | Bedingung |
|---|---|---|
| **Task** | Agent (Squash-Merge, Branch löschen) | CI grün, Definition of Done (Skill, Abschnitt 7) erfüllt, `Closes #nr` im PR |
| **Story** | Mensch (oder Agent auf Zuruf) | Alle Tasks gemerged, Smoke-Test in CI grün, Story bekommt Label `test` + Kommentar „Bereit zum Test“ mit Akzeptanzkriterien als Checkliste und Link zum Artefakt (Web-Build-URL oder APK). Headless-Stories (nur `game_core`) gelten als getestet, wenn Bot-Turnier und Tests grün sind – sie gehen nicht nach `test`, sondern werden vom Agenten geschlossen. |
| **Epic** | Agent schlägt vor, Mensch bestätigt | Alle Stories geschlossen, Smoke-Test grün, vom Menschen getestet |
| **Initiative** | **Nur der Mensch** | Alle Epics zu und „Fertig, wenn“ erfüllt; Agent schlägt es vor |

**Smoke-Test** = bis Stufe B2: `dart test` + Bot-Turnier (KI gegen KI, 200 Partien, keine Exception, keine Partie über Rundenlimit ohne Ergebnis). Ab Stufe B2 zusätzlich: App startet bis zum Hauptmenü (Integration-Test) und Release-Build.

Während eine Story in `test` wartet, darf der Agent die nächste `ready`-Story beginnen (nur eine Story `in-progress`).

## Struktur: Initiative → Epic → Story → Task

Alles lebt in GitHub-Issues, verknüpft über Sub-Issues:

| Ebene | Label | Inhalt |
|---|---|---|
| Initiative | `initiative` | Langlebiges Oberthema; Epics als Sub-Issues |
| Epic | `epic` | Endliches Vorhaben; Stories als Sub-Issues, Reihenfolge in der Beschreibung |
| Story | `story` | Für den Nutzer sichtbares Feature; Tasks als Sub-Issues |
| Task | `task` | Genau ein PR, TDD, testbare Akzeptanzkriterien |

Status einer Story (Label, genau eins; erledigt = geschlossen):
- `backlog` – Idee, grob beschrieben, noch keine Tasks
- `ready` – verfeinert, Tasks mit Akzeptanzkriterien stehen
- `in-progress` – wird gerade umgesetzt (immer nur eine Story gleichzeitig)
- `test` – alle Tasks gemerged, wartet auf Test durch den Menschen

Regeln:
- Tasks werden erst geschrieben, wenn eine Story von `backlog` nach `ready` wechselt.
- Welche Story als Nächstes umgesetzt wird, entscheidet der Mensch; ohne Vorgabe die nächste `ready`-Story laut Reihenfolge im Epic.

## Initiativen und Epics: Konvention

Ein Epic ist ein **endliches Vorhaben**, dauerhafte Themen liegen eine Ebene darüber (Initiativen).

**Initiativen** (Label `initiative`)
- Langlebiges Oberthema mit Zielbild: Warum, Nutzen, Gehört dazu / nicht dazu, Epics, „Fertig, wenn“ (1–3 grobe Aussagen). Kein Status-Label, keine Reihenfolge, kein Fortschrittswert.
- Ohne offene Epics **ruht** eine Initiative und bleibt offen (Stand: „Ruht“).
- **Nur der Mensch schließt Initiativen.** Der Agent schlägt es vor, wenn alle Epics zu sind und „Fertig, wenn“ erfüllt ist.
- Folgearbeit zu einer geschlossenen Initiative = **neue** Initiative mit eigenem, ergebnisbezogenem Titel (kein „v2“) und „Bezug: #alt“.

**Epics** (Label `epic`)
- **Endlich.** Ergebnisbezogener Titel, nie „… II“ oder Nummern. Geschlossen, sobald alle Stories geschlossen sind; im Abschlusskommentar ggf. Folge-Epics.
- **Genau eine Initiative als Parent**, gewählt nach dem Hauptnutzen. Passt ein Epic auch zu einer zweiten, steht dort „Siehe auch: #nr“.

**Für alle Ebenen**
- **Geschlossen bleibt geschlossen.** Der Agent öffnet **nie** ein geschlossenes Issue wieder. Neue Arbeit zu etwas Erledigtem wird ein **neues** Issue mit „Bezug: #nr“.
- **Keine Waisen:** jede Story hat genau ein Epic, jedes Epic genau eine Initiative.
- **Neue Idee:** `backlog`-Story in einem offenen Epic, das genau dieses Ziel verfolgt → sonst neues Epic in der passenden offenen Initiative → sonst neue Initiative. Der Agent legt sofort an (keine Rückfrage) und trägt alles, was oberhalb einer Story neu ist, in `STAND.md` unter „Offene Entscheidungen“ ein („neu angelegt – bitte bestätigen oder umsortieren“).

## Issue-Vorlagen (Jira-Stil)

Jedes Issue sagt, **wofür** es da ist, **welchen Nutzen** es hat und **wann es fertig** ist. Vorlagen: `.github/ISSUE_TEMPLATE/` – der Agent schreibt Issues per API immer nach dieser Gliederung.

- **Story:** Ziel als „Als Nutzer möchte ich …, damit …“, Nutzen, Nicht-Umfang, **Akzeptanzkriterien aus Nutzersicht**, Entscheidungen, Tasks.
- **Task:** Zweck (welches Story-Kriterium), Umsetzung, **technische Akzeptanzkriterien – jedes wird genau ein Test**, Abhängig von. Definition of Done per Verweis.
- **Epic:** Ergebnis, Nutzen, Umfang/Nicht-Umfang, Stories (Reihenfolge), „Fertig, wenn“ als Verweiszeile auf die Merge-Regeln.
- **Nachziehen:** Backlog-Stories bekommen die volle Vorlage beim Wechsel nach `ready`. Geschlossene Issues werden nie angepasst.
- Sub-Issues per API: `POST /repos/{owner}/{repo}/issues/{parent}/sub_issues` mit `sub_issue_id` (Datenbank-ID, nicht Nummer).

## Stand pflegen (`STAND.md`)

Kurzfassung des Projektstands; muss immer zu den Issues passen. Aktualisieren, sobald sich etwas ändert. Inhalt: Portfolio · In Arbeit · Zum Test · Als Nächstes · Backlog nach Initiative → Epic (offene Epics mit „x von y Stories zu“, ruhende Initiativen unter „Ruht“) · Zuletzt erledigt (höchstens 5) · Offene Entscheidungen · Datum. Kurz halten: Nummer + Titel.

## Design-Leitplanken (bindend für jede Story)

Aus `docs/recherche/genre.md` und `docs/spielkonzept.md`:

**Pflicht in jeder Version**
- Ein Zug 1–3 Minuten, eine Partie/Mission 10–20 Minuten, **Autosave nach jedem Zug**, jederzeit unterbrechbar.
- Core-Gameplay in unter 60 Sekunden erreichbar, kein Login, Hinweise ≤ 8 Wörter; Aha-Moment („ich weiß vorher, was passiert“) < 90 s.
- **Deterministisch und transparent:** exakte Schadensvorschau, kein Glückswurf; gleiche Seeds = gleiche Karte und gleiche KI-Züge.
- Lesbarkeit vor Umfang: ganzzahlig skalierte Kacheln, HP immer sichtbar, Rundenlimit, KI-Zug überspringbar, KI-Zug < 5 s.
- Content aus dem **Generator** (mit Validator: Erreichbarkeit, Fairness per Bot-Turnier). Handgebaut nur die ≤ 8 Onboarding-Missionen und ~10 Skirmish-Karten für 1.0 – danach nie wieder.
- KI per Heuristik (Utility-Scoring, Einflusskarten), schlagbar, aber ohne versteckte Boni.
- Juice sparsam, aber vorhanden: Hit-Stop, fliegende Zahlen, Einnahme-Fanfare.
- Analytics für FTUE-Funnel, D1/D7, Abschlussrate je Mission, Partiedauer.

**Verboten (kein Code-Pfad dafür)**
- Werbung jeder Art (Marke „ohne Werbung“); Leben/Energie; Wartezeiten.
- Pay-to-Win: keine kaufbaren Einheiten, Werte oder KI-Erleichterungen; keine Währung (auch keine „Gems“); bezahlte Zufallsitems.
- Countdown-Angebote, Confirmshaming, Streak-Verlust ohne Freeze, Push 22–7 Uhr.
- Map-Editor und Community-Upload ohne ausdrückliche Entscheidung des Menschen (Moderation 3–5 h/Woche).
- Kinder-Zielgruppe; Echtzeit-Multiplayer.

Wer eine Story schreibt, die dagegen verstößt, legt sie nicht an, sondern trägt sie unter „Offene Entscheidungen“ ein.

## Technik

Siehe `.claude/skills/flutter-dart/SKILL.md`. Kurz: reines Dart-Package `packages/game_core` (map, units, combat, ai, campaign, sim; nur Ganzzahlen, web-sicher), Dart-CI mit `dart test` auch unter `-p chrome`; ab Stufe B2 Flutter ≥ 3.44 + Flame 1.38.x, Riverpod 3, Firebase (Analytics, Crashlytics), RevenueCat für Einmalkäufe – kein Ads-SDK. Keine neuen Dependencies ohne ADR.

## Was der Mensch tut (nicht der Agent)

- Entscheidungen unter „Offene Entscheidungen“ in `STAND.md` treffen; Spaß-Check im Browser (30 min).
- Stories auf dem Gerät testen und schließen; Initiativen schließen.
- Accounts und Secrets (Play, Apple, Firebase, RevenueCat) – dieselben wie für Rune Rush, nur neue App-Einträge.
- Community, Store-Texte freigeben.
