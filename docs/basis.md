# Basis: Was aus Rune Rush übernommen wurde

Gemeinsamer Code und gemeinsame Regeln werden zunächst **kopiert**, nicht geteilt (Beschluss 0005 in `maestroDev3/game`). Jede Übernahme steht hier mit Quelle und Commit-Hash, damit ein späteres `foundation`-Repo weiß, was zusammengehört.

| Übernommen | Quelle in `maestroDev3/game` | Commit | Angepasst |
|---|---|---|---|
| `CLAUDE.md` (Struktur, Arbeitsablauf, Mergen, Vorlagen, Stand pflegen) | `CLAUDE.md` | `2b9a4f1` | Leitplanken, Portfolio-Regeln, Smoke-Test-Definition (headless) |
| `.github/ISSUE_TEMPLATE/*` | gleich | `2b9a4f1` | unverändert |
| `.gitignore` | gleich | `2b9a4f1` | unverändert |
| `.claude/skills/flutter-dart/SKILL.md` | gleich | `2b9a4f1` | Projektstruktur (`game_core`-Module), Web-Build, Ganzzahl-Regel; kein Ads-SDK |
| Labels | `gh label clone maestroDev3/game` | – | plus `test` |
| Entscheidungen 0001, 0002, 0004, 0005 | `docs/entscheidungen/` | `2b9a4f1` | per Verweis (siehe `docs/entscheidungen/0001-grundlagen-verweise.md`) |

**Noch nicht übernommen (kommt mit Stufe B1/B2, dann hier eintragen):** `SeededRandom` (muss web-sicher sein: nur 32-Bit-Ganzzahl-Arithmetik), Save/Migration, Service-Interfaces + Fakes (Analytics, RemoteConfig, Save, IAP – **kein** AdService), Lokalisierung (ARB EN/DE), CI-Workflows, Compliance-Checkliste.

Wenn eine übernommene Datei in Rune Rush geändert wird, prüft der Agent bei nächster Gelegenheit, ob die Änderung hierher gehört, und aktualisiert den Commit-Hash.
