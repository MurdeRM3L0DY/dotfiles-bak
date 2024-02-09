local M = {}

local uv = vim.loop
local fn = vim.fn
local api = vim.api

local password = function()
  fn.inputsave()
  local user = os.getenv('USER')
  local pw = fn.inputsecret(string.format('password for %s: ', user))
  fn.inputrestore()
  return pw
end

local test = function(pw, k)
  local stdin = uv.new_pipe()
  uv.spawn('sudo', {
    args = { '-S', '-k', 'true' },
    stdio = { stdin, nil, nil },
  }, k)

  if stdin then
    stdin:write(pw)
    stdin:write('\n')
    if not stdin:is_closing() then
      stdin:close()
    end
  end
end

local write = function(pw, buf, lines, k)
  local stdin = uv.new_pipe()
  uv.spawn('sudo', {
    args = { '-S', '-k', 'tee', buf },
    stdio = { stdin, nil, nil },
  }, k)

  if stdin then
    stdin:write(pw)
    stdin:write('\n')
    local last = table.remove(lines)
    for _, line in ipairs(lines) do
      stdin:write(line)
      stdin:write('\n')
    end
    stdin:write(last)
    if not stdin:is_closing() then
      stdin:close()
    end
  end
end

function M.sudowrite()
  local pw = password()
  local buf = api.nvim_buf_get_name(0)
  local lines = api.nvim_buf_get_lines(0, 0, -1, false)

  local function exitWrite(code, _)
    if code == 0 then
      vim.schedule(function()
        api.nvim_echo({ { string.format('"%s" written', buf), 'Normal' } }, true, {})
        api.nvim_buf_set_option(0, 'modified', false)
      end)
    end
  end
  local function exitTest(code, _)
    if code == 0 then
      write(pw, buf, lines, exitWrite)
    else
      vim.schedule(function()
        api.nvim_echo({ { 'incorrect password', 'ErrorMsg' } }, true, {})
      end)
    end
  end
  test(pw, exitTest)
end

M.sudo_exec = function(cmd, print_output)
  vim.fn.inputsave()
  local pw = vim.fn.inputsecret('Password: ')
  vim.fn.inputrestore()
  if not pw or #pw == 0 then
    return false
  end

  local out = vim.fn.system(string.format("sudo -p '' -S %s", cmd), pw)
  if vim.v.shell_error ~= 0 then
    print('\r\n', out)
    return false
  end
  if print_output then
    print('\r\n', out)
  end
  return true
end

M.sudo_write = function(tmpfile, filepath)
  if not tmpfile then
    tmpfile = fn.tempname()
  end
  if not filepath then
    filepath = vim.api.nvim_buf_get_name(0)
  end
  if not filepath or #filepath == 0 then
    return
  end
  -- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd
  -- Both `bs=1M` and `bs=1m` are non-POSIX
  local cmd = string.format(
    'dd if=%s of=%s bs=1048576',
    vim.fn.shellescape(tmpfile),
    vim.fn.shellescape(filepath)
  )
  -- no need to check error as this fails the entire function
  -- vim.api.nvim_exec(string.format('write! %s', tmpfile), true)
  vim.cmd.write { bang = true, args = { tmpfile } }
  if M.sudo_exec(cmd, true) then
    vim.cmd.e { bang = true }
  end
  fn.delete(tmpfile)
end

return M
