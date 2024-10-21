## Driver for PN532 NFC/RFID chips.

import std/options

import ../../globalStateType

import ./wire/wire
import ./pn532/adafruitPn532


const
  irq = 2
  reset = 3

## Import global state variables from c++ for FFI.

var globalState {. importcpp: "globalState", codegenDecl: "extern $# $#" .}: ptr GlobalState

proc init*(): bool {.discardable.} =
  ## Initialize the Adafruit PN532 driver.

  var pn532 = cast[ptr AdafruitPN532](alloc0(sizeof(AdafruitPN532)))
  pn532[] = constructAdafruitPN532(irq, reset, wire.wire.addr)
  globalState.driversState.adafruitPn532 = pn532

proc deinit*(): bool {.discardable.} =
  ## Deinitialize the Adafruit PN532 driver.

  globalState.driversState.adafruitPn532.dealloc()

proc begin*(): bool {.discardable.} =
  ## Start the Adafruit PN532 driver.

  discard globalState.driversState.adafruitPn532[].begin()

proc getFirmwareVersion*(): int =
  ## Get the firmware version of the PN532.

  let firmwareVersion: uint32 = globalState.driversState.adafruitPn532[].getFirmwareVersion()
  result = firmwareVersion.int

proc isAvailable*(): bool =
  ## Check if the PN532 is available.

  let firmwareVersion: uint32 = globalState.driversState.adafruitPn532[].getFirmwareVersion()

  if firmwareVersion > 0:
    result = true

proc readCardUidBlocking*(timeoutMillis: int): Option[int] =
  ## Read and return a card UID from the PN532 if present (blocking).

  var uid: ptr uint8 = cast[ptr uint8](alloc0(sizeof(uint8)))
  var uidLength: ptr uint8 = cast[ptr uint8](alloc0((sizeof(uint8))))

  let success: bool = globalState.driversState.adafruitPn532[].readPassiveTargetID(PN532_MIFARE_ISO14443A, uid, uidLength, timeoutMillis.uint8)

  if success:
    result = (uid[].int).some
  else:
    result = int.none()

  uid.dealloc()
  uidLength.dealloc()
