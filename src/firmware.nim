import main


when not defined(release):
  main.setup()
  main.loop()
    
else:
  proc NimMain() {.importc.}

  proc setup() {.exportcpp.} =
    NimMain()
    main.setup()

  proc loop() {.exportcpp.} =
    main.loop()