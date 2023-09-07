---@diagnostic disable:undefined-global

local u = {}

u.rec_ls = function(args, snip, user_args)
  return sn(nil, {
    c(1, {
      -- important!! Having the sn(...) as the first choice will cause infinite recursion.
      t { '' },
      -- The same dynamicNode as in the snippet (also note: self reference).
      sn(nil, { t { '', '\t\\item ' }, i(1), d(2, u.rec_ls, {}) }),
    }),
  })
end

u.rec_prf = function(args, snip, user_args)
  -- P('user_args', user_args)
  -- P('args', args)
  -- P('snip', snip)
  -- return sn(
  --   nil,
  --   fmta(
  --     [[
  --     {<>{<>}}<>
  --     ]],
  --     {
  --       c(2, {
  --         i(nil, '\\prfassumption'),
  --         i(nil, '\\prfboundedassumption'),
  --       }),
  --       i(3),
  --       t { '' },
  --       d(1, u.rec_prf, {}),
  --     }
  --   )
  -- )
  -- return sn(nil, {
  --   c(1, {
  --     t { '' },
  --     sn(1, { t { '{\\prfassumption{' }, i(1), t { '}}', '' }, d(2, u.rec_prf, {}) }),
  --     sn(2, { t { '{\\prfboundassumption{' }, i(1), t { '}}', '' }, d(2, u.rec_prf, {}) }),
  --   }),
  -- })
  return sn(nil, {
    c(1, {
      t { '' },
      sn(1, { t { '{\\prfassumption{' }, i(1), t { '}}', '' }, d(2, u.rec_prf, {}) }),
      sn(2, { t { '{\\prfboundassumption{' }, i(1), t { '}}', '' }, d(2, u.rec_prf, {}) }),
    }),
  })
end

return {
  -- Endless list
  s({ trig = 'ls' }, {
    t { '\\begin{itemize}', '\t\\item ' },
    i(1),
    d(2, u.rec_ls, {}),
    t { '', '\\end{itemize}' },
    i(0),
  }),

  -- proof tree
  s(
    { trig = 'prf' },
    fmta(
      [[
      \prftree[<>]{$<>$}
      <>
      {<>}
      ]],
      {
        i(1),
        i(2),
        d(3, u.rec_prf, {}),
        i(4),
      }
    ),
    {}
  ),

  s({ trig = 'f' }, {
    f(function(args, snip, user_args)
      P('snip', snip)

      return ''
    end, {}),
  }),
}
