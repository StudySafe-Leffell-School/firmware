##Type definitions for HAL.

import std/options


when not defined(debug):
  type
    AdafruitPN532* {.importcpp: "Adafruit_PN532", header: "adafruit_pn532.h", bycopy.} = object
else:
  type
    AdafruitPN532* = object

type
  ## Contains information about the NFC driver.
  Pn532Driver* = object
    driverPointer*: ptr AdafruitPN532

  ## Contains information about the NFC chip.
  NfcDevice* = object
    driver*: Pn532Driver
    readUid*: Option[int]
    channel*: int
