## Global state structure.

include ./hal/drivers/driversStateType

type GlobalState* = object
  driversState*: ptr DriversState
