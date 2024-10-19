import std/options

import ../../state

import ./wire/wire
import ./pn532/adafruitPn532


const
  irq = 10
  reset = 11


var globalState {. importcpp: "state", codegenDecl: "extern $# $#" .}: ptr State


proc init*() =
  globalState.driverCore.twoWire = wire.wire.addr
  var pn532: AdafruitPN532 = constructAdafruitPN532(irq, reset, globalState.driverCore.twoWire)
  globalState.driverCore.adafruitPn532 = pn532.addr

proc begin*() =
  discard globalState.driverCore.adafruitPn532[].begin()
  discard globalState.driverCore.adafruitPn532[].setPassiveActivationRetries(0xFF)

proc isAvailable*(): bool =
  let firmwareVersion: uint32 = globalState.driverCore.adafruitPn532[].getFirmwareVersion()

  if firmwareVersion > 0:
    result = true

proc readCardUid*(): Option[int] =
  var uid: uint8 = 0
  var uidLength: uint8

  let success: bool = globalState.driverCore.adafruitPn532[].readPassiveTargetID(PN532_MIFARE_ISO14443A, uid.addr, uidLength.addr)

  if success:
    result = (uid.int shl uidLength.int).some
