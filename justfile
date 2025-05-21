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
    alejandra .
    # editorconfig-checker --fix .
    markdownlint -f "**/*.md"
    ruff check --fix .
    ruff format .
    shopt -s globstar nullglob
    shellcheck -f diff **/*.sh | patch -p0 || true
    shfmt -w -i 4 -bn -sr **/*.sh

