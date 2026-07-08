---
name: review-codes
description: Use when asked to review specific files, code blocks, methods, functions, classes, modules, diffs, or repository areas for potential bugs, inconsistencies, logic errors, incorrect indexes or property names, performance issues, incorrect parameters, and return type or shape mismatches across any programming language.
---

# Review Codes

## Overview

Perform a focused, language-agnostic code review of a user-specified target. Prioritize real correctness risks over style preferences, and adapt the review to the language, framework, and local conventions already present in the code.

## Core Workflow

1. Identify the review target from the user prompt.
2. Inspect the target and enough surrounding context to understand inputs, outputs, callers, callees, data shapes, side effects, and expected behavior.
3. Infer the language, framework, runtime, typing model, and project conventions from the codebase before judging the implementation.
4. Review for correctness first, then consistency, performance, maintainability, and test coverage.
5. Report findings with precise locations, severity, rationale, and suggested fixes.
6. If no issues are found, say so clearly and mention any residual uncertainty or test gaps.

## Target Resolution

Accept targets in any of these forms:

- File or directory paths
- Function, method, class, interface, component, hook, module, migration, query, or test names
- Line ranges
- Git diffs or pasted code snippets
- Natural-language descriptions of code areas

If the target is ambiguous, search the repository for likely matches using file names, symbol names, nearby domain terms, and references from callers or tests. Ask a concise clarifying question only when multiple plausible targets remain and reviewing the wrong code would be risky.

## Review Focus

Look specifically for:

- Bugs and runtime errors
- Logic errors and unreachable or inverted branches
- Off-by-one errors and incorrect index use
- Incorrect property, field, key, column, selector, or path names
- Incorrect parameter order, missing parameters, wrong defaults, or unsafe argument handling
- Incorrect return values, return types, response shapes, object shapes, tuple shapes, collection shapes, or nullability assumptions
- Inconsistencies between implementation, callers, tests, schemas, comments, naming, and external contracts
- State mutation, aliasing, lifecycle, concurrency, transaction, async, retry, or caching mistakes
- Error handling gaps and swallowed failures
- Boundary cases such as empty inputs, null values, zero values, duplicates, large values, time zones, encoding, precision, overflow, and missing optional data
- Performance problems caused by unnecessary repeated work, poor algorithmic complexity, excessive I/O, N+1 calls, blocking work, memory growth, or avoidable serialization
- Security-sensitive mistakes when visible in the target, such as injection, unsafe deserialization, secret exposure, authorization bypass, insecure direct object references, or path traversal
- Missing, misleading, or brittle tests for changed or risky behavior

## Language-Agnostic Adaptation

Do not assume a specific language. Infer behavior from:

- File extensions and syntax
- Package manifests, build files, framework conventions, imports, and dependency declarations
- Type annotations, schemas, interfaces, migrations, serializers, DTOs, validators, and tests
- Call sites, return handling, error handling, and serialized data
- Existing project style and naming conventions

Use language-specific reasoning only after identifying the language or framework from the codebase. Avoid forcing concepts from one ecosystem onto another.

## Context Gathering

Prefer targeted inspection over broad reading:

- Read the requested target first.
- Inspect directly related callers, callees, tests, type definitions, schemas, configuration, and generated contracts when needed.
- For symbol searches, prefer fast repository search tools such as `rg`.
- Do not modify files unless the user explicitly asks for fixes.

## Output Format

Lead with findings. Order by severity. For each finding include:

- Severity: `Critical`, `High`, `Medium`, or `Low`
- Location: file and line or narrow code reference
- Issue: concise description
- Why it matters: concrete failure mode
- Suggested fix: specific remediation

Use this structure:

```markdown
**Findings**

1. `High` - `path/to/file.ext:42`
   The function passes `customerId` where `accountId` is expected.
   This can fetch or mutate the wrong account when both identifiers are present.
   Suggested fix: pass `accountId` from the validated request object, and add a regression test covering mismatched IDs.

**Open Questions**

- Mention only questions that affect correctness.

**Summary**

Briefly state the reviewed target and overall risk level.
```

If there are no findings:

```markdown
**Findings**

No correctness issues found in the reviewed target.

**Residual Risk**

Mention unverified behavior, missing tests, external contracts, generated code, or runtime behavior that could not be confirmed from static inspection.
```

## Review Discipline

- Prioritize real, actionable defects over style preferences.
- Do not invent issues without evidence from code or likely runtime behavior.
- Do not recommend broad rewrites unless the current design directly causes a defect or serious risk.
- Distinguish confirmed bugs from suspicious patterns.
- When uncertain, say what evidence would confirm the issue.
- Keep feedback scoped to the requested target unless nearby code is necessary to explain the problem.
