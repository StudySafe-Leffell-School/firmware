import std/[options, sequtils]

import ../hal/nfc
import ../hal/time

import ../state


proc initSlot(slot: Slot): bool {.discardable.} =
  nfc.startChannel(slot.nfcChannel)

proc init*(slots: seq[Slot]): bool {.discardable.} =
  discard slots.map(initSlot)


proc getUpdatedSlot(slot: Slot): Slot =
  let readNfcId = nfc.readChannelBlocking(slot.nfcChannel, 500)
  #time.sleep(1000)
  #let readNfcId = 1.some

  var updatedSlot = slot
  if readNfcId.isSome():
    updatedSlot.occupied = true
    updatedSlot.nfcId = readNfcId.get()
  else:
    updatedSlot.occupied = false

  return updatedSlot

proc getUpdatedSlots*(slots: seq[Slot]): seq[Slot] =
  result = slots.map(getUpdatedSlot)
