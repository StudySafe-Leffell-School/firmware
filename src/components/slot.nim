## Slot functions.

import std/[options, sequtils]

import hal
import monad
import user
import types


proc start(slot: Slot): bool {.discardable.} =
  ## Start a slot.

  nfc.start(slot.hardwareData.nfcDevice)

proc isAvailable*(slot: Slot): bool =
  ## Returns true if given slot is available.

  result = hal.nfc.isAvailable(slot.hardwareData.nfcDevice)

proc makeSlot(channel: int): Slot =
  ## Return a new slot on the provided NFC channel.

  result = Slot(
    hardwareData: SlotHardwareData(
      nfcDevice: hal.nfc.makeDevice(channel)
    )
  )

proc makeSlots*(channels: seq[int]): seq[Slot] =
  ## Start and return a sequence of slots on the provided NFC channels.
  result = channels.map(makeSlot)
  discard result.map(start)

proc getHardwareUpdate(slot: Slot): Slot =
  ## Update and return the current state of the hardware of a slot.
  result = slot
  result.hardwareData.nfcDevice = hal.nfc.getUpdate(result.hardwareData.nfcDevice)

proc getUserUpdate(slot: Slot, users: seq[User]): Slot =
  ## Find user who occupies slot, if one does.
  result = slot
  result.user = none(User)

  let readUid: Option[int] = slot.hardwareData.nfcDevice.readUid

  if readUid.isSome():
    result.user = user.getUserFromUsersByItemId(readUid.get(), users)

proc getUpdatedSlot*(slot: Slot, users: seq[User]): Slot =
  result =
    monad.make(slot)
      .chain(getHardwareUpdate)
      .chainIt(getUserUpdate(it, users))
      .get()

proc getUpdatedSlots*(slots: seq[Slot], users: seq[User]): seq[Slot] =
  ## Update and return the current state of a sequence of slots.
  result = slots.mapIt(getUpdatedSlot(it, users))
