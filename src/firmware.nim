import ./main


when defined(release):
  proc NimMain() {.importc.}

  proc setup() {.exportcpp.} =
    ## Arduino setup function.

    NimMain()
    main.setup()

  proc loop() {.exportcpp.} =
    ## Arduino loop function.

    main.loop()

else:
  main.setup()

  while true:
    main.loop()
