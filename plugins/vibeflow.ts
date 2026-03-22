import type { Plugin } from "@opencode-ai/plugin"

export const VibeflowPlugin: Plugin = async (ctx) => {
  return {
    "experimental.session.compacting": async (input, output) => {
      output.context.push(`
## Vibeflow State (PRESERVE)

This session uses the Vibeflow workflow system:

### Phases
- research → architect → orchestrate → implement → learn

### Current Phase
(Track which phase you're in - this persists across compaction)

### Phase Documents
The following documents may exist in this session:
- research.md - Research findings
- architect.md - Design decisions
- orchestrate.md - Implementation plan
- implement.md - Implementation notes
- learn.md - Learnings and archive

### Review System
Use @review to run reviews:
- @review "review the research" - document review
- @review "review the code" - code review  
- @review "challenge this approach" - adversarial review

### Important
- Phase documents are in the session context - they survive compaction
- Tab switches between phase agents (research, architect, orchestrate, implement, learn)
- Use @review when ready to review the current artifact
`)
    },

    "session.created": async ({ session }) => {
      ctx.client.app.log({
        body: {
          service: "vibeflow",
          level: "info",
          message: "Vibeflow loaded - Use Tab to switch phases, @review to review",
        },
      })
    },
  }
}
