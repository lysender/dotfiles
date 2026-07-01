---
name: banned-commands
description: Repository command safety policy for coding agents. Use for all agent work in this repository to avoid mutating Git state, running builds, or starting serve/dev/run processes unless the user gives explicit command-specific permission.
---

# Banned Commands

Follow this policy for all coding-agent work in this repository. These instructions are written for any agent or assistant, including Codex, Claude, OpenCode, and other tools that can read Markdown guidance.

## Core Rule

Do not run commands that mutate Git state, run builds, or start serve/dev/run processes unless the user gives explicit permission for the exact command.

If a task appears to require a banned command, stop and ask the user before running it. General task wording such as "finish this", "verify it", "make a PR", or "test the app" is not permission to run a banned command.

## Banned Git Commands

Do not run Git commands that change repository state, branch state, history, remotes, the index, or working tree files.

Forbidden examples include:

- `git add`
- `git branch` when creating, deleting, renaming, or changing branches
- `git checkout`
- `git clean`
- `git commit`
- `git fetch`
- `git merge`
- `git pull`
- `git push`
- `git rebase`
- `git reset`
- `git restore`
- `git stash`
- `git switch`

Read-only Git inspection is allowed, including:

- `git status`
- `git diff`
- `git log`
- `git show`
- `git blame`

## Banned Build Commands

Do not run build commands for the app or its dependencies.

Forbidden examples include:

- `npm run build`
- `yarn build`
- `pnpm build`
- `bun run build`
- `next build`
- `composer build`
- `composer run build`
- `composer run-script build`
- PHP framework build scripts launched through `php` or `composer`
- `cargo build`
- `cargo check` when used as part of a build pipeline
- `cargo install`
- `cargo package`
- `docker build`
- `docker compose build`
- any command that creates production artifacts, compiled packages, bundles, images, or release outputs

## Banned Serve, Dev, Watch, and Run Commands

Do not start local app servers, preview servers, development servers, watchers, or long-running run processes.

Forbidden examples include:

- `npm run dev`
- `npm run start`
- `npm run serve`
- `yarn dev`
- `yarn start`
- `yarn serve`
- `pnpm dev`
- `pnpm start`
- `pnpm serve`
- `bun run dev`
- `bun run start`
- `next dev`
- `next start`
- `composer serve`
- `composer run serve`
- `composer run-script serve`
- `php -S`
- Laravel, Symfony, or other PHP framework serve commands
- `cargo run`
- `cargo watch`
- `cargo shuttle run`
- any `cargo` command that starts, serves, watches, or runs a local application process

## Permission Standard

Only run a banned command when the user explicitly approves that specific command in the current task context. Prefer asking with the exact command string so the approval is clear.

When permission is not granted, explain what command was skipped and offer safe alternatives such as static inspection, reading configuration, or running allowed read-only commands.
