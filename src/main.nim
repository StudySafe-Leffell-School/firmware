## Main program loop and initialization.

import std/[sugar, sequtils, strformat, options]

import ./hal/hal
import ./hal/serial
import ./hal/time
import ./hal/nfc

import ./components/slots
import ./components/users

import ./stateTypes
import ./globalStateType

import ./config

## Initialize global state variables for FFI.

when not defined(debug):
  var driversStateInstance: DriversState = DriversState()

  var globalStateInstance: GlobalState = GlobalState()
  var globalStateExport* {. exportcpp: "globalState" .}: ptr GlobalState = globalStateInstance.addr

  globalStateExport.driversState = driversStateInstance.addr


proc mainLoop(statePrevious: State) =
  ## Main top-level recursive function - loops indefinitely.

  var stateUpdated = statePrevious

  let stateUpdatedSlotsHardwareData: seq[SlotHardwareData] =
    slots.getSlotHardwareUpdates(statePrevious.slots.mapIt(it.hardwareData))

  let stateUpdatedSlotsUsers: seq[Option[User]] =
    users.getUpdatedUsers(
      stateUpdatedSlotsHardwareData.mapIt(it.nfcId), statePrevious.users)

  let stateUpdatedSlots: seq[Slot] =
    stateUpdatedSlotsUsers.
    zip(stateUpdatedSlotsHardwareData).
    mapIt(
      Slot(
        user: it[0],
        hardwareData: it[1]
      )
    )

  stateUpdated.slots = stateUpdatedSlots

  time.sleep(500)
  serial.printOnNewLine(stateUpdated.dumpToString)

  mainLoop(stateUpdated)

proc entry*() =
  ## Entry point for launching mainLoop with proper initialization.

  let slotsInit: seq[Slot] = generalConfig.slotNfcChannels.mapIt(
    Slot(
      hardwareData: SlotHardwareData(
        nfcChannel: it
      )
    )
  )

  let stateInit: State = State(
    slots: slotsInit,
    users: generalConfig.users
  )

  hal.hardwareInit()
  serial.start()
  slots.start(slotsInit)

  time.sleep(5000)

  serial.printOnNewLine($slotsInit.mapIt(nfc.isChannelAvailable(it.hardwareData.nfcChannel)))

  mainLoop(stateInit)
