## Global state structure.

include ./hal/drivers/state

type State* = object
  driverCore*: ptr DriverCore
