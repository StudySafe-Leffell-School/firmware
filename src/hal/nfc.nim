import std/options

when not defined(debug):
  import ./drivers/pn532
  import ./drivers/tca9548a
  import ./drivers/wire


proc init*() =
  when not defined(debug):
    wire.begin()

    pn532.init()
    pn532.begin()
  else:
    discard

proc channelIsAvailable*(channel: int): bool =
  when not defined(debug):
    tca9548a.selectChannel(channel.uint8)
    return pn532.isAvailable()
  else:
    discard

proc readCardUid*(channel: int, debugResult: Option[int] = 1.some): Option[int] =
  when not defined(debug):
    tca9548a.selectChannel(channel.uint8)
    result = pn532.readCardUid()
  else:
    result = debugResult
