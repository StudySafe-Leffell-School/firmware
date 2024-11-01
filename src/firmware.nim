## Entry point for firmware build.

when not defined(host):
  {.emit: "#include <Arduino.h>".}
  {.emit: "#include <Wire.h>".}

import ./main


when not defined(host):
  proc NimMain() {.importc.}

  proc setup() {.exportcpp.} =
    ## Arduino setup function.
    NimMain()
    main.entry()

  proc loop() {.exportcpp.} =
    ## Arduino loop function.

else:
  main.entry()
