## Hardware abstraction layer for NFC.

import std/[options]

when not defined(debug):
  import ./drivers/pn532
  import ./drivers/tca9548a

import ./time


when not defined(debug):
  type
    NfcDriver* = object
      pn532Driver*: Pn532Driver
else:
  type
    Pn532Driver = object
    NfcDriver* = object
      pn532Driver*: Pn532Driver


proc makeDriver*(): NfcDriver =
  ## Initialize the NFC drivers.

  when not defined(debug):
    result =
      NfcDriver(
        pn532Driver: pn532.makeDriver()
      )
    tca9548a.begin()
  else:
    result =
      NfcDriver(
        pn532Driver: Pn532Driver()
      )

proc startChannel*(nfcDriver: NfcDriver, channel: int): bool {.discardable.} =
  ## Start the NFC chip on the specified channel.

  when not defined(debug):
    tca9548a.selectChannel(channel)
    time.sleep(50)
    pn532.begin(nfcDriver.pn532Driver)

proc isChannelAvailable*(nfcDriver: NfcDriver, channel: int): bool =
  ## Return true if an NFC chip is available on the specified channel.

  when not defined(debug):
    tca9548a.selectChannel(channel)
    result = pn532.isAvailable(nfcDriver.pn532Driver)

proc readChannelBlocking*(nfcDriver: NfcDriver, channel: int, timeoutMillis: int, debugResult: Option[int] = 1.some): Option[int] =
  ## Read and return a card UID from the NFC chip on the specified channel if present (blocking).

  when not defined(debug):
    tca9548a.selectChannel(channel)
    result = pn532.readCardUidBlocking(nfcDriver.pn532Driver, timeoutMillis)
  else:
    result = debugResult
