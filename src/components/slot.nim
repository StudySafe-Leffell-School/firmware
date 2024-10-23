## Slot functions.

import std/[options, sequtils]

import hal
import types


proc start(slot: Slot): bool {.discardable.} =
  ## Start a slot.

  nfc.start(slot.hardwareData.nfcDevice)

proc isAvailable*(slot: Slot): bool =
  ## Returns true if given slot is available.

  result = nfc.isAvailable(slot.hardwareData.nfcDevice)

proc makeSlot(channel: int): Slot =
  ## Return a new slot on the provided NFC channel.

  result = Slot(
    hardwareData: SlotHardwareData(
      nfcDevice: nfc.makeDevice(channel)
    )
  )

proc makeSlots*(channels: seq[int]): seq[Slot] =
  ## Return and start a sequence of slots on the provided NFC channels.

  result = channels.map(makeSlot)
  discard result.map(start)

proc getHardwareUpdate(slot: Slot): Slot =
  ## Update and return the current state of a slot.

  result = slot
  result.hardwareData.nfcDevice = nfc.getUpdate(result.hardwareData.nfcDevice)

proc getHardwareUpdates*(slots: seq[Slot]): seq[Slot] =
  ## Update and return the current state of a sequence of slots.

  result = slots
    .map(
      getHardwareUpdate
    )

proc getUserUpdate(slot: Slot, users: seq[User]): Slot =
  result = slot

  if slot.hardwareData.nfcDevice.readUid.isSome():
    let filteredUsers = users
      .filterIt(slot.hardwareData.nfcDevice.readUid.get() == it.itemId)
    if filteredUsers.len() > 0:
      result.user = filteredUsers[0].some()

proc getUserUpdates*(slots: seq[Slot], users: seq[User]): seq[Slot] =
  ## If present, get the users with the specified item IDs from a list of users.

  result = slots.mapIt(getUserUpdate(it, users))

