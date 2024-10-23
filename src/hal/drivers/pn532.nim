## Driver for PN532 NFC/RFID chips.

import std/options
import ./wire/wire
import ./pn532/adafruitPn532


const
  irq = 2
  reset = 3


type Pn532Driver* = object
  driverPointer*: ptr AdafruitPN532


proc makeDriver*(): Pn532Driver =
  ## Initialize the NFC drivers.

  var adafruitPn532Driver = cast[ptr AdafruitPN532](alloc0(sizeof(AdafruitPN532)))
  adafruitPn532Driver[] = constructAdafruitPN532(irq, reset, wire.wire.addr)

  result = Pn532Driver(
    driverPointer: adafruitPn532Driver
  )

proc begin*(pn532Driver: Pn532Driver): bool {.discardable.} =
  ## Start the Adafruit PN532 driver.

  discard pn532Driver.driverPointer[].begin()

proc getFirmwareVersion*(pn532Driver: Pn532Driver): int =
  ## Get the firmware version of the PN532.

  let firmwareVersion: uint32 = pn532Driver.driverPointer[].getFirmwareVersion()
  result = firmwareVersion.int

proc isAvailable*(pn532Driver: Pn532Driver): bool =
  ## Check if the PN532 is available.

  let firmwareVersion: uint32 = pn532Driver.driverPointer[].getFirmwareVersion()

  if firmwareVersion > 0:
    result = true

proc readCardUidBlocking*(pn532Driver: Pn532Driver, timeoutMillis: int): Option[int] =
  ## Read and return a card UID from the PN532 if present (blocking).

  var uid: ptr uint8 = cast[ptr uint8](alloc0(sizeof(uint8)))
  var uidLength: ptr uint8 = cast[ptr uint8](alloc0((sizeof(uint8))))

  let success: bool = pn532Driver.driverPointer[].readPassiveTargetID(PN532_MIFARE_ISO14443A, uid, uidLength, timeoutMillis.uint8)

  if success:
    result = (uid[].int).some

  uid.dealloc()
  uidLength.dealloc()
