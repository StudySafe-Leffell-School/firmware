## Hardware abstraction layer initialization for the entire system.

import ./nfc

proc hardwareInit*(): bool {.discardable.} =
  nfc.init()
