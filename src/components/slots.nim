## Component functions for slots.

import std/[options, sugar, sequtils]

import ../hal/nfc
import ../hal/time

import ../stateTypes


proc startSingle(slot: Slot): bool {.discardable.} =
  ## Start a slot.

  nfc.startChannel(slot.hardwareData.nfcDriver, slot.hardwareData.nfcChannel)

proc start*(slots: seq[Slot]): bool {.discardable.} =
  ## Start all slots.

  discard slots.map(startSingle)

proc isAvailable*(slot: Slot): bool =
  ## Returns true if given slot is available.

  result = nfc.isChannelAvailable(slot.hardwareData.nfcDriver, slot.hardwareData.nfcChannel)

proc makeNfcDriver*(): NfcDriver =
  result = nfc.makeDriver()

proc getHardwareUpdate*(slotHardwareData: SlotHardwareData): SlotHardwareData =
  ## Update and return the current state of a slot.

  let readNfcId = nfc.readChannelBlocking(slotHardwareData.nfcDriver, slotHardwareData.nfcChannel, 50)

  var updatedSlotHardwareData = slotHardwareData
  updatedSlotHardwareData.nfcId = readNfcId

  time.sleep(50)

  result = updatedSlotHardwareData

proc getHardwareUpdates*(slots: seq[Slot]): seq[Slot] =
  ## Update and return the current state of a sequence of slots.

  result = slots
    .zip(
      slots.mapIt(
        getHardwareUpdate(it.hardwareData)
      )
    )
    .map(
      (x) => (result = x[0]; result.hardwareData = x[1])
    )
