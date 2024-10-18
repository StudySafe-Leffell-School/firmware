import ./nfc
import ./serial
import ./drivers/core

proc initAllHardware*() =
  nfc.init()
  serial.start(115200)
