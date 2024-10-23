## Main app loop and initialization.

import std/[sugar, sequtils]

import types
import components

import ./hal/serial
import ./hal/time

import ./state



proc getUpdatedSlots(stateSlots: seq[Slot], stateUsers: seq[User]): seq[Slot] =
  ## Return updated sequence of slot.

  let slotsUpdatedHardwareData: seq[Slot] = slot.getHardwareUpdates(stateSlots)
  let slotsUpdatedUsers: seq[Slot] = slot.getUserUpdates(slotsUpdatedHardwareData, stateUsers)

  result = slotsUpdatedUsers

proc mainLoop(statePrevious: State) =
  ## Main top-level recursive function - loops indefinitely.

  var stateUpdated = statePrevious

  stateUpdated.slots = getUpdatedSlots(statePrevious.slots, statePrevious.users)

  time.sleep(500)
  serial.printOnNewLine(stateUpdated.slots.dumpToString)

  mainLoop(stateUpdated)

proc entry*() =
  ## Entry point for launching mainLoop with proper initialization.

  let configInit: Config = config.makeConfig()

  let usersInit: seq[User] =
    @[
      User(
        name: "David",
        cardId: 19,
        itemId: 55
      ),
      User(
        name: "Jakey",
        cardId: 83,
        itemId: 33
      ),
      User(
        name: "Liel",
        cardId: 46,
        itemId: 11
      )
    ]

  let slotsInit: seq[Slot] = slot.makeSlots(configInit.slotNfcChannels)

  let stateInit: State = makeState(configInit, usersInit, slotsInit)

  serial.start()

  mainLoop(stateInit)
