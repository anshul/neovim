#!/usr/bin/env bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "🔍 Validating Neovim plugin configuration..."
echo

ERRORS=0
WARNINGS=0

echo "📦 Checking plugin availability in Nix..."
check_plugin() {
  local plugin=$1
  if nix search nixpkgs "vimPlugins.$plugin" &>/dev/null; then
    echo -e "  ${GREEN}✓${NC} $plugin found in nixpkgs"
  else
    echo -e "  ${RED}✗${NC} $plugin NOT found in nixpkgs"
    ((ERRORS++))
  fi
}

echo "Checking required plugins:"
for plugin in obsidian-nvim fzf-lua plenary-nvim blink-cmp snacks-nvim; do
  check_plugin "$plugin"
done
echo

echo "🚀 Testing Neovim startup..."
if nix run .#nvim -- --headless -c "echo 'test'" -c "qa!" 2>&1 | grep -qE "(Error|Failed|require.*failed)"; then
  echo -e "${RED}✗ Startup errors detected${NC}"
  echo "  Run 'nix run .#nvim -- --headless -c \"qa!\"' to see details"
  ((ERRORS++))
else
  echo -e "${GREEN}✓ Neovim starts without errors${NC}"
fi
echo

echo "🔧 Checking lazy-loaded modules..."
LAZY_CHECK=$(nix run .#nvim -- --headless -c "
lua << EOF
local errors = {}
local modules = {
  'obsidian',
  'fzf-lua',
  'plenary',
  'snacks',
  'blink.cmp',
  'gitsigns',
  'oil',
  'conform',
  'lint',
}

for _, mod in ipairs(modules) do
  local ok, err = pcall(function()
    vim.cmd('packadd ' .. mod .. '.nvim')
  end)
  if not ok then
    table.insert(errors, mod .. ': ' .. tostring(err))
  end
end

if #errors > 0 then
  for _, err in ipairs(errors) do
    print('ERROR: ' .. err)
  end
else
  print('OK')
end
EOF
" -c "qa!" 2>&1)

if echo "$LAZY_CHECK" | grep -q "ERROR:"; then
  echo -e "${RED}✗ Some plugins failed to load:${NC}"
  echo "$LAZY_CHECK" | grep "ERROR:" | sed 's/^/  /'
  ((ERRORS++))
else
  echo -e "${GREEN}✓ All lazy-loaded plugins available${NC}"
fi
echo

echo "🔍 Checking for common dependency issues..."
MISSING_DEPS=$(nix run .#nvim -- --headless -c "
lua << EOF
local deps = {
  ['obsidian.nvim'] = {'plenary.nvim', 'fzf-lua'},
  ['gitsigns.nvim'] = {'plenary.nvim'},
  ['diffview.nvim'] = {'plenary.nvim'},
  ['neogit'] = {'plenary.nvim'},
  ['octo.nvim'] = {'plenary.nvim'},
}

local missing = {}
for plugin, required in pairs(deps) do
  for _, dep in ipairs(required) do
    local dep_path = vim.fn.globpath(vim.o.packpath, 'pack/*/opt/' .. dep, 1)
    if dep_path == '' then
      table.insert(missing, plugin .. ' requires ' .. dep)
    end
  end
end

if #missing > 0 then
  for _, msg in ipairs(missing) do
    print('MISSING: ' .. msg)
  end
else
  print('OK')
end
EOF
" -c "qa!" 2>&1)

if echo "$MISSING_DEPS" | grep -q "MISSING:"; then
  echo -e "${YELLOW}⚠ Missing plugin dependencies:${NC}"
  echo "$MISSING_DEPS" | grep "MISSING:" | sed 's/^/  /'
  ((WARNINGS++))
else
  echo -e "${GREEN}✓ All plugin dependencies satisfied${NC}"
fi
echo

echo "📋 Summary:"
if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
  echo -e "${GREEN}✅ All checks passed!${NC}"
  exit 0
else
  [ $ERRORS -gt 0 ] && echo -e "${RED}❌ Found $ERRORS error(s)${NC}"
  [ $WARNINGS -gt 0 ] && echo -e "${YELLOW}⚠ Found $WARNINGS warning(s)${NC}"
  exit 1
fi