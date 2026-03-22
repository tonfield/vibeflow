# Vibeflow

A stateless, interactive workflow system for OpenCode with agile practices built-in.

## Philosophy

**Vibeflow** replaces rigid phasebook-style workflows with a more interactive, general-purpose approach. Each phase is a capable agent that:
- Can handle any task within its domain
- Uses task/ledger tracking aggressively
- Asks questions proactively
- Tests hypotheses before claiming truth
- Creates documentation and artifacts

## Phases

| Phase | Agent Type | Focus |
|-------|-----------|-------|
| `research` | Senior Technical Researcher | Investigation, hypotheses, testing, claims |
| `architect` | Principal Architect | Systems thinking, diagrams, trade-offs |
| `orchestrate` | Technical Program Manager | Sprint planning, task breakdown |
| `implement` | Software Engineer | Working code, tests, verification |
| `learn` | Technical Coach | Patterns, retrospectives, knowledge base |

## Key Features

- **Interactive** - Agents ask questions, don't just assume
- **Task/Ledger tracking** - Everything tracked with todowrite
- **Test-driven** - Implementation includes tests
- **Pattern extraction** - Patterns saved to AGENTS.md
- **General-purpose** - Can handle any task appropriately for the phase

## Installation

### From GitHub (Recommended)

```bash
# Clone the repo
git clone https://github.com/tonfield/vibeflow.git ~/projects/vibeflow

# Run install script
~/projects/vibeflow/install.sh
```

### Manual Install

```bash
# 1. Copy vibeflow folder
cp -r ~/projects/vibeflow ~/.config/opencode/vibeflow

# 2. Copy agents
cp ~/.config/opencode/vibeflow/*.md ~/.config/opencode/agents/

# 3. Copy plugin
cp ~/.config/opencode/vibeflow/plugins/vibeflow.ts ~/.config/opencode/plugins/

# 4. Add plugin to opencode.json
# Add: "plugin": ["vibeflow"] to your opencode.json

# 5. Restart OpenCode
```

## Updating

```bash
cd ~/projects/vibeflow && git pull
~/projects/vibeflow/install.sh
```

## Usage

### Tab Through Phases

Use **Tab** to cycle through vibeflow phases:
- `research` → Deep investigation
- `architect` → Design decisions
- `orchestrate` → Sprint planning
- `implement` → Implementation
- `learn` → Pattern extraction

### Task/Ledger System

Every phase uses aggressive task tracking:

```javascript
todowrite({
  todos: [
    { content: "[TASK] Investigate auth patterns", status: "in_progress", priority: "high" },
    { content: "[CLAIM] Auth middleware validates JWT", status: "completed", priority: "high" },
    { content: "[ASSUME] Using JWT over sessions", status: "pending", priority: "medium" },
    { content: "[RISK] Redis becomes single point of failure", status: "pending", priority: "medium" },
  ]
})
```

### Claim Tags

| Tag | Meaning |
|-----|---------|
| `[TASK]` | Actionable task |
| `[CLAIM]` | Statement requiring verification |
| `[ASSUME]` | Assumption (may be wrong) |
| `[TRACE]` | Data flow to verify |
| `[NEGATION]` | "No other X" claim |
| `[GAP]` | Knowledge gap |
| `[QUESTION]` | Open question |
| `[DECISION]` | Architectural decision |
| `[RISK]` | Risk identified |
| `[PATTERN]` | Reusable pattern discovered |
| `[GOTCHA]` | Pitfall to avoid |
| `[BUG]` | Bug to fix |

### Reviews

Use `@review` for parallel multi-perspective review:

```bash
@review "review the research"
@review "review the architecture"
@review "review the code"
@review "challenge this approach"
```

## Architecture

```
research → architect → orchestrate → implement → learn
    ↓           ↓            ↓            ↓
  @review     @review      @review     @review
```

### Research
- Investigates thoroughly
- Tests hypotheses with scripts
- Searches web for best practices
- Creates evidence-based claims
- Asks questions proactively

### Architect
- Thinks big picture
- Creates diagrams (Mermaid)
- Makes trade-off decisions
- Identifies risks
- Challenges assumptions

### Orchestrate
- Breaks into sprint tasks
- User stories + technical tasks
- Assigns priorities
- Maps dependencies
- Creates sprint boards

### Implement
- Writes working code
- Tests everything
- Verifies each step
- Clean refactoring
- Keeps scope tight

### Learn
- Extracts patterns
- Documents gotchas
- Updates AGENTS.md
- Archives artifacts
- Retrospectives

## Documents

Each phase creates/updates documents:
- `research.md` - Evidence and claims
- `architect.md` - Architecture decisions
- `orchestrate.md` - Sprint plan
- `implement.md` - Implementation notes
- `learn.md` - Patterns and retrospective

Documents are session-based (survive via compaction).

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
- More interactive (questions, hypotheses)
- General-purpose phases (not just code)
- Simpler structure
- Less ceremony

### vs Default OpenCode
- Structured workflow for complex tasks
- Built-in review system
- Task/ledger tracking
- Pattern extraction
