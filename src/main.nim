import std/strformat

import ./state

import ./hal/hal
import ./hal/serial
import ./hal/time
import ./hal/nfc


## Initialize global state variables for FFI.

var globalStateInstance: State = State()
var driverCoreInstance: DriverCore = DriverCore()
var globalState* {. exportcpp: "state" .}: ptr State = globalStateInstance.addr
globalState.driverCore = driverCoreInstance.addr


proc setup*() =
  ## Hardware initialization and setup; runs once on boot.

  hal.initAllHardware()

  serial.printOnNewLine("Hello, World!")

proc loop*() =
  ## Main loop; repeats indefinitely.

  serial.printOnNewLine("I'm still here!")

  #[if nfc.channelIsAvailable(0):
    serial.printOnNewLine("Available.")
  else:
    serial.printOnNewLine("Unavailable.")]#

  time.sleep(1000)
