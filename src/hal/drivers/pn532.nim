import std/options

import ../../globalStateType

import ./wire/wire
import ./pn532/adafruitPn532


const
  irq = 2
  reset = 3

var globalState {. importcpp: "globalState", codegenDecl: "extern $# $#" .}: ptr GlobalState

proc init*(): bool {.discardable.} =
  var pn532 = cast[ptr AdafruitPN532](alloc0(sizeof(AdafruitPN532)))
  pn532[] = constructAdafruitPN532(irq, reset, wire.wire.addr)
  globalState.driversState.adafruitPn532 = pn532

proc deinit*(): bool {.discardable.} =
  globalState.driversState.adafruitPn532.dealloc()

proc begin*(): bool {.discardable.} =
  discard globalState.driversState.adafruitPn532[].begin()

proc getFirmwareVersion*(): int =
  let firmwareVersion: uint32 = globalState.driversState.adafruitPn532[].getFirmwareVersion()
  result = firmwareVersion.int

proc isAvailable*(): bool =
  let firmwareVersion: uint32 = globalState.driversState.adafruitPn532[].getFirmwareVersion()

  if firmwareVersion > 0:
    result = true

proc readCardUidBlocking*(timeoutMillis: int): Option[int] =
  var uid: ptr uint8 = cast[ptr uint8](alloc0(7))
  var uidLength: ptr uint8 = cast[ptr uint8](alloc0((7)))

  let success: bool = globalState.driversState.adafruitPn532[].readPassiveTargetID(PN532_MIFARE_ISO14443A, uid, uidLength, timeoutMillis.uint8)

  if success:
    result = (uid[].int).some
  else:
    result = int.none()

  uid.dealloc()
  uidLength.dealloc()
