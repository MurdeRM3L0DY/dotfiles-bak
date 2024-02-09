local coroutine = _G.coroutine
local select = _G.select

local create = coroutine.create
local isyieldable = coroutine.isyieldable
local resume = coroutine.resume
local running = coroutine.running
local status = coroutine.status
local wrap = coroutine.wrap
local yield = coroutine.yield

return function(tag)
  local corou = {
    isyieldable = isyieldable,
    running = running,
    status = status,
  }
  tag = tag or {}

  local function for_wrap(co, ...)
    if tag == ... then
      return select(2, ...)
    else
      return for_wrap(co, co(yield(...)))
    end
  end

  local function for_resume(co, st, ...)
    if not st then
      return st, ...
    elseif tag == ... then
      return st, select(2, ...)
    else
      return for_resume(co, resume(co, yield(...)))
    end
  end

  function corou.create(f)
    return create(function(...)
      return tag, f(...)
    end)
  end

  function corou.resume(co, ...)
    return for_resume(co, resume(co, ...))
  end

  function corou.wrap(f)
    local co = wrap(function(...)
      return tag, f(...)
    end)
    return function(...)
      return for_wrap(co, co(...))
    end
  end

  function corou.yield(...)
    return yield(tag, ...)
  end

  return corou
end
