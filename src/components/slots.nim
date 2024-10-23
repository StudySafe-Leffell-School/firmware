## Component functions for slots.

import std/[options, sequtils]

import ../hal/nfc
import ../hal/time

import ../stateTypes


proc startSlot(slot: Slot): bool {.discardable.} =
  ## Start a slot.

  nfc.startChannel(slot.hardwareData.nfcChannel)

proc start*(slots: seq[Slot]): bool {.discardable.} =
  ## Start all slots.

  discard slots.map(startSlot)


proc getSlotHardwareUpdate*(slotHardwareData: SlotHardwareData): SlotHardwareData =
  ## Update and return the current state of a slot.

  let readNfcId = nfc.readChannelBlocking(slotHardwareData.nfcChannel, 50)

  var updatedSlotHardwareData = slotHardwareData
  updatedSlotHardwareData.nfcId = readNfcId

  time.sleep(50)

  result = updatedSlotHardwareData

proc getSlotHardwareUpdates*(slotsHardwareData: seq[SlotHardwareData]): seq[SlotHardwareData] =
  ## Update and return the current state of a sequence of slots.

  result = slotsHardwareData.map(getSlotHardwareUpdate)
