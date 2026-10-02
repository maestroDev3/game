# Rune Rush (Arbeitstitel)

Match-3-Roguelite für Android und iOS – Candy-Crush-Vertrautheit × Balatro-Tiefe. Free-to-Play, fair monetarisiert, gebaut mit Flutter + Flame von einem Menschen und einem KI-Agenten (Claude Code).

> Match-3, bei dem du die Regeln brichst. Jedes Match zählt Basis × Multiplikator. Runen schreiben das Spiel um. Schaffst du acht Bretter, bevor dir die Züge ausgehen?

## Orientierung

| Datei | Inhalt |
|---|---|
| [`STAND.md`](STAND.md) | Aktueller Projektstand, offene Entscheidungen |
| [`CLAUDE.md`](CLAUDE.md) | Regeln für den Agenten: Arbeitsablauf, Planungsstruktur, Design-Leitplanken |
| [`docs/spielkonzept.md`](docs/spielkonzept.md) | Was wir bauen: Core Loop, Scoring, Runen, Meta, Monetarisierung, Versionen |
| [`docs/entscheidungen/`](docs/entscheidungen/) | Entscheidungen mit Begründung (Planungsstruktur, Engine, Konzept) |
| [`docs/recherche/`](docs/recherche/) | Marktanalyse, Engine-Vergleich, Design-Dossier mit Quellen |
| [`.claude/skills/flutter-dart/SKILL.md`](.claude/skills/flutter-dart/SKILL.md) | Technische Regeln, Projektstruktur, Definition of Done |

Planung: GitHub Issues (Initiative → Epic → Story → Task, siehe Labels).

## Entwicklung

Folgt mit Story #14 (Monorepo + CI). Vorab: Flutter stable ≥ 3.44, `dart pub get` im Root, `cd app && flutter run`.
