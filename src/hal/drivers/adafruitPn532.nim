## Bindings for Adafruit_PN532 driver library.

import types

import ./wire

{.push header: "adafruit_pn532.h".}
proc constructAdafruitPn532*(irq: uint8, reset: uint8, theWire: ptr TwoWire): AdafruitPN532 {.
    constructor, importcpp: "Adafruit_PN532(@)".}
proc begin*(this: var AdafruitPN532): bool {.importcpp: "begin".}

proc reset*(this: var AdafruitPN532) {.importcpp: "reset".}
proc wakeup*(this: var AdafruitPN532) {.importcpp: "wakeup".}

proc samConfig*(this: var AdafruitPN532): bool {.importcpp: "SAMConfig".}

proc getFirmwareVersion*(this: var AdafruitPN532): uint32 {.
    importcpp: "getFirmwareVersion".}
proc sendCommandCheckAck*(this: var AdafruitPN532, cmd: ptr uint8, cmdlen: uint8,
                         timeout: uint16 = 100): bool {.
    importcpp: "sendCommandCheckAck".}
proc writeGpio*(this: var AdafruitPN532, pinstate: uint8): bool {.
    importcpp: "writeGPIO".}
proc readGpio*(this: var AdafruitPN532): uint8 {.importcpp: "readGPIO".}

proc setPassiveActivationRetries*(this: var AdafruitPN532, maxRetries: uint8): bool {.
    importcpp: "setPassiveActivationRetries".}
proc readPassiveTargetId*(this: var AdafruitPN532, cardbaudrate: uint8,
                         uid: ptr uint8, uidLength: ptr uint8, timeout: uint16 = 0): bool {.
    importcpp: "readPassiveTargetID".}
proc readPassiveTargetId*(this: var AdafruitPN532, cardbaudrate: uint8,
                         uid: ptr cuint, uidLength: ptr cuint, timeout: uint16 = 0): bool {.
    importcpp: "readPassiveTargetID".}
proc startPassiveTargetIddEtection*(this: var AdafruitPN532, cardbaudrate: uint8): bool {.
    importcpp: "startPassiveTargetIDDetection".}
proc readDetectedPassiveTargetId*(this: var AdafruitPN532, uid: ptr uint8,
                                 uidLength: ptr uint8): bool {.
    importcpp: "readDetectedPassiveTargetID".}
proc inDataExchange*(this: var AdafruitPN532, send: ptr uint8, sendLength: uint8,
                    response: ptr uint8, responseLength: ptr uint8): bool {.
    importcpp: "inDataExchange".}
proc inListPassiveTarget*(this: var AdafruitPN532): bool {.
    importcpp: "inListPassiveTarget".}
proc asTarget*(this: var AdafruitPN532): uint8 {.importcpp: "AsTarget".}

proc getDataTarget*(this: var AdafruitPN532, cmd: ptr uint8, cmdlen: ptr uint8): uint8 {.
    importcpp: "getDataTarget".}
proc setDataTarget*(this: var AdafruitPN532, cmd: ptr uint8, cmdlen: uint8): uint8 {.
    importcpp: "setDataTarget".}
proc mifareclassicIsFirstBlock*(this: var AdafruitPN532, uiBlock: uint32): bool {.
    importcpp: "mifareclassic_IsFirstBlock".}
proc mifareclassicIsTrailerBlock*(this: var AdafruitPN532, uiBlock: uint32): bool {.
    importcpp: "mifareclassic_IsTrailerBlock".}
proc mifareclassicAuthenticateBlock*(this: var AdafruitPN532, uid: ptr uint8,
                                    uidLen: uint8, blockNumber: uint32,
                                    keyNumber: uint8, keyData: ptr uint8): uint8 {.
    importcpp: "mifareclassic_AuthenticateBlock".}
proc mifareclassicReadDataBlock*(this: var AdafruitPN532, blockNumber: uint8,
                                data: ptr uint8): uint8 {.
    importcpp: "mifareclassic_ReadDataBlock".}
proc mifareclassicWriteDataBlock*(this: var AdafruitPN532, blockNumber: uint8,
                                 data: ptr uint8): uint8 {.
    importcpp: "mifareclassic_WriteDataBlock".}
proc mifareclassicFormatNdef*(this: var AdafruitPN532): uint8 {.
    importcpp: "mifareclassic_FormatNDEF".}
proc mifareclassicWriteNdefuri*(this: var AdafruitPN532, sectorNumber: uint8,
                               uriIdentifier: uint8, url: cstring): uint8 {.
    importcpp: "mifareclassic_WriteNDEFURI".}
proc mifareultralightReadPage*(this: var AdafruitPN532, page: uint8, buffer: ptr uint8): uint8 {.
    importcpp: "mifareultralight_ReadPage".}
proc mifareultralightWritePage*(this: var AdafruitPN532, page: uint8, data: ptr uint8): uint8 {.
    importcpp: "mifareultralight_WritePage".}
proc ntag2xxReadPage*(this: var AdafruitPN532, page: uint8, buffer: ptr uint8): uint8 {.
    importcpp: "ntag2xx_ReadPage".}
proc ntag2xxWritePage*(this: var AdafruitPN532, page: uint8, data: ptr uint8): uint8 {.
    importcpp: "ntag2xx_WritePage".}
proc ntag2xxWriteNdefuri*(this: var AdafruitPN532, uriIdentifier: uint8, url: cstring,
                         dataLen: uint8): uint8 {.
    importcpp: "ntag2xx_WriteNDEFURI".}
proc printHex*(data: ptr byte, numBytes: uint32) {.
    importcpp: "Adafruit_PN532::PrintHex(@)".}
proc printHexChar*(pbtData: ptr byte, numBytes: uint32) {.
    importcpp: "Adafruit_PN532::PrintHexChar(@)".}
{.pop.}
