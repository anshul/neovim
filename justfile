set shell := ["bash", "-u", "-o", "pipefail", "-c"]

default:
    @just --list

alias r := run
alias b := build

build:
    nix build .#nvim

run:
    nix run .#

show:
    nix flake show

commit_lock:
    git add flake.lock
    git commit -m "chore: update flake"

update:
    nix flake update

update_commit:
    just update
    just commit_lock

lint:
    pre-commit run --all-files

check:
    nix flake check

test:
    busted tests/

test_integration:
    #!/usr/bin/env bash
    echo "Running integration tests..."
    busted tests/simple_spec.lua tests/functional_spec.lua tests/integration_spec.lua

test_unit:
    busted tests/example_spec.lua

test_all:
    #!/usr/bin/env bash
    echo "Running all tests..."
    busted tests/

validate:
    #!/usr/bin/env bash
    echo "Validating plugin configuration..."
    ./scripts/validate-plugins.sh

test_watch:
    #!/usr/bin/env bash
    find lua/ tests/ -name "*.lua" | entr -c busted tests/

test_ci:
    #!/usr/bin/env bash
    echo "Running CI test suite..."
    set -e
    echo "Running unit tests..."
    just test_unit
    echo "Running integration tests..."
    just test_integration
    echo "All tests passed!"

tdd:
    #!/usr/bin/env bash
    echo "Starting TDD loop - watching lua/ and tests/ for changes..."
    find lua/ tests/ -name "*.lua" 2>/dev/null | entr -c just test

logs:
    #!/usr/bin/env bash
    echo "=== Neovim Logs ==="
    logdir="$HOME/.local/state/nvim"
    if [ -d "$logdir" ]; then
        for log in "$logdir"/*.log "$logdir"/log; do
            if [ -f "$log" ]; then
                echo "--- $(basename "$log") ---"
                cat "$log" || echo "Unable to read $log"
                echo
            fi
        done
    else
        echo "Log directory not found: $logdir"
    fi

clear_logs:
    #!/usr/bin/env bash
    echo "Clearing Neovim logs..."
    logdir="$HOME/.local/state/nvim"
    if [ -d "$logdir" ]; then
        rm -f "$logdir"/*.log "$logdir"/log
        echo "Logs cleared from $logdir"
    else
        echo "Log directory not found: $logdir"
    fi

fix:
    set -x
    alejandra .
    prettier --write --prose-wrap always --print-width 160 **/*.md
    markdownlint -f *.md --ignore node_modules
    ruff check --fix .
    ruff format .
    shopt -s globstar nullglob
    # shellcheck -f diff **/*.sh run/* | patch -p1 || true
    shellcheck -f diff run/* | patch -p1 || true
    stylua .
