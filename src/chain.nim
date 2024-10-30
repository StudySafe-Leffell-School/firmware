## Elegant function chaining for functional-style data processing.

import std/macros


macro chainIt*(variable: untyped, body: untyped): untyped =
  ## Sequentially apply multiple functions onto one variable.
  result = newStmtList()
  let intermediate = genSym(nskVar, "intermediate")
  result.add(
    quote do:
      var `intermediate` = `variable`
      var it {.inject.} = `intermediate`
  )
  for statement in body:
    result.add(
      quote do:
        it = `intermediate`
        `intermediate` = `statement`
    )
  result.add(
    quote do:
      `intermediate`
  )

template replace*[T](variable: T, parameter: untyped, newValue: untyped): T =
  ## Return
  block:
    var result = variable

    result.parameter = newValue

    result
