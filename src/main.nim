## Main program loop and initialization.

import std/[sugar, sequtils, strformat]

import ./state
import ./globalStateType

import ./hal/hal
import ./hal/serial
import ./hal/time
import ./hal/nfc

import ./components/slot
import ./components/user


## Initialize global state variables for FFI.

var driversStateInstance: DriversState = DriversState()

var globalStateInstance: GlobalState = GlobalState()
var globalStateExport* {. exportcpp: "globalState" .}: ptr GlobalState = globalStateInstance.addr

globalStateExport.driversState = driversStateInstance.addr


proc mainLoop(previousState: State) =
  ## Main top-level recursive function - loops indefinitely.

  var stateUpdatedSlots = previousState
  stateUpdatedSlots.slots = slot.getUpdatedSlots(previousState.slots)


  serial.printOnNewLine(stateUpdatedSlots.dumpToString)

  mainLoop(stateUpdatedSlots)

proc entry*() =
  ## Entry point for launching mainLoop with proper initialization.

  hal.hardwareInit()

  serial.start()

  serial.printOnNewLine("Hello, World!")

  let state = State(
    slots: @[
      Slot(nfcChannel: 0),
      Slot(nfcChannel: 1)
    ]
  )

  slot.init(state.slots)

  mainLoop(state)
