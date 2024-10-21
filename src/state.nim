import std/options

type
  User* = object
    ## Contains information regarding each registered user of the system.
    name*: string
    cardId*: int
    itemId*: int

  Slot* = object
    ## Contains infromation regarding each slot and their current occupants.
    occupied*: bool
    nfcId*: int
    nfcChannel*: int

  State* = object
    ## Contains information regarding the system's current state.
    slots*: seq[Slot]
