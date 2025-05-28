set shell := ["bash", "-u", "-o", "pipefail", "-c"]

default:
    @just --list

alias r := run

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
        # Find all log files recursively
        find "$logdir" -type f \( -name "*.log" -o -name "*log*" -o -name "*.err" -o -name "*.out" \) 2>/dev/null | sort | while read -r log; do
            if [ -f "$log" ] && [ -s "$log" ]; then
                # Get relative path from logdir
                relpath="${log#$logdir/}"
                echo "--- $relpath ---"
                cat "$log" || echo "Unable to read $log"
                echo
            fi
        done
        # Show message if no logs found
        if ! find "$logdir" -type f \( -name "*.log" -o -name "*log*" -o -name "*.err" -o -name "*.out" \) 2>/dev/null | grep -q .; then
            echo "No log files found in $logdir"
        fi
    else
        echo "Log directory not found: $logdir"
    fi

clear_logs:
    #!/usr/bin/env bash
    echo "Clearing Neovim logs..."
    logdir="$HOME/.local/state/nvim"
    if [ -d "$logdir" ]; then
        # Remove all log files recursively
        find "$logdir" -type f \( -name "*.log" -o -name "*log*" -o -name "*.err" -o -name "*.out" \) -delete 2>/dev/null
        echo "Logs cleared from $logdir"
    else
        echo "Log directory not found: $logdir"
    fi

tail_logs:
    #!/usr/bin/env bash
    echo "Tailing debug logs..."
    logdir="$HOME/.local/state/nvim"
    snacks_log="$logdir/snacks.log"
    notifications_log="$logdir/notifications.log"
    
    if [ -f "$snacks_log" ] || [ -f "$notifications_log" ]; then
        # Use tail -f to follow both logs if they exist
        tail_files=""
        [ -f "$snacks_log" ] && tail_files="$tail_files $snacks_log"
        [ -f "$notifications_log" ] && tail_files="$tail_files $notifications_log"
        
        echo "Following logs: $tail_files"
        echo "Press Ctrl+C to stop..."
        tail -f $tail_files
    else
        echo "No debug log files found. Expected:"
        echo "  $snacks_log"
        echo "  $notifications_log"
        echo ""
        echo "Make sure NVIM_DEBUG_NOTIFY=1 is set and restart Neovim to create these files."
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
