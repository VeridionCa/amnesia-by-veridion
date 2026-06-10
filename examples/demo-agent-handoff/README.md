# Example: Demo Agent Handoff

A **fully fictional** demonstration of a lossless handoff between two agents
mid-task. All names, files, and details are invented.

## Scenario

Claude Code is executing `TASK-0002` (restructuring the fictional
`your-project` docs) and hits its session limit halfway through. It writes a
handoff file; Codex picks the task up in a fresh session with zero
conversation history and finishes it.

## What this example shows

1. A complete, filled-in handoff: [`HANDOFF-EXAMPLE.md`](HANDOFF-EXAMPLE.md) —
   exact progress per done-criterion, the single concrete next step, warnings
   about a decision already made, and open questions for the human.
2. The receiving agent's first moves: read handoff → read execution log →
   **verify the claimed state against the actual files** → continue from the
   first incomplete item.

## The rule that makes this work

> Write the handoff as if the next agent knows nothing — because it doesn't.

If continuation requires remembering the conversation, the handoff has
failed. Everything needed must be in the handoff, the log, and the contract.

## Try it

Use `templates/HANDOFF.md` the next time a session ends mid-task, then start
the other agent with:

```bash
scripts/launch/launch-codex-feature.sh TASK-XXXX
```
