## Main app loop and entry point.

import types
import components
import config
import chain

import ./hal/serial
import ./hal/time


proc tick(statePrevious: State): State =
  ## Main top-level function - to be called in a loop indefinitely.
  result = chainIt(statePrevious):
    it.replace(slots, slot.getUpdatedSlots(it.slots, it.users))

  serial.printOnNewLine($result.slots)

  time.sleep(500)

proc entry*() =
  ## Entry point for looping `tick` with proper initialization.
  serial.start()
  serial.printOnNewLine("Alive.")

  let slotsInit: seq[Slot] = slot.makeSlots(config.slotNfcChannels)
  let stateInit: State = makeState(config.usersInit, slotsInit)

  var state: State = stateInit
  while true:
    ## Unfortunately, due to the constrained nature of the project's hardware, functional-style
    ## recursion is unfeasable due to memory and call-depth limitations. In this case,
    ## a `while` loop serves a suitable (if undesireable) replacement.
    state = tick(state)
