pcall(require, 'luarocks.loader')
local beautiful = require('beautiful') ---@module 'beautiful.init'

beautiful.init(require('ui.theme'))

require('config.startup')
require('config.screen')
require('config.keys')
require('config.client')
require('config.ruled')

local collectgarbage = collectgarbage

local memory_last_check_count = collectgarbage('count')
local memory_last_run_time = os.time()
local memory_growth_factor = 1.1 -- 10% over last
local memory_long_collection_time = 300 -- five minutes in seconds

collectgarbage('setpause', 110)
collectgarbage('setstepmul', 1000)
local gtimer = require('gears.timer')
gtimer {
  timeout = 5,
  autostart = true,
  call_now = true,
  callback = function()
    local cur_memory = collectgarbage('count')
    -- instead of forcing a garbage collection every 5 seconds
    -- check to see if memory has grown enough since we last ran
    -- or if we have waited a sificiently long time
    local elapsed = os.time() - memory_last_run_time
    local waited_long = elapsed >= memory_long_collection_time
    local grew_enough = cur_memory > (memory_last_check_count * memory_growth_factor)
    if grew_enough or waited_long then
      collectgarbage('collect')
      collectgarbage('collect')
      memory_last_run_time = os.time()
    end
    -- even if we didn't clear all the memory we would have wanted
    -- update the current memory usage.
    -- slow growth is ok so long as it doesn't go unchecked
    memory_last_check_count = collectgarbage('count')
  end,
}
