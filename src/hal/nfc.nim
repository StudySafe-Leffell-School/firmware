## Hardware abstraction layer for NFC.

import std/[options]

when not defined(debug):
  import ./drivers/pn532
  import ./drivers/tca9548a

import ./time

proc init*(): bool {.discardable.} =
  ## Initialize the NFC drivers.

  when not defined(debug):
    pn532.init()
    tca9548a.begin()
  else:
    discard

proc startChannel*(channel: int): bool {.discardable.} =
  ## Start the NFC chip on the specified channel.

  when not defined(debug):
    tca9548a.selectChannel(channel)
    pn532.begin()

proc isChannelAvailable*(channel: int): bool =
  ## Return true if an NFC chip is available on the specified channel.

  when not defined(debug):
    tca9548a.selectChannel(channel)
    result = pn532.isAvailable()

proc readChannelBlocking*(channel: int, timeoutMillis: int, debugResult: Option[int] = 1.some): Option[int] =
  ## Read and return a card UID from the NFC chip on the specified channel if present (blocking).

  when not defined(debug):
    tca9548a.selectChannel(channel)
    result = pn532.readCardUidBlocking(timeoutMillis)
  else:
    result = debugResult
