# Prompt: create agent context pack

Create a focused context pack for a coding or documentation task.

Inputs:

- Task description
- Relevant files from `reviewed/`
- Relevant source snippets from `human/`
- Known terminology rules from `_system/AGENTS.md`

Output:

```text
context-packs/<task-slug>.md
```

The context pack should be short enough to paste into Codex or another coding agent. Include only the files and concepts required for the task.
