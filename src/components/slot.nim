## Component functions for slots.

import std/[options, sequtils]

import ../hal/nfc
import ../hal/time

import ../state


proc initSlot(slot: Slot): bool {.discardable.} =
  ## Initialize a slot.

  nfc.startChannel(slot.nfcChannel)

proc init*(slots: seq[Slot]): bool {.discardable.} =
  ## Initializes all slots.

  discard slots.map(initSlot)


proc getUpdatedSlot(slot: Slot): Slot =
  ## Update and return the current state of a slot.

  let readNfcId = nfc.readChannelBlocking(slot.nfcChannel, 50)
  #let readNfcId = 1.some

  var updatedSlot = slot
  if readNfcId.isSome():
    updatedSlot.occupied = true
    updatedSlot.nfcId = readNfcId.get()
  else:
    updatedSlot.occupied = false

  time.sleep(50)

  result = updatedSlot

proc getUpdatedSlots*(slots: seq[Slot]): seq[Slot] =
  ## Update and return the current state of a sequence of slots.

  result = slots.map(getUpdatedSlot)
