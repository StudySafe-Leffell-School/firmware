import ./nfc
import ./serial

proc initAllHardware*() =
  #nfc.init()
  serial.start()
