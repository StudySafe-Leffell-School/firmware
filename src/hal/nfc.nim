import std/options

when not defined(debug):
  import ./drivers/pn532


proc init*() =
  when not defined(debug):
    pn532.init()
    pn532.start()
  else:
    discard

proc isAvailable*(debugResult: bool = true): bool =
  when not defined(debug):
    result = pn532.isAvailable()
  else:
    result = debugResult

proc readCardUid*(debugResult: Option[int] = 1.some): Option[int] =
  when not defined(debug):
    result = pn532.readCardUid()
  else:
    result = debugResult
