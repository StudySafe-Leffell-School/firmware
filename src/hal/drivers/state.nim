when not declared(debug):
  import ./pn532/adafruitPn532
  import ./wire/wire
else:
  type
    AdafruitPN532 = object
    TwoWire = object

type DriverCore* = object
  adafruitPn532*: ptr AdafruitPN532
  twoWire*: ptr TwoWire
  wireStarted*: ptr bool
