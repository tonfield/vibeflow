# Vibeflow

A self-sufficient, interactive workflow system for OpenCode.

## Philosophy

**Vibeflow** modes are self-sufficient - each can run standalone or with context from other modes. User controls the flow, not a rigid sequence.

Each mode:
- Works standalone
- Uses context from other modes if it exists
- Asks questions proactively
- Tracks with [TASK], [CLAIM], [ASSUMPTION]

## Modes

| Mode | Role | Focus |
|------|------|-------|
| `research` | Senior Technical Researcher | Investigation, hypothesis testing, evidence |
| `architect` | Principal Architect | System design, diagrams, trade-offs |
| `orchestrate` | Technical Program Manager | Sprint planning, task breakdown |
| `implement` | Software Engineer | Working code, tests, verification |

## Installation

```bash
git clone https://github.com/tonfield/vibeflow.git ~/projects/vibeflow
cp ~/projects/vibeflow/*.md ~/.config/opencode/agents/
cp ~/projects/vibeflow/plugins/vibeflow.ts ~/.config/opencode/plugins/
# Add to opencode.json: "plugin": ["vibeflow"]
```

## Usage

### Tab Through Modes

Use **Tab** to switch between modes:
- `research` → Investigation
- `architect` → Design
- `orchestrate` → Planning
- `implement` → Implementation

### User Controls Flow

```
@research "Investigate auth options"
@architect "Design auth system"
@orchestrate "Plan the build"
@implement "Build it"
/learn  # Extract patterns at end
```

## Tags

Every mode tracks work with tags:

```javascript
todowrite({
  todos: [
    { content: "[TASK] Implement JWT middleware", status: "pending", priority: "high" },
    { content: "[CLAIM] Auth validates JWT tokens", status: "pending", priority: "high" },
    { content: "[ASSUMPTION] Using RS256 signing", status: "pending", priority: "medium" },
  ]
})
```

### Tag Meanings

| Tag | Meaning | Statuses |
|-----|---------|----------|
| [TASK] | Work to complete | pending → in_progress → completed |
| [CLAIM] | Statement to verify | pending → completed (verified) / cancelled (rejected) |
| [ASSUMPTION] | Accepted risk | pending → completed (confirmed) / cancelled (invalidated) |

## Mode Context

Each mode checks for existing documents:

| Mode | Checks For |
|------|-----------|
| research | Other modes if available |
| architect | research.md |
| orchestrate | architect.md |
| implement | orchestrate.md, architect.md |

## Commands

| Command | What it does |
|---------|--------------|
| `/learn` | Extract patterns from current work |
| `/review` | Run parallel review |

### Reviews

Use `@review` for multi-perspective review:

```
@review "review the research"
@review "review the architecture"
@review "review the code"
@review "challenge this approach"
```

#### Reviewers

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

Documents are session-based (survive via compaction).

## Customization

### Change Reviewer Model

Edit the `model` field in reviewer agents:
```markdown
---
model: your-provider/your-model
---
```
