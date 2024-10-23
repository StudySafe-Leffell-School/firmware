import std/[options]


## State type definitions.

type
  User* = object
    ## Contains information regarding each registered user of the system.
    name*: string
    cardId*: int
    itemId*: int

  SlotHardwareData* = object
    nfcId*: Option[int]
    nfcChannel*: int

  Slot* = object
    ## Contains infromation regarding each slot and their current occupants.
    hardwareData*: SlotHardwareData
    user*: Option[User]

  State* = object
    ## Contains information regarding the system's current state.
    slots*: seq[Slot]
    users*: seq[User]
