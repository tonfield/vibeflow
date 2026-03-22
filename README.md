# Vibeflow

A self-sufficient, interactive workflow system for OpenCode.

## Philosophy

**Vibeflow** modes are self-sufficient - each can run standalone or with context. User controls the flow, not a rigid sequence.

Each mode:
- Works standalone
- Asks questions proactively
- Tracks with [TASK], [CLAIM], [ASSUMPTION]

## Modes

| Mode | Role | Mindset |
|------|------|---------|
| `research` | Senior Technical Researcher | "What's there? What evidence exists?" |
| `architect` | Principal Architect | "How should it work? What's the best design?" |
| `orchestrate` | Technical Program Manager | "What do we do and in what order?" |
| `implement` | Software Engineer | "Let me build it and verify it works." |

## Installation

```bash
git clone https://github.com/tonfield/vibeflow.git ~/projects/vibeflow
./vibeflow/install.sh
```

Or manually:
```bash
cp ~/projects/vibeflow/agents/*.md ~/.config/opencode/agents/
cp ~/projects/vibeflow/plugins/vibeflow.ts ~/.config/opencode/plugins/
# Add to opencode.json: "plugin": ["vibeflow"]
```

## Usage

### Tab Through Modes

Use **Tab** to switch between modes. Each mode works on the same project document.

### Project Documents

Each project lives in `./vibeflow/<project-name>.md`:

```
./vibeflow/
├── auth-api.md      # Auth system
├── payments.md      # Payment integration
└── onboarding.md   # User onboarding
```

The document is the **single source of truth** - everything lives there.

### Typical Flow

```
1. User: "I'm working on auth API"
   
2. Tab → research    # Investigate existing auth
   - Agent creates ./vibeflow/auth-api.md if missing
   - Adds Research section with findings

3. Tab → architect   # Design the solution
   - Reads Research section
   - Adds Architecture section with design decisions

4. Tab → orchestrate # Plan the work
   - Reads Research + Architecture
   - Adds Plan section with steps

5. Tab → implement   # Build it
   - Reads Plan + Architecture
   - Adds Implementation section with progress
```

### Tags (Session Only)

Tags track work in-session, not in the document:

```javascript
todowrite({
  todos: [
    { content: "[TASK] Implement JWT middleware", status: "pending", priority: "high" },
    { content: "[CLAIM] Auth validates JWT tokens", status: "pending", priority: "high" },
    { content: "[ASSUMPTION] Using RS256 signing", status: "pending", priority: "medium" },
  ]
})
```

| Tag | Meaning | Statuses |
|-----|---------|----------|
| [TASK] | Work to complete | pending → in_progress → completed |
| [CLAIM] | Statement to verify | pending → completed (verified) / cancelled (rejected) |
| [ASSUMPTION] | Accepted risk | pending → completed (confirmed) / cancelled (invalidated) |

## Commands

| Command | What it does |
|---------|--------------|
| `/learn` | Extract patterns from current project to AGENTS.md |
| `/status` | Show current session state |

## Reviews

Use `@review` for multi-perspective review:

```
@review "review the research"
@review "review the architecture"
@review "challenge this approach"
```

| Reviewer | Focus |
|----------|-------|
| `@reviewer-logic` | Logical consistency, completeness |
| `@reviewer-risk` | Risk, assumptions, failure modes |
| `@reviewer-codebase` | Verify claims against actual code |
| `@challenge` | Adversarial review |

## Document Structure

Each project document evolves naturally:

```markdown
# Auth API

## Research
### Date: 2026-03-22
- Investigated existing auth middleware
- Found: JWT validation at middleware/auth.ts:45-67
- [CLAIM] All routes protected by single middleware
- [TRACE] login → auth → session → response

## Architecture
### Date: 2026-03-22
### Context
<Problem summary from research>

### Design Decisions
#### Decision: Token format
- **Choice:** JWT with RS256
- **Alternatives:** HMAC (rejected because...)

### Data Flow
```
Request → JWT Validation → Session → Database → Response
```

## Plan
### Date: 2026-03-22
### Steps
#### Step 1: Add JWT validation
- **Risk:** LOW
- **Depends on:** (none)
- **Verification:** Tests pass

## Implementation
### Date: 2026-03-22
#### Step 1: Add JWT validation
- **Status:** DONE
- **Verification:** npm test passes
- **Changes:**
  - Added middleware/auth.ts
  - Tests added: tests/auth.test.ts
```

## Customization

### Change Reviewer Model

Edit the `model` field in reviewer agents:
```markdown
---
model: your-provider/your-model
---
```