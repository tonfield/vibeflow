# Vibeflow

A self-sufficient, interactive workflow system for OpenCode with agile practices built-in.

## Philosophy

**Vibeflow** modes are self-sufficient - each can run standalone or with context from other modes. User controls the flow, not a rigid sequence.

Each mode:
- Works standalone (no required sequence)
- Uses context from other modes if it exists
- Asks questions proactively
- Tracks everything with [TASK], [CLAIM], [ASSUMPTION]

## Modes

| Mode | Role | Focus |
|------|------|-------|
| `research` | Senior Technical Researcher | Investigation, hypothesis testing, evidence |
| `architect` | Principal Architect | System design, diagrams, trade-offs |
| `orchestrate` | Technical Program Manager | Sprint planning, task breakdown |
| `implement` | Software Engineer | Working code, tests, verification |
| `learn` | Technical Coach | Patterns, retrospectives, knowledge base |

## Key Features

- **Self-sufficient** - Any mode can run standalone
- **User controls flow** - Jump between modes as needed
- **Context-aware** - Uses existing documents if available
- **3 tags everywhere** - [TASK], [CLAIM], [ASSUMPTION]

## Installation

### From GitHub (Recommended)

```bash
git clone https://github.com/tonfield/vibeflow.git ~/projects/vibeflow
~/projects/vibeflow/install.sh
```

### Manual Install

```bash
# Copy agents
cp ~/projects/vibeflow/*.md ~/.config/opencode/agents/

# Copy plugin
cp ~/projects/vibeflow/plugins/vibeflow.ts ~/.config/opencode/plugins/

# Add to opencode.json: "plugin": ["vibeflow"]

# Restart OpenCode
```

## Usage

### Tab Through Modes

Use **Tab** to switch between modes:
- `research` → Investigation
- `architect` → Design
- `orchestrate` → Planning
- `implement` → Implementation
- `learn` → Learning

### User Controls Flow

```
@research "Investigate auth options"
@architect "Design auth system"  
@orchestrate "Plan the build"
@implement "Build it"
@learn "Extract patterns"
```

Or jump around:
```
@architect "Quick design question"
@implement "Just build this one feature"
@learn "What did we learn?"
```

## The 3 Tags

Every mode uses the same 3 tags:

```javascript
todowrite({
  todos: [
    // WORK - tasks to complete
    { content: "[TASK] Implement JWT middleware", status: "pending", priority: "high" },
    
    // VERIFY - claims to verify
    { content: "[CLAIM] Auth validates JWT tokens", status: "pending", priority: "high" },
    
    // TOLERATED - accepted risks
    { content: "[ASSUMPTION] Using RS256 signing", status: "pending", priority: "medium" },
  ]
})
```

### Status Meanings

| Tag | pending | in_progress | completed | cancelled |
|-----|---------|--------------|----------|-----------|
| [TASK] | To do | Doing | Done | Won't do |
| [CLAIM] | Unverified | Verifying | **Verified** | Rejected |
| [ASSUMPTION] | Unconfirmed | Confirming | **Confirmed** | Invalidated |

### Same Tags, Different Meanings

| Mode | [TASK] means | [CLAIM] means | [ASSUMPTION] means |
|------|--------------|----------------|---------------------|
| research | Investigate | Verify exists/work | Accept starting point |
| architect | Design component | Design satisfies | Accept design risk |
| orchestrate | Build task | Implementation satisfies | Accept sprint risk |
| implement | Write code | Code works | Confirm library behavior |
| learn | Extract pattern | Document verified | Document learned |

## Mode Context

Each mode checks for existing documents:

| Mode | Checks For |
|------|-----------|
| research | Other modes (uses if available) |
| architect | research.md |
| orchestrate | architect.md |
| implement | orchestrate.md, architect.md |
| learn | All phases |

If documents exist, mode uses them. If not, works standalone.

## Reviews

Use `@review` for parallel multi-perspective review:

```bash
@review "review the research"
@review "review the architecture"
@review "review the code"
@review "challenge this approach"
```

### Reviewers

| Reviewer | Focus |
|----------|-------|
| `@reviewer-logic` | Logical consistency, completeness |
| `@reviewer-risk` | Risk, assumptions, failure modes |
| `@reviewer-codebase` | Verify claims against actual code |
| `@challenge` | Adversarial review |

## Documents

Each mode creates/updates its document:
- `research.md` - Investigation findings
- `architect.md` - Design decisions
- `orchestrate.md` - Sprint plan
- `implement.md` - Implementation notes
- `learn.md` - Patterns and retrospective

Documents are session-based (survive via compaction).

## Example Flow

```
User: "@research Find auth patterns in the codebase"

research mode:
- Looks for existing documents (none found)
- Creates [TASK], [CLAIM], [ASSUMPTION]
- Investigates thoroughly
- Updates todowrite
- Creates research.md

User: "@architect Design auth system"

architect mode:
- Finds research.md (uses it)
- Creates [TASK], [CLAIM], [ASSUMPTION] for design
- Designs with research context
- Updates todowrite
- Creates architect.md

... and so on
```

## Customization

### Change Reviewer Model

Edit the `model` field in reviewer agents:
```markdown
---
model: your-provider/your-model
---
```

### Add Custom Reviewers

Create new reviewers in `agents/` and update `review.md`.

## Why Vibeflow?

### vs Phasebook
- Self-sufficient modes (not rigid sequence)
- User controls flow
- Simpler 3-tag system
- Less ceremony

### vs Default OpenCode
- Structured approach for complex tasks
- Built-in review system
- Task/claim tracking
- Pattern extraction
