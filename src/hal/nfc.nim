## Hardware abstraction layer for NFC.

import std/[options]

import types

when not defined(host):
  import ./drivers/adafruitPn532
  import ./drivers/tca9548a
  import ./drivers/wire

import ./time



proc makeDevice*(channel: int): NfcDevice =
  ## Initialize the NFC device and driver.
  when not defined(host):
    var adafruitPn532Driver = cast[ptr AdafruitPN532](alloc0(sizeof(AdafruitPN532)))
    adafruitPn532Driver[] = constructAdafruitPn532(100, 100, wire.wire.addr)

    let driver = Pn532Driver(
      driverPointer: adafruitPn532Driver
    )

    result =
      NfcDevice(
        driver: driver,
        channel: channel)

    tca9548a.begin()
  else:
    result =
      NfcDevice(
        driver: Pn532Driver()
      )

proc start*(nfcDevice: NfcDevice): bool {.discardable.} =
  ## Start the NFC chip on the specified channel.
  when not defined(host):
    tca9548a.selectChannel(nfcDevice.channel)
    time.sleep(50)
    discard nfcDevice.driver.driverPointer[].begin()
  else:
    time.sleep(50)

proc isAvailable*(nfcDevice: NfcDevice): bool =
  ## Return true if an NFC chip is available at the specified channel.
  when not defined(host):
    tca9548a.selectChannel(nfcDevice.channel)
    let firmwareVersion: uint32 = nfcDevice.driver.driverPointer[].getFirmwareVersion()

    if firmwareVersion > 0:
      result = true

proc getReadChannelBlocking*(nfcDevice: NfcDevice, timeoutMillis: int, debugResult: Option[int] = 1.some): Option[int] =
  ## Read and return an NFC tag UID on specified channel if a tag in-field. This function is blocking; set timeoutMillis.
  when not defined(host):
    tca9548a.selectChannel(nfcDevice.channel)
    var uidBuffer: ptr uint8 = cast[ptr uint8](alloc0(sizeof(uint8)))
    var uidLengthBuffer: ptr uint8 = cast[ptr uint8](alloc0((sizeof(uint8))))

    let success: bool =  nfcDevice.driver.driverPointer[].readPassiveTargetID(adafruitPn532.PN532_MIFARE_ISO14443A, uidBuffer, uidLengthBuffer, timeoutMillis.uint8)

    if success:
      result = (uidBuffer[].int).some

    uidBuffer.dealloc()
    uidLengthBuffer.dealloc()
  else:
    time.sleep(timeoutMillis)
    result = debugResult

proc getUpdate*(nfcDevice: NfcDevice): NfcDevice =
  ## Update and return the current state of an NFC device.
  result = nfcDevice
  result.readUid = getReadChannelBlocking(nfcDevice, 50)
