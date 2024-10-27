## Simple monad implementation for functional-style data processing.

import std/[sugar]


type Monad[T] = object
  values: seq[T]


proc make*[T](value: T): Monad[T] =
  ## Return a new monad with a value.
  result = Monad[T](values: @[value])

proc get*[T](monad: Monad[T], index: int | BackwardsIndex = ^1): T =
  ## Return a value at index from a monad.
  result = monad.values[index]

proc chain*[T](monad: Monad[T], pred: (T) -> T): Monad[T] =
  ## Return a new monad with a predicate applied.
  result = monad
  result.values.add(pred(monad.values[^1]))

template chainIt*[T](monad: Monad[T], predicate: untyped): Monad[untyped] =
  ## Return a new monad with a predicate applied. Expression must use the `it` variable
  ## provided. `it` variable is useful when predicate contains multiple arguments.
  block:
    var result = monad
    let it {.inject.} = result.values[^1]

    proc `[]`(t: T, i: int | BackwardsIndex): T =
      result.values[i]

    result.values.add(predicate)
    result

template replaceIt*[T](monad: Monad[T], parameter: untyped, predicate: untyped): Monad[untyped] =
  ## Return a new monad with a replaced parameter. Expression must use the `it` variable provided.
  block:
    var result = monad
    var it {.inject.} = result.values[^1]

    proc `[]`(t: T, i: int | BackwardsIndex): T =
      result.values[i]

    parameter = predicate

    result.values.add(it)
    result
