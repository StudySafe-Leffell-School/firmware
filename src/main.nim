## Main program loop and initialization.

import std/[sugar, sequtils, strformat, options]

import ./hal/serial
import ./hal/time

import ./components/slots
import ./components/users

import ./stateTypes

import ./config


proc mainLoop(statePrevious: State) =
  ## Main top-level recursive function - loops indefinitely.

  var stateUpdated = statePrevious

  let slotsUpdatedHardwareData: seq[Slot] =
    slots.getHardwareUpdates(statePrevious.slots)

  let slotsUpdatedUsers: seq[Slot] =
    users.getSlotsUpdatedUsers(slotsUpdatedHardwareData, statePrevious.users)

  stateUpdated.slots = slotsUpdatedUsers

  time.sleep(500)
  serial.printOnNewLine(stateUpdated.dumpToString)

  mainLoop(stateUpdated)

proc entry*() =
  ## Entry point for launching mainLoop with proper initialization.

  let slotsInit: seq[Slot] =
    generalConfig.slotNfcChannels.mapIt(
      Slot(
        hardwareData: SlotHardwareData(
          nfcChannel: it,
          nfcDriver: slots.makeNfcDriver()
        )
      )
    )

  let stateInit: State = State(
    slots: slotsInit,
    users: generalConfig.users
  )

  serial.start()
  slots.start(slotsInit)

  time.sleep(5000)

  serial.printOnNewLine($slotsInit.mapIt(slots.isAvailable(it)))

  mainLoop(stateInit)
