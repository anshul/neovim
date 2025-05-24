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

fix:
    set -x
    alejandra .
    prettier --write --prose-wrap always --print-width 160 **/*.md
    markdownlint -f "**/*.md"
    ruff check --fix .
    ruff format .
    shopt -s globstar nullglob
    # shellcheck -f diff **/*.sh run/* | patch -p1 || true
    shellcheck -f diff run/* | patch -p1 || true
    stylua .
