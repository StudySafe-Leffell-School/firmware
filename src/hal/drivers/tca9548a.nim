## Driver for TCA9548A 8-channel I2C multiplexer.
## Driver for TCA9548A 8-channel I2C multiplexer.

import ./wire
import config

proc begin*(): bool {.discardable.} =
  discard wire.wire.setSda(config.i2cMuxSda.cint)
  discard wire.wire.setScl(config.i2cMuxScl.cint)
  wire.wire.begin()

proc selectChannel*(channel: int): bool {.discardable.} =
  wire.wire.beginTransmission(config.i2cMuxAddress.uint8)
  discard wire.wire.write(channel+1)
  discard wire.wire.endTransmission()
