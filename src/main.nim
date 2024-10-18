import std/strformat

import ./state

import ./hal/hal
import ./hal/serial
import ./hal/time
import ./hal/nfc


## Initialize global state variables for FFI.

var globalStateValue: State = State()
var globalState* {. exportcpp: "state" .}: ptr State = globalStateValue.addr


proc setup*() =
  ## Hardware initialization and setup; runs once on boot.

  hal.initAllHardware()

  serial.printOnNewLine("Hello, World!")

proc loop*() =
  ## Main loop; repeats indefinitely.

  if nfc.isAvailable():
    serial.printOnNewLine("Available.")
  else:
    serial.printOnNewLine("Unavailable.")

  time.sleep(1000)
