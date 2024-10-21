## Driver for the TCA9548A 8-channel I2C multiplexer.

import ./wire/wire

proc begin*(): bool {.discardable.} =
  discard wire.wire.begin()

proc selectChannel*(channel: int): bool {.discardable.} =
  wire.wire.beginTransmission(0x70.uint8)
  discard wire.wire.write(channel+1)
  discard wire.wire.endTransmission()
