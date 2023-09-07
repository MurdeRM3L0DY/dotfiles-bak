-- https://github.com/ocamllabs/ocaml-effects-tutorial/blob/master/sources/solved/async_await.ml

local eff = require 'lib.eff'
local inst, perform, handler = eff.inst, eff.perform, eff.handler

local imut = require 'lib.eff.utils.imut'
local ref = require 'lib.eff.utils.ref'
local randoms = require 'lib.eff.utils.SEED'
randoms.init()

local Waiting = function(conts)
  return { conts, cls = 'waiting' }
end

local Done = function(a)
  return { a, cls = 'done' }
end

local Async = inst()
local async = function(f)
  return perform(Async(f))
end

local Yield = inst()
local yield = function()
  return perform(Yield())
end

local Await = inst()
local await = function(p)
  return perform(Await(p))
end

-- queue
local q = {}
local enqueue = function(t)
  table.insert(q, t)
end

local dequeue = function()
  local f = table.remove(q, 1)
  if f then
    return f()
  end
end

local run = function(main)
  local function fork(pr, _main)
    return handler {
      val = function(v)
        print 'ok'
        local pp = pr:get()
        local l

        if pp.cls == 'waiting' then
          l = pp[1]
        else
          error 'impossible'
        end

        for _, k in ipairs(l) do
          enqueue(function()
            return k(v)
          end)
        end

        pr(Done(v))
        return dequeue()
      end,
      [Async] = function(k, f)
        local pr_ = ref(Waiting {})
        enqueue(function()
          return k(pr_)
        end)
        return fork(pr_, f)
      end,
      [Yield] = function(k)
        enqueue(function()
          return k()
        end)
        return dequeue()
      end,
      [Await] = function(k, p)
        local pp = p:get()

        if pp.cls == 'done' then
          return k(pp[1])
        elseif pp.cls == 'waiting' then
          p(Waiting(imut.cons(k, pp[1])))
          return dequeue()
        end
      end,
    }(_main)
  end

  return fork(ref(Waiting {}), main)
end

local main = function()
  local task = function(name)
    return function()
      print(('Starting %s'):format(name))
      local v = math.random(100)
      print(('Yielding %s'):format(name))
      yield()
      print(('Ending %s with %d'):format(name, v))
      return v
    end
  end

  local pa = async(task 'a')
  local pb = async(task 'b')
  local pc = async(function()
    return await(pa) + await(pb)
  end)

  print(('sum is %d'):format(await(pc)))
end

run(main)

-- run(function()
--   print 'in run'
--
--   local r = vim.loop.spawn('ls', { args = { '/home/nemesis/' }}, function(code, signal)  print 'after ls' end)
--
--   P(r)
--   print 'yeahh'
-- end)
