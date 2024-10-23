## Type definitions for components.

import std/options

import ./hal


type
  Config* = object
    ## Contains information about the configuration of the system.
    slotNfcChannels*: seq[int]

  User* = object
    ## Contains information about each registered user.
    name*: string
    cardId*: int
    itemId*: int

  SlotHardwareData* = object
    ## Contains information about the hardware of a slot.
    nfcDevice*: NfcDevice

  Slot* = object
    ## Contains infromation about a slot and its current occupant/user.
    hardwareData*: SlotHardwareData
    user*: Option[User]
