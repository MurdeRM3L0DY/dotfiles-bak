---@diagnostic disable:undefined-global

return {
  s({ trig = 'text' }, { t { 'simple text' } }, {}),

  s(
    { trig = 'lz' },
    fmta(
      [[
      ---@module '<>'
      local <> = lazy.require '<>'
      ]],
      {
        rep(1),
        i(2),
        i(1),
      }
    )
  ),
}
