-- Example test file to demonstrate TDD setup
describe('Neovim Config Tests', function()
  it('should load without errors', function()
    -- Simple test to ensure basic functionality
    assert.is.equal(1 + 1, 2)
  end)

  it('should have proper lua path', function()
    -- Test that our lua modules can be found
    local package_path = package.path
    assert.is.truthy(package_path:find 'lua/')
  end)
end)
