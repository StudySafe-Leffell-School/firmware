import std/options

import ../../state
import ./pn532/adafruitPn532


const
  irq = 21
  reset = 22


var globalState {. importcpp: "state", codegenDecl: "extern $# $#" .}: ptr State


proc init*() =
  var pn532: AdafruitPN532 = constructAdafruitPN532(irq, reset, Wire.addr)
  globalState.wire = Wire.addr
  globalState.pn532 = pn532.addr

proc start*() =
  discard globalState.pn532[].begin()
  discard globalState.pn532[].setPassiveActivationRetries(0xFF)

proc isAvailable*(): bool =
  let firmwareVersion: uint32 = globalState.pn532[].getFirmwareVersion()

  if firmwareVersion > 0:
    result = true

proc readCardUid*(): Option[int] =
  var uid: uint8 = 0
  var uidLength: uint8

  let success: bool = globalState.pn532[].readPassiveTargetID(PN532_MIFARE_ISO14443A, uid.addr, uidLength.addr)

  if success:
    result = (uid.int shl uidLength.int).some
