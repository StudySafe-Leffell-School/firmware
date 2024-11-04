import std/[options, sequtils]

import hal
import user
import types
import chain


proc makeReader*(channel: int): UserReader =
  result = UserReader(
    hardwareData: UserReaderHardwareData(
      nfcDevice: hal.nfc.makeDevice(channel)
    )
  )

proc getHardwareUpdate(userReader: UserReader): UserReader =
  result = userReader
  result.hardwareData.nfcDevice = hal.nfc.getUpdate(result.hardwareData.nfcDevice)

proc getUserUpdate(userReader: UserReader, users: seq[User]): UserReader =
  result = userReader
  result.user = none(User)

  let readUid: Option[int] = userReader.hardwareData.nfcDevice.readUid

  if readUid.isSome():
    result.user = user.getUserFromUsersByItemId(readUid.get(), users)

proc getUpdatedUserReader*(userReader: UserReader, users: seq[User]): UserReader =
  result = chainIt(userReader):
    getHardwareUpdate(it)
    getUserUpdate(it, users)
