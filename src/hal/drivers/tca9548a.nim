import ./wire

proc begin* =
  wire.begin()

proc selectChannel*(channel: uint8) =
  wire.beginTransmission(0x70)
  wire.write(1 shl channel)
  wire.endTransmission()

