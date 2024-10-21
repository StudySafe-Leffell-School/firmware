import std/[sugar, sequtils, options]

import ../config


when not defined(debug):
  import ./drivers/pn532
  import ./drivers/tca9548a

proc init*(): bool {.discardable.} =
  when not defined(debug):
    pn532.init()
    tca9548a.begin()
  else:
    discard

proc startChannel*(channel: int): bool {.discardable.} =
  tca9548a.selectChannel(channel)
  pn532.begin()

proc isChannelAvailable*(channel: int): bool =
  tca9548a.selectChannel(channel)
  result = pn532.isAvailable()

proc readChannelBlocking*(channel: int, timeoutMillis: int, debugResult: Option[int] = 1.some): Option[int] =
  when not defined(debug):
    tca9548a.selectChannel(channel)
    result = pn532.readCardUidBlocking(timeoutMillis)
  else:
    result = debugResult
