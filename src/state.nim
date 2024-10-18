## Global state structure.

when not defined(debug):
  import ./hal/drivers/pn532/adafruitPn532
else:
  type
    AdafruitPN532 = object
    TwoWire = object

type State* = object
  pn532*: ptr AdafruitPN532
  wire*: ptr TwoWire
