import std/strformat

import ./state

import ./hal/serial
import ./hal/time


## Initialize global state variables for FFI.

var globalStateValue: State = State(data: 10)
var globalState* {. exportcpp: "state" .}: ptr State = globalStateValue.addr


proc setup*() =
  ## Hardware initialization and setup; runs once on boot.

  serial.start(115200)

  serial.printOnNewLine(&"Hello, World!.")

proc loop*() =
  ## Main loop; repeats indefinitely.

  serial.printOnNewLine(&"Hello, World! I've been awake for {$(time.getUpTimeMillis() div 1000)} seconds! State is {globalState.data}.")

  time.sleep(1000)
