#!/usr/bin/env bash
set -Eeuo pipefail

repo_url="https://github.com/Apicurio/apicurio-registry.git"
branch="main"
dest="human/apicurio-registry"
sources_dir="sources"
dry_run="false"
local_source=""

log() {
  printf 'sync-human: %s\n' "$*" >&2
}

die() {
  printf 'sync-human: ERROR: %s\n' "$*" >&2
  exit 1
}

usage() {
  cat <<'DOC'
Usage:
  sync-human-apicurio-registry.sh [options]

Fetch Apicurio Registry and populate human/apicurio-registry/ with a clean
snapshot. By default, the script performs a shallow clone of the main branch.
For tests or offline use, pass --local-source DIR.

Options:
  --repo URL          Git repository URL
  --branch NAME      Branch to fetch, default: main
  --dest DIR         Destination directory, default: human/apicurio-registry
  --sources-dir DIR  Provenance directory, default: sources
  --local-source DIR Copy from a local directory instead of cloning
  --dry-run          Show what would happen without modifying files
  -h, --help         Show help

Stdout:
  Prints the resolved source commit or 'local-fixture' for non-git fixtures.

Stderr:
  Progress and diagnostic messages.
DOC
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --repo)
      repo_url="${2:-}"
      shift 2
      ;;
    --branch)
      branch="${2:-}"
      shift 2
      ;;
    --dest)
      dest="${2:-}"
      shift 2
      ;;
    --sources-dir)
      sources_dir="${2:-}"
      shift 2
      ;;
    --local-source)
      local_source="${2:-}"
      shift 2
      ;;
    --dry-run)
      dry_run="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "unknown argument: $1"
      ;;
  esac
done

[[ -n "$repo_url" ]] || die "--repo must not be empty"
[[ -n "$branch" ]] || die "--branch must not be empty"
[[ -n "$dest" ]] || die "--dest must not be empty"
[[ -n "$sources_dir" ]] || die "--sources-dir must not be empty"

case "$dest" in
  /|.|..|human|"" )
    die "refusing unsafe destination: $dest"
    ;;
esac

command -v rsync >/dev/null 2>&1 || die "rsync is required"

log "repo: $repo_url"
log "branch: $branch"
log "destination: $dest"

if [[ "$dry_run" == "true" ]]; then
  log "dry run enabled; no files changed"
  printf 'dry-run\n'
  exit 0
fi

tmp_dir="$(mktemp -d)"
cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

source_dir=""
commit=""

if [[ -n "$local_source" ]]; then
  [[ -d "$local_source" ]] || die "local source does not exist: $local_source"
  source_dir="$local_source"
  if git -C "$local_source" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    commit="$(git -C "$local_source" rev-parse --verify HEAD 2>/dev/null || printf 'local-fixture')"
  else
    commit="local-fixture"
  fi
  log "using local source: $local_source"
else
  command -v git >/dev/null 2>&1 || die "git is required when --local-source is not used"
  source_dir="$tmp_dir/apicurio-registry"
  log "cloning shallow copy"
  git clone --depth 1 --branch "$branch" "$repo_url" "$source_dir" >&2
  commit="$(git -C "$source_dir" rev-parse HEAD)"
fi

retrieved_at="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

log "resolved commit: $commit"
mkdir -p "$dest" "$sources_dir"

log "syncing snapshot into $dest"
rsync -a --delete --exclude ".git" "$source_dir/" "$dest/"

cat > "$dest/_source.md" <<DOC
---
type: SourceSnapshot
title: Apicurio Registry source snapshot
source_repo: $repo_url
source_branch: $branch
source_commit: $commit
retrieved_at: $retrieved_at
status: human-source-snapshot
---

# Apicurio Registry source snapshot

This directory is a copied snapshot of the Apicurio Registry repository.

Do not edit this directory directly. Refresh it with:

\`\`\`bash
./scripts/sync-human-apicurio-registry.sh
\`\`\`
DOC

cat > "$sources_dir/apicurio-registry.md" <<DOC
---
type: SourceRepository
title: Apicurio Registry
id: source-apicurio-registry
repo: $repo_url
branch: $branch
commit: $commit
retrieved_at: $retrieved_at
local_snapshot: ../$dest
---

# Apicurio Registry

This source entry records the commit used to populate \`$dest/\`.

- Repository: \`$repo_url\`
- Branch: \`$branch\`
- Commit: \`$commit\`
- Retrieved: \`$retrieved_at\`
- Local snapshot: \`../$dest\`
DOC

log "wrote $dest/_source.md"
log "wrote $sources_dir/apicurio-registry.md"
printf '%s\n' "$commit"
