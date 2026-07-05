set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

blockscape_base_url := "https://pwright.github.io/apicurio-okf/"
blockscape_raw_base_url := "https://raw.githubusercontent.com/pwright/apicurio-okf/refs/heads/main/"
blockscape_app_base_url := "https://pwright.github.io/blockscape/"

# List available commands
_default:
    just --list

# Create directories and fetch configured human source snapshots
init:
    ./scripts/init-layout.sh
    ./scripts/sync-human-apicurio-registry.sh

# Create directories only
layout:
    ./scripts/init-layout.sh

# Refresh all configured human source snapshots
sync-human:
    ./scripts/sync-human-apicurio-registry.sh

# Dry-run all human source sync scripts
sync-human-dry-run:
    ./scripts/sync-human-apicurio-registry.sh --dry-run

# Refresh human/apicurio-registry/ from Apicurio Registry main
sync-human-apicurio-registry:
    ./scripts/sync-human-apicurio-registry.sh

# Build an offline test fixture and validate behavior without network
test:
    ./tests/smoke-test.sh

# Print unique tags from Markdown front matter
tags *paths:
    @./scripts/extract-frontmatter-tags.py {{paths}}

# Wrap Blockscape maps as generated Markdown pages
maps:
    ./tools/update-generated-maps.py --input maps --output generated/maps --source-base-url {{blockscape_raw_base_url}} --blockscape-base-url {{blockscape_app_base_url}}

# Stage publishable OKF content into Quartz
quartz-stage: maps
    python3 tools/stage-quartz-content.py --input human/apicurio-registry --input generated --input reviewed --input sources --output quartz/content --link-map linkmap.yaml

# Build the Quartz static site
quartz-build: quartz-stage
    cd quartz && node quartz/bootstrap-cli.mjs build

# Serve the Quartz site locally
quartz-serve: quartz-stage
    cd quartz && node quartz/bootstrap-cli.mjs build --serve

# Remove Quartz staged content and build output
quartz-clean:
    rm -rf quartz/content
    mkdir -p quartz/content
    touch quartz/content/.gitkeep
    rm -rf quartz/public

# Print the expected tree for the MVP
show-expected-layout:
    cat tests/golden/expected-layout.txt

# Print current top-level tree without requiring tree(1)
tree:
    find . -maxdepth 3 -type d -print | sort

# Print the base URL used for Blockscape external links
blockscape-base-url:
    @echo {{blockscape_base_url}}
