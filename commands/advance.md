---
name: advance
description: Advance to next phase
agent: build
---

Advance to the next phase.

## Phase Order

research → architect → orchestrate → implement → learn

## Process

1. Check if current phase document exists
2. Check if review has been run (if applicable)
3. If BLOCKING issues exist, warn user
4. Move to next phase
5. Inform user of new phase

## If at Learn Phase

Completing learn means the task is done. Offer to:
1. Archive the documents
2. Extract patterns to AGENTS.md
3. Start a new task

## Notes

- User controls phase transitions - this just helps execute
- Review should be run before advancing (use @review)
- Learn phase always follows implement
