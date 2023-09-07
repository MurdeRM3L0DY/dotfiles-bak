---@diagnostic disable:undefined-global

return {
  s(
    { trig = 'rfc' },
    fmt(
      [[
      interface {}Props {{
        children?: React.ReactNode
        {}
      }}

      const {}: React.FC<{}Props> = (props) => {{
        {}

        return ({})
      }}

      export default {};
      ]],
      {
        rep(1),
        i(2),
        d(1, function(args, snip, ...)
          return sn(nil, { t(snip.env.TM_FILENAME_BASE) })
        end),
        rep(1),
        i(3),
        i(4),
        rep(1),
      }
    )
  ),
}
