## Main app loop and entry point.

import types
import components
import config
import monad

import ./hal/serial
import ./hal/time


proc mainLoop(statePrevious: State): State =
  ## Main top-level function - to be called in a loop indefinitely.

  result = monad.make(statePrevious)
    .replaceIt(
      it.slots, slot.getUpdatedSlots(it.slots, it.users))
    .get()

  serial.printOnNewLine($result.slots)

  time.sleep(500)


proc entry*() =
  ## Entry point for launching `mainLoop` with proper initialization.

  let slotsInit: seq[Slot] = slot.makeSlots(config.slotNfcChannels)
  let stateInit: State = makeState(config.usersInit, slotsInit)

  serial.start()

  var state: State = stateInit
  while true:
    ## Unfortunately, due to the constrained hardware of microcontrollers, functional-style
    ## recursion is rendered unfeasable due to memory and recrsion depth issues. In this case,
    ## a `while` loop serves a suitable replacement.

    state = mainLoop(state)
