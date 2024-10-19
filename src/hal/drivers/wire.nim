{.emit: "#include <Arduino.h>".}

import ../../state

import ./wire/wire

var globalState {. importcpp: "state", codegenDecl: "extern $# $#" .}: ptr State

proc begin*() =
  if not globalState.driverCore.wireStarted[]:
    discard globalState.driverCore.twoWire[].begin()
    globalState.driverCore.wireStarted[] = true

proc beginTransmission*(address: int) =
  globalState.driverCore.twoWire[].beginTransmission(address)

proc write*(n: int) =
  globalState.driverCore.twoWire[].beginTransmission(n)

proc endTransmission*() =
  discard globalState.driverCore.twoWire[].endTransmission()
