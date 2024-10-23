## Hardware abstraction layer for NFC.

import std/[options]

import types

when not defined(debug):
  import ./drivers/pn532
  import ./drivers/tca9548a

import ./time


proc makeDevice*(channel: int): NfcDevice =
  ## Initialize the NFC device and driver.

  when not defined(debug):
    result =
      NfcDevice(
        driver: pn532.makeDriver(),
        channel: channel
      )
    tca9548a.begin()
  else:
    result =
      NfcDriver(
        pn532Driver: Pn532Driver()
      )

proc start*(nfcDevice: NfcDevice): bool {.discardable.} =
  ## Start the NFC chip on the specified channel.

  when not defined(debug):
    tca9548a.selectChannel(nfcDevice.channel)
    time.sleep(50)
    pn532.begin(nfcDevice.driver)

proc isAvailable*(nfcDevice: NfcDevice): bool =
  ## Return true if an NFC chip is available on the specified channel.

  when not defined(debug):
    tca9548a.selectChannel(nfcDevice.channel)
    result = pn532.isAvailable(nfcDevice.driver)

proc readChannelBlocking*(nfcDevice: NfcDevice, timeoutMillis: int, debugResult: Option[int] = 1.some): Option[int] =
  ## Read and return a card UID from the NFC chip on the specified channel if present (blocking).

  when not defined(debug):
    tca9548a.selectChannel(nfcDevice.channel)
    result = pn532.readCardUidBlocking(nfcDevice.driver, timeoutMillis)
  else:
    result = debugResult

proc getUpdate*(nfcDevice: NfcDevice): NfcDevice =
  result = nfcDevice
  result.readUid = readChannelBlocking(nfcDevice, 50)

