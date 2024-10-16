import main


when not defined(release):
  main.setup()
  main.loop()
    
else:
  func NimMain() {.importc.}

  func setup() {.exportcpp.} =
    NimMain()
    main.setup()

  func loop() {.exportcpp.} =
    main.loop()