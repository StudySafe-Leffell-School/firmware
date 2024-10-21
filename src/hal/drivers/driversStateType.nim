when not declared(debug):
  import ./pn532/adafruitPn532
else:
  type
    AdafruitPN532 = object

type DriversState* = object
  adafruitPn532*: ptr AdafruitPN532
