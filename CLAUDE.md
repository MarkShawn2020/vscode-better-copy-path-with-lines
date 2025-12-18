# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

VSCode extension that copies file paths (absolute/relative) **with line numbers** and range information. Focused on the core value of adding line number context to file paths - use VSCode native "Copy Path" for paths without line numbers. Supports multiple line selection, custom separators, and i18n (English/Chinese).

## Development Commands

### Build & Compile
- `pnpm compile` - Compile TypeScript to JavaScript (output: `out/`)
- `pnpm watch` - Watch mode for development
- `pnpm clean` - Remove compiled output

### Testing & Linting
- `pnpm lint` - Run ESLint on TypeScript files
- `pnpm test` - Run tests (requires compile + lint)

### Publishing
- `pnpm package` - Create .vsix package
- `pnpm publish:all` - Publish to VS Code Marketplace + Open VSX
- Uses semantic-release via GitHub Actions (push `feat:` or `fix:` commits)

### Development Workflow
- Use F5 in VSCode to launch Extension Development Host
- The preLaunchTask automatically compiles before launching

## Architecture

### Core Pattern: Decorator + Strategy + Command

**Entry Point** (`src/extension.ts`):
- Registers 2 VSCode commands that call `DoCopy()` with different `CopyCommandType` enums
- Minimal activation logic, delegates to facade

**Facade Layer** (`src/facade.ts`):
- `DoCopy()`: Main orchestrator - gets content, copies to clipboard, shows message
- `ConcreteCopyCommand`: Command pattern implementation
  - Uses `IUriResolver` for path resolution (absolute/relative)
  - Uses `ILineInfoMaker` for line number formatting (if needed)
- `CommandContainer`: Map of command types to pre-instantiated command objects

**Resolver Layer** (`src/resolver_decorator.ts`):
- **Decorator Pattern**: `UriResolver` → `RelativeUriResolver` / `AbsoluteUriResolver`
  - Base: Gets raw file paths via VSCode API
  - Decorators: Transform paths with workspace-relative logic or custom separators
- **Multi-file Support**: `GetPaths()` uses VSCode's `copyFilePath` command internally to handle multiple selections
- `LineInfoMaker`: Converts editor selections to line number strings (e.g., `5`, `10~15, 20~25`)

**Strategy Layer** (`src/symbol_strategy.ts`):
- Three configurable strategies via `ISymbolStrategy`:
  1. **Path separator**: `/` vs `\` vs system default
  2. **Range connector**: `~` (10~15) vs `-` (10-15)
  3. **Selection separator**: `,` vs `;` vs space
- `ConfigurableSymbolStrategyFactory`: Reads from workspace settings
- `DefaultSymbolStrategyFactory`: Fallback defaults from `src/const.ts`

### Configuration System

Settings namespace: `copyPathWithLineNumber.*`
- `path.separator`: "system" | "slash" | "backslash"
- `range.connector`: "tilde" | "dash"
- `selection.separator`: "comma" | "space" | "semicolon"
- `show.message`: boolean (show clipboard confirmation)

## Key Implementation Details

### Multi-Selection Handling
When copying multiple files/lines:
- Files: Joined with newlines (`\n`)
- Line ranges: Formatted per selection, joined with configured separator + space

### Error Handling
- `DoCopy()` catches errors from `GetCopyContent()` and shows error message
- Falls back to active editor if URI is undefined

### Internationalization
- UI strings use `%tokens%` in `package.json`
- Resolved via `package.nls.json` (English) / `package.nls.zh-cn.json` (Chinese)
- VSCode automatically loads based on display language

## Extension Points

### Commands (registered in package.json)
- `markshawn2020.copy.relative.path.line` - Copy relative path with line number (format: `path:line`)
- `markshawn2020.copy.absolute.path.line` - Copy absolute path with line number (format: `path:line`)

### Context Menus
- **Editor context** (code editor right-click) - shows 2 commands directly (no submenu)
- **Line number gutter context** (line number area right-click) - shows 2 commands directly (no submenu)

**Design Philosophy** (v0.1.1+):
- Removed non-line commands (use VSCode native "Copy Path" instead)
- Removed submenus for faster access (2 clicks vs 3)
- Clear focus on core value: adding line number context to file paths

## Common Patterns

When extending functionality:
1. Add new strategy if introducing configurable symbols
2. Add new decorator if modifying path transformation logic
3. Add new command type if creating new copy variants
4. Update i18n files for any UI-facing strings
