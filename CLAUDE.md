# CLAUDE.md – Rune Rush (Arbeitstitel)

Mobile-Spiel für Android und iOS: **Match-3-Roguelite** (Candy-Crush-Vertrautheit × Balatro-Tiefe), Free-to-Play mit fairer Monetarisierung. Ein Mensch (Produktentscheidungen, Tests, Accounts, Community) und ein KI-Agent (Planung, Umsetzung, Tests, Doku) arbeiten über GitHub Issues zusammen. Der Agent arbeitet weitgehend autonom.

## Dokumentenkarte

| Datei | Inhalt |
|---|---|
| `STAND.md` | Kurzfassung des Projektstands – **zuerst lesen** |
| `docs/spielkonzept.md` | Was wir bauen: Core Loop, Scoring, Runen, Meta, Monetarisierung, Versionen |
| `docs/entscheidungen/` | Entscheidungen mit Begründung (0001 Planungsstruktur, 0002 Engine, 0003 Konzept, 0004 Produktstrategie, 0005 Portfolio-Betrieb) |
| `docs/recherche/` | Marktanalyse, Engine-Vergleich, Design-Dossier (Quellen) |
| `.claude/skills/flutter-dart/SKILL.md` | Technische Regeln, Projektstruktur, Befehle, **Definition of Done (Abschnitt 7)** |
| `.github/ISSUE_TEMPLATE/` | Vorlagen für Initiative, Epic, Story, Task |
| `docs/PROJEKTANWEISUNG.md` | Text für die Anweisungen des Claude-Projekts „Game“ |

## Produktstrategie (Kurzfassung von `docs/entscheidungen/0004`)

Portfolio kleiner, sauberer Spiele statt Einzelwette; erstes Ziel in der Größenordnung 10 000, nicht Millionen. Rune Rush ist das erste Spiel; Ideen für weitere Modi und Spiele leben in Initiative #44 und `docs/spielkonzept.md`, Abschnitt 10. Beim Bauen gilt: Querschnitt (RNG, Save, Services, Lokalisierung, Shop-/Album-UI, CI) so schreiben, dass das zweite Spiel ihn übernehmen kann – extrahiert wird aber erst, wenn das zweite Spiel beginnt. Pro Spiel genau ein Content-Hebel (kombinatorisch, prozedural oder Community), nie handgebauter Level-Treadmill.

**Betrieb über zwei Repos** (`docs/entscheidungen/0005`): Spiel 2 „Small Realms“ lebt in einem eigenen Repo. Eine Session schreibt in genau ein Repo und liest das andere nur. Je Repo eine Story `in-progress`; **über beide Repos zusammen höchstens 2 Stories in `test`** – vor jedem Wechsel nach `test` im anderen Repo prüfen (`gh issue list -R maestroDev3/<repo> -l test`). Ist das Limit erreicht oder läuft eine Rune-Rush-Launch-Phase (Closed Test, Soft Launch, 1.0), nur CI-prüfbare Arbeit. Rune Rush hat Vorrang auf die Zeit des Menschen bis 1.0. `STAND.md` führt einen Abschnitt „Portfolio“.

## Sprache und Konventionen

- Issues, STAND.md, Docs, PR-Beschreibungen: **Deutsch**. Code, Bezeichner, Kommentare, Commit-Messages: **Englisch** (Conventional Commits: `feat:`, `fix:`, `test:`, `docs:`, `chore:`).
- Spieltexte: Englisch (Quelle) und Deutsch, nur in ARB-Dateien.
- Kein Gherkin in Issues; bei Verhalten „Wenn …, dann …“.

## Session-Ablauf des Agenten

1. `STAND.md` lesen, dann die betroffenen Issues (`gh issue view`).
2. Prüfen, ob Flutter verfügbar ist (`which flutter`). In Cloud-Sessions fehlt es – dann gilt Abschnitt 3 der Skill-Datei (CI als Testlauf).
3. Arbeiten laut Abschnitt „Arbeitsablauf“. Nach jeder Statusänderung `STAND.md` aktualisieren und committen.
4. Am Ende: kurze Zusammenfassung an den Menschen – was erledigt, was er testen/entscheiden muss.

## Arbeitsablauf (Task → PR → Merge)

- **Ein Task = ein Branch = ein PR.** Branch `task/<nr>-kurztitel` von `main`. TDD laut Skill-Datei, Abschnitt 6.
- PR-Titel: Task-Titel; Beschreibung: Zweck, Umsetzung, Testnachweis, `Closes #<task>`. Attributions-Zeilen laut Session-Vorgabe anhängen.
- **Mergen** – siehe eigener Abschnitt unten.
- Kleine Commits, früh pushen. Niemals `--force` auf `main`. Niemals Secrets (Keystore, API-Keys, `google-services.json` mit echten Werten) committen.
- Geschlossene Issues werden nie angepasst oder wieder geöffnet. Neue Erkenntnis → neues Issue mit „Bezug: #nr“.

## Mergen

| Ebene | Wer schließt | Bedingung |
|---|---|---|
| **Task** | Agent (Squash-Merge, Branch löschen) | CI grün, Definition of Done (Skill, Abschnitt 7) erfüllt, `Closes #nr` im PR |
| **Story** | Mensch (oder Agent auf Zuruf) | Alle Tasks gemerged, Smoke-Test in CI grün, Story bekommt Label `test` + Kommentar „Bereit zum Test“ mit Akzeptanzkriterien als Checkliste und Link zum APK-Artefakt. Der Mensch testet die Kriterien auf dem Gerät. Fehlt etwas → neuer Task mit „Bezug“; die Story bleibt in `test`. |
| **Epic** | Agent schlägt vor, Mensch bestätigt | Alle Stories geschlossen, Smoke-Test grün, vom Menschen getestet. Abschlusskommentar mit Ergebnis und ggf. Folge-Epics |
| **Initiative** | **Nur der Mensch** | Alle Epics zu und „Fertig, wenn“ erfüllt; Agent schlägt es vor |

**Smoke-Test** = CI-Job, der die App im Debug-Build startet und bis zum Hauptmenü kommt (Integration-Test), plus Build des Release-APK/AAB. Definiert im Epic „Projektgerüst“.

Während eine Story in `test` wartet, darf der Agent die nächste `ready`-Story beginnen (nur eine Story `in-progress`, beliebig viele in `test`).

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
- `test` – alle Tasks gemerged, wartet auf Test durch den Menschen (projektspezifische Ergänzung, siehe „Mergen“)

Regeln:
- Tasks werden erst geschrieben, wenn eine Story von `backlog` nach `ready` wechselt.
- Welche Story als Nächstes umgesetzt wird, entscheidet der Mensch; ohne Vorgabe die
  nächste `ready`-Story laut Reihenfolge im Epic.

## Initiativen und Epics: Konvention

Ein Epic ist ein **endliches Vorhaben**, dauerhafte Themen liegen eine Ebene darüber
(Initiativen) – so wie bei Jira, Azure DevOps, Linear und SAFe.

**Initiativen** (Label `initiative`)
- Langlebiges Oberthema mit Zielbild: Warum, Nutzen, Gehört dazu / nicht dazu, Epics,
  „Fertig, wenn“ (1–3 grobe Aussagen). Kein Status-Label, keine Reihenfolge, kein
  Fortschrittswert (der GitHub-Balken zählt nur direkte Kinder und wird ignoriert).
- Ohne offene Epics **ruht** eine Initiative und bleibt offen (Stand: „Ruht“).
- **Nur der Mensch schließt Initiativen.** Der Agent schlägt es vor, wenn alle Epics zu
  sind und „Fertig, wenn“ erfüllt ist. Beim Schließen: ein Satz zu Ergebnis oder Grund.
- Folgearbeit zu einer geschlossenen Initiative = **neue** Initiative mit eigenem,
  ergebnisbezogenem Titel (kein „v2“) und „Bezug: #alt“.

**Epics** (Label `epic`)
- **Endlich.** Ergebnisbezogener Titel, nie „… II“ oder Nummern. Geschlossen, sobald
  alle Stories geschlossen sind; im Abschlusskommentar ggf. Folge-Epics.
- **Genau eine Initiative als Parent**, gewählt nach dem Hauptnutzen. Passt ein Epic
  auch zu einer zweiten, steht dort „Siehe auch: #nr“. Geschlossene Epics dürfen an
  eine offene Initiative gehängt werden – das ist kein Wiederöffnen.

**Für alle Ebenen**
- **Geschlossen bleibt geschlossen.** Der Agent öffnet **nie** ein geschlossenes Issue
  wieder – weder Initiative, Epic, Story noch Task. Neue Arbeit zu etwas Erledigtem
  wird ein **neues** Issue mit „Bezug: #nr“.
- **Keine Waisen:** jede Story hat genau ein Epic, jedes Epic genau eine Initiative.
- **Neue Idee:** `backlog`-Story in einem offenen Epic, das genau dieses Ziel verfolgt
  → sonst neues Epic in der passenden offenen Initiative → sonst neue Initiative.
  Der Agent legt sofort an (keine Rückfrage, um nicht zu blockieren) und trägt alles,
  was oberhalb einer Story neu ist, in `STAND.md` unter „Offene Entscheidungen“ ein
  („neu angelegt – bitte bestätigen oder umsortieren“).

## Issue-Vorlagen (Jira-Stil)

Jedes Issue sagt, **wofür** es da ist, **welchen Nutzen** es hat und **wann es fertig**
ist. Vorlagen: `.github/ISSUE_TEMPLATE/` (Initiative, Epic, Story, Task) – der Agent
schreibt Issues per API immer nach dieser Gliederung.

- **Story:** Ziel als „Als Nutzer möchte ich …, damit …“, Nutzen, Nicht-Umfang,
  **Akzeptanzkriterien aus Nutzersicht** (beim Test der App prüfbar), Entscheidungen, Tasks.
- **Task:** Zweck (welches Story-Kriterium), Umsetzung, **technische
  Akzeptanzkriterien – jedes wird genau ein Test**, Abhängig von. Definition of Done
  per Verweis, nicht kopiert.
- **Epic:** Ergebnis, Nutzen, Umfang/Nicht-Umfang, Stories (Reihenfolge),
  „Fertig, wenn“ als Verweiszeile auf die Merge-Regeln.
- Kein Gherkin (bei TDD sind die Tests die Given/When/Then-Form); bei Verhalten
  „Wenn …, dann …“.
- **Nachziehen:** Backlog-Stories bekommen die volle Vorlage beim Wechsel nach
  `ready`. Geschlossene Issues werden nie angepasst.
- Sub-Issues per API: `POST /repos/{owner}/{repo}/issues/{parent}/sub_issues` mit `sub_issue_id` (Datenbank-ID, nicht Nummer).

## Stand pflegen (`STAND.md`)

Kurzfassung des Projektstands, die der Mensch als Kontext liest; muss immer zu den
Issues passen.

- Aktualisieren, sobald sich etwas ändert: Story wechselt den Status oder wird
  geschlossen, neue Story, neues Epic oder neue Initiative, Reihenfolge ändert sich,
  Entscheidung getroffen.
- Inhalt: In Arbeit · Zum Test · Als Nächstes · Backlog nach Initiative → Epic (offene Epics mit
  „x von y Stories zu“, ruhende Initiativen unter „Ruht“) · Zuletzt erledigt
  (höchstens 5, neueste oben) · Offene Entscheidungen · Datum „Zuletzt aktualisiert“.
- Kurz halten: Nummer + Titel, keine Task-Details.

## Design-Leitplanken (bindend für jede Story)

Aus `docs/recherche/design-dossier.md` und `docs/spielkonzept.md`:

**Pflicht in jeder Version**
- Kerneinheit 1–3 Minuten, jederzeit unterbrechbar, Autosave.
- Core-Gameplay in unter 60 Sekunden erreichbar, kein Login, Hinweise ≤ 8 Wörter.
- Wahl 1-aus-3 mit Zufall; zwei Loops (Run + dauerhafte Meta).
- Echte, skillbasierte Beinahe-Siege; keine manipulierten Ergebnisse.
- Juice: Tweens, Partikel, Hit-Stop, eskalierende Zahlen, geschichteter Sound.
- Fairer Schwierigkeits-Sägezahn, mit dem Bot-Simulator geprüft.
- Analytics für FTUE-Funnel, D1/D7, Win-Rate je Stufe.

**Verboten (kein Code-Pfad dafür)**
- Leben/Energie-Systeme, Wartezeiten als Monetarisierung.
- Bezahlte Zufallsitems (Lootboxen, Gacha), zweite Premiumwährung.
- Falsche oder zurückgesetzte Countdowns, Confirmshaming, Zeitdruck-Angebote.
- Streak-Verlust ohne Freeze; Push-Nachrichten zwischen 22 und 7 Uhr.
- Pflicht-Werbung mitten im Brett; Interstitials ohne Frequenz-Cap.
- Casino-Optik (Walzen, Chips, Jetons) und Kinder-Zielgruppe.

Wer eine Story schreibt, die dagegen verstößt, legt sie nicht an, sondern trägt sie unter „Offene Entscheidungen“ ein.

## Technik

Siehe `.claude/skills/flutter-dart/SKILL.md` (Stack, Struktur, Befehle, Tests, Definition of Done, Compliance). Kurz: Flutter ≥ 3.44 + Flame 1.38.x, reines Dart-Package `game_core` für alle Regeln, Riverpod 3, Firebase, AdMob, RevenueCat. Keine neuen Dependencies ohne ADR.

## Was der Mensch tut (nicht der Agent)

- Entscheidungen unter „Offene Entscheidungen“ in `STAND.md` treffen.
- Stories auf dem Gerät testen und schließen; Initiativen schließen.
- Accounts und Secrets: Google Play, Apple Developer, Firebase, AdMob, RevenueCat, Signing-Keys (als GitHub-Secrets hinterlegen).
- Community, Store-Texte freigeben, Marketing.
