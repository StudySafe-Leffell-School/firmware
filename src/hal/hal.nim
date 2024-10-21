import ./nfc

proc hardwareInit*(): bool {.discardable.} =
  nfc.init()
