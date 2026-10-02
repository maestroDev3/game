# Entscheidungsvorlage: Planungsstruktur für KI-gestützte Softwareprojekte

**Ebenen:** Initiative → Epic → Story → Task · **Werkzeug:** GitHub Issues mit Sub-Issues · **Stand:** 01.10.2026

## 1. Ausgangslage

Ein Entwickler arbeitet allein, ein KI-Agent (Claude Code) setzt weitgehend autonom im GitHub-Repo um. Die Planung liegt vollständig in GitHub Issues; eine Datei `STAND.md` fasst den Stand für den Menschen zusammen.

Problem:
- Epics wurden als Themen-Ordner benutzt. Der Agent hat ein geschlossenes Epic eigenmächtig wieder geöffnet, um eine neue Idee einzuhängen.
- Es war unklar, ob Epics ein Ende haben oder dauerhafte Themen sind.
- Issues waren unterschiedlich gut beschrieben: mal fehlte der Nutzen, mal die Akzeptanzkriterien.

## 2. Entscheidung

1. **Vier Ebenen:** Initiative → Epic → Story → Task, verknüpft über native Sub-Issues, unterschieden über Labels.
2. **Initiative = langlebiges Oberthema.** Darunter entstehen über die Zeit immer neue Epics. Ohne offene Epics *ruht* sie. Geschlossen wird sie nur vom Menschen.
3. **Epics sind endlich:** ein Vorhaben mit Ergebnis, geschlossen, wenn alle Stories erledigt sind.
4. **Geschlossen bleibt geschlossen** – auf allen Ebenen. Der Agent öffnet nie etwas wieder; neue Arbeit wird ein neues Issue mit „Bezug: #nr“.
5. **Keine Waisen:** jede Story hat genau ein Epic, jedes Epic genau eine Initiative.
6. **Jedes Issue im Jira-Stil:** wofür, welcher Nutzen, wann fertig. Vorlagen je Ebene in `.github/ISSUE_TEMPLATE/`.

## 3. Begründung

- **Branchenkonvention:** Jira, Azure DevOps, Linear, SAFe und Shape Up trennen gleich: Ein Epic ist ein endliches Arbeitspaket, dauerhafte Themen liegen eine Ebene darüber (Jira: Initiative/Theme, Azure DevOps: Area Path, Linear: Initiative). Geschlossene Epics wiederzuverwenden wird ausdrücklich nicht empfohlen.
- **Sicherheit beim autonomen Agenten:** Regeln müssen eindeutig sein. „Passt die Idee gut genug, um ein Epic wieder zu öffnen?“ ist eine Ermessensfrage – genau daran ist der Fehler entstanden. „Nie wieder öffnen“ lässt keinen Spielraum.
- **Ehrlicher Stand:** „geschlossen“ und „zuletzt erledigt“ behalten ihre Bedeutung, Fortschrittsbalken springen nicht zurück.
- **Dauerhaftes Zuhause:** Initiativen geben Themen einen festen Ort, ohne dass Epics dafür ewig offen bleiben.
- **Abnahme in zwei Stufen:** Akzeptanzkriterien aus Nutzersicht in der Story prüft der Mensch beim Test; technische Kriterien im Task prüft die CI.

Geprüft durch Recherche und eine Diskussion zweier unabhängiger Agenten über zwei Runden.

## 4. Verworfene Alternativen

| Alternative | Warum verworfen |
|---|---|
| Epics als dauerhafte Cluster, die bei neuer Story wieder aufgehen | Verlangt eine Ermessensentscheidung vom Agenten; „geschlossen“ wird bedeutungslos, Fortschritt springt zurück, Erledigtes taucht wieder als offen auf. |
| Themen-Labels (`area:…`) an jeder Story | Doppelte Buchführung (Label und Hierarchie), die auseinanderlaufen kann; kein Ort für Ziel und Abschluss. |
| Stories ohne Epic im Backlog | Keine Reihenfolge, kein Fortschritt, gehen leicht unter. |
| Nachfolger mit „v2“ oder „… II“ | Sagt nichts über das Ziel. Stattdessen neuer, ergebnisbezogener Titel mit „Bezug: #nr“. |
| GitHub Issue Forms (YAML) | Greifen nur im Browser; legt der Agent Issues per API an, werden sie ignoriert. Markdown-Vorlagen gelten für beide. |
| Gherkin (Given/When/Then) | Bei TDD sind die Tests selbst schon diese Form; im Issue wäre es doppelt. |
| Neue Epics nur nach Rückfrage | Blockiert den autonomen Agenten. Stattdessen sofort anlegen und dem Menschen zur Bestätigung melden. |

## 5. Regeln

Siehe `CLAUDE-regeln.md` (direkt in die Agent-Anweisungen übernehmbar).

## 6. Vorlagen

| Ebene | Pflichtabschnitte |
|---|---|
| Initiative | Warum · Nutzen · Gehört dazu · Gehört nicht dazu · Epics · Fertig, wenn (1–3 Aussagen) · optional Bezug |
| Epic | Ergebnis („Was kann ich danach?“) · Nutzen · Umfang · Nicht-Umfang · Stories (Reihenfolge) · Fertig, wenn (Verweiszeile auf Merge-Regeln) · Initiative: #nr |
| Story | Ziel („Als Nutzer möchte ich …, damit …“) · Nutzen · Beschreibung · Nicht-Umfang · Akzeptanzkriterien (Nutzersicht, Checkboxen) · Entscheidungen · Tasks · Epic: #nr |
| Task | Zweck (welches Story-Kriterium) · Umsetzung · Akzeptanzkriterien (je Kriterium ein Test) · Abhängig von · Definition of Done als Verweis |

Dateien: `.github/ISSUE_TEMPLATE/1-initiative.md`, `2-epic.md`, `3-story.md`, `4-task.md`.

## 7. Grenzfälle

| Fall | Regel |
|---|---|
| Epic passt zu zwei Initiativen | Ein Parent nach Hauptnutzen, in der anderen „Siehe auch: #nr“; bei 50/50 Epic teilen. |
| Initiative ohne offene Epics | Ruht, bleibt offen, steht unter „Ruht“. |
| Initiative zu, neue Idee passt thematisch | Neue Initiative mit eigenem Titel und „Bezug: #alt“. |
| Wer schließt Initiativen? | Nur der Mensch – das Ende eines Themas ist eine Produktentscheidung. |
| Fortschrittsbalken bei Initiativen | Ignorieren (zählt nur direkte Kinder, sinkt mit jedem neuen Epic); stattdessen „x von y Epics zu“. |
| Bestehende geschlossene Epics zuordnen | Als Sub-Issue an die offene Initiative hängen – geht und öffnet das Epic nicht (getestet). |

## 8. Umsetzung in einem neuen Projekt

Siehe Checkliste in `README.md`.

## 9. Quellen

- Atlassian – Epics: https://www.atlassian.com/agile/project-management/epics
- Atlassian – Epics, Stories, Themes: https://www.atlassian.com/agile/project-management/epics-stories-themes
- Atlassian Community – Issues zu geschlossenen Epics: https://community.atlassian.com/t5/Jira-Software-questions/Best-practice-for-adding-issues-to-closed-Epics/qaq-p/2188432
- Microsoft – Wiederöffnen geschlossener Work Items verhindern: https://devblogs.microsoft.com/premier-developer/prevent-reopening-work-item-once-closed-azure-devops-with-video/
- Linear – Initiatives: https://linear.app/docs/initiatives
- GitHub Docs – Sub-Issues: https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/adding-sub-issues
- GitHub Docs – Issue Types: https://docs.github.com/en/issues/tracking-your-work-with-issues/configuring-issues/managing-issue-types-in-an-organization
- GitHub Docs – Issue Forms: https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/syntax-for-issue-forms
