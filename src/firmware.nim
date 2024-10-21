{.emit: "#include <Arduino.h>".}

import ./main


when not defined(debug):
  proc NimMain() {.importc.}

  proc setup() {.exportcpp.} =
    ## Arduino setup function.

    NimMain()

  proc loop() {.exportcpp.} =
    ## Arduino loop function.

    main.entry()

else:
  main.entry()
