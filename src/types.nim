import std/options


when not defined(host):
  type
    AdafruitPN532* {.importcpp: "Adafruit_PN532", header: "adafruit_pn532.h", bycopy.} = object
else:
  type
    AdafruitPN532* = object


type
  Pn532Driver* = object
    ## Contains information about the NFC driver.
    driverPointer*: ptr AdafruitPN532

  NfcDevice* = object
    ## Contains information about the NFC chip.
    driver*: Pn532Driver
    readUid*: Option[int]
    channel*: int


  User* = object
    ## Contains information about each registered user.
    name*: string
    cardId*: int
    itemId*: int

  SlotHardwareData* = object
    ## Contains information about the hardware of a slot.
    nfcDevice*: NfcDevice

  Slot* = object
    ## Contains infromation about a slot's state.
    hardwareData*: SlotHardwareData
    user*: Option[User]

  UserReaderHardwareData* = object
    ## Contains information about the hardware of a user identification reader.
    nfcDevice*: NfcDevice

  UserReader* = object
    ## Contains information about a user identification reader.
    hardwareData*: UserReaderHardwareData
    user*: Option[User]

  State* = object
    ## Contains information about the current global state.
    users*: seq[User]
    slots*: seq[Slot]
    userReader*: UserReader
    currentUser*: Option[User]
