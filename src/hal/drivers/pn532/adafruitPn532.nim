##  Driver for Adafruit_PN532 library. working with Adafruit PN532 NFC/RFID breakout boards.

import ../wire/wire

const
  PN532_PREAMBLE* = (0x00)      ## < Command sequence start, byte 1/3
  PN532_STARTCODE1* = (0x00)    ## < Command sequence start, byte 2/3
  PN532_STARTCODE2* = (0xFF)    ## < Command sequence start, byte 3/3
  PN532_POSTAMBLE* = (0x00)     ## < EOD
  PN532_HOSTTOPN532* = (0xD4)   ## < Host-to-PN532
  PN532_PN532TOHOST* = (0xD5)   ## < PN532-to-host

##  PN532 Commands

const
  PN532_COMMAND_DIAGNOSE* = (0x00) ## < Diagnose
  PN532_COMMAND_GETFIRMWAREVERSION* = (0x02) ## < Get firmware version
  PN532_COMMAND_GETGENERALSTATUS* = (0x04) ## < Get general status
  PN532_COMMAND_READREGISTER* = (0x06) ## < Read register
  PN532_COMMAND_WRITEREGISTER* = (0x08) ## < Write register
  PN532_COMMAND_READGPIO* = (0x0C) ## < Read GPIO
  PN532_COMMAND_WRITEGPIO* = (0x0E) ## < Write GPIO
  PN532_COMMAND_SETSERIALBAUDRATE* = (0x10) ## < Set serial baud rate
  PN532_COMMAND_SETPARAMETERS* = (0x12) ## < Set parameters
  PN532_COMMAND_SAMCONFIGURATION* = (0x14) ## < SAM configuration
  PN532_COMMAND_POWERDOWN* = (0x16) ## < Power down
  PN532_COMMAND_RFCONFIGURATION* = (0x32) ## < RF config
  PN532_COMMAND_RFREGULATIONTEST* = (0x58) ## < RF regulation test
  PN532_COMMAND_INJUMPFORDEP* = (0x56) ## < Jump for DEP
  PN532_COMMAND_INJUMPFORPSL* = (0x46) ## < Jump for PSL
  PN532_COMMAND_INLISTPASSIVETARGET* = (0x4A) ## < List passive target
  PN532_COMMAND_INATR* = (0x50) ## < ATR
  PN532_COMMAND_INPSL* = (0x4E) ## < PSL
  PN532_COMMAND_INDATAEXCHANGE* = (0x40) ## < Data exchange
  PN532_COMMAND_INCOMMUNICATETHRU* = (0x42) ## < Communicate through
  PN532_COMMAND_INDESELECT* = (0x44) ## < Deselect
  PN532_COMMAND_INRELEASE* = (0x52) ## < Release
  PN532_COMMAND_INSELECT* = (0x54) ## < Select
  PN532_COMMAND_INAUTOPOLL* = (0x60) ## < Auto poll
  PN532_COMMAND_TGINITASTARGET* = (0x8C) ## < Init as target
  PN532_COMMAND_TGSETGENERALBYTES* = (0x92) ## < Set general bytes
  PN532_COMMAND_TGGETDATA* = (0x86) ## < Get data
  PN532_COMMAND_TGSETDATA* = (0x8E) ## < Set data
  PN532_COMMAND_TGSETMETADATA* = (0x94) ## < Set metadata
  PN532_COMMAND_TGGETINITIATORCOMMAND* = (0x88) ## < Get initiator command
  PN532_COMMAND_TGRESPONSETOINITIATOR* = (0x90) ## < Response to initiator
  PN532_COMMAND_TGGETTARGETSTATUS* = (0x8A) ## < Get target status
  PN532_RESPONSE_INDATAEXCHANGE* = (0x41) ## < Data exchange
  PN532_RESPONSE_INLISTPASSIVETARGET* = (0x4B) ## < List passive target
  PN532_WAKEUP* = (0x55)        ## < Wake
  PN532_SPI_STATREAD* = (0x02)  ## < Stat read
  PN532_SPI_DATAWRITE* = (0x01) ## < Data write
  PN532_SPI_DATAREAD* = (0x03)  ## < Data read
  PN532_SPI_READY* = (0x01)     ## < Ready
  PN532_I2C_ADDRESS* = (0x48 shr 1) ## < Default I2C address
  PN532_I2C_READBIT* = (0x01)   ## < Read bit
  PN532_I2C_BUSY* = (0x00)      ## < Busy
  PN532_I2C_READY* = (0x01)     ## < Ready
  PN532_I2C_READYTIMEOUT* = (20) ## < Ready timeout
  PN532_MIFARE_ISO14443A* = (0x00) ## < MiFare

##  Mifare Commands

const
  MIFARE_CMD_AUTH_A* = (0x60)   ## < Auth A
  MIFARE_CMD_AUTH_B* = (0x61)   ## < Auth B
  MIFARE_CMD_READ* = (0x30)     ## < Read
  MIFARE_CMD_WRITE* = (0xA0)    ## < Write
  MIFARE_CMD_TRANSFER* = (0xB0) ## < Transfer
  MIFARE_CMD_DECREMENT* = (0xC0) ## < Decrement
  MIFARE_CMD_INCREMENT* = (0xC1) ## < Increment
  MIFARE_CMD_STORE* = (0xC2)    ## < Store
  MIFARE_ULTRALIGHT_CMD_WRITE* = (0xA2) ## < Write (MiFare Ultralight)

##  Prefixes for NDEF Records (to identify record type)

const
  NDEF_URIPREFIX_NONE* = (0x00) ## < No prefix
  NDEF_URIPREFIX_HTTP_WWWDOT* = (0x01) ## < HTTP www. prefix
  NDEF_URIPREFIX_HTTPS_WWWDOT* = (0x02) ## < HTTPS www. prefix
  NDEF_URIPREFIX_HTTP* = (0x03) ## < HTTP prefix
  NDEF_URIPREFIX_HTTPS* = (0x04) ## < HTTPS prefix
  NDEF_URIPREFIX_TEL* = (0x05)  ## < Tel prefix
  NDEF_URIPREFIX_MAILTO* = (0x06) ## < Mailto prefix
  NDEF_URIPREFIX_FTP_ANONAT* = (0x07) ## < FTP
  NDEF_URIPREFIX_FTP_FTPDOT* = (0x08) ## < FTP dot
  NDEF_URIPREFIX_FTPS* = (0x09) ## < FTPS
  NDEF_URIPREFIX_SFTP* = (0x0A) ## < SFTP
  NDEF_URIPREFIX_SMB* = (0x0B)  ## < SMB
  NDEF_URIPREFIX_NFS* = (0x0C)  ## < NFS
  NDEF_URIPREFIX_FTP* = (0x0D)  ## < FTP
  NDEF_URIPREFIX_DAV* = (0x0E)  ## < DAV
  NDEF_URIPREFIX_NEWS* = (0x0F) ## < NEWS
  NDEF_URIPREFIX_TELNET* = (0x10) ## < Telnet prefix
  NDEF_URIPREFIX_IMAP* = (0x11) ## < IMAP prefix
  NDEF_URIPREFIX_RTSP* = (0x12) ## < RTSP
  NDEF_URIPREFIX_URN* = (0x13)  ## < URN
  NDEF_URIPREFIX_POP* = (0x14)  ## < POP
  NDEF_URIPREFIX_SIP* = (0x15)  ## < SIP
  NDEF_URIPREFIX_SIPS* = (0x16) ## < SIPS
  NDEF_URIPREFIX_TFTP* = (0x17) ## < TFPT
  NDEF_URIPREFIX_BTSPP* = (0x18) ## < BTSPP
  NDEF_URIPREFIX_BTL2CAP* = (0x19) ## < BTL2CAP
  NDEF_URIPREFIX_BTGOEP* = (0x1A) ## < BTGOEP
  NDEF_URIPREFIX_TCPOBEX* = (0x1B) ## < TCPOBEX
  NDEF_URIPREFIX_IRDAOBEX* = (0x1C) ## < IRDAOBEX
  NDEF_URIPREFIX_FILE* = (0x1D) ## < File
  NDEF_URIPREFIX_URN_EPC_ID* = (0x1E) ## < URN EPC ID
  NDEF_URIPREFIX_URN_EPC_TAG* = (0x1F) ## < URN EPC tag
  NDEF_URIPREFIX_URN_EPC_PAT* = (0x20) ## < URN EPC pat
  NDEF_URIPREFIX_URN_EPC_RAW* = (0x21) ## < URN EPC raw
  NDEF_URIPREFIX_URN_EPC* = (0x22) ## < URN EPC
  NDEF_URIPREFIX_URN_NFC* = (0x23) ## < URN NFC
  PN532_GPIO_VALIDATIONBIT* = (0x80) ## < GPIO validation bit
  PN532_GPIO_P30* = (0)         ## < GPIO 30
  PN532_GPIO_P31* = (1)         ## < GPIO 31
  PN532_GPIO_P32* = (2)         ## < GPIO 32
  PN532_GPIO_P33* = (3)         ## < GPIO 33
  PN532_GPIO_P34* = (4)         ## < GPIO 34
  PN532_GPIO_P35* = (5)         ## < GPIO 35


type
  AdafruitPN532* {.importcpp: "Adafruit_PN532", header: "adafruit_pn532.h", bycopy.} = object

proc constructAdafruitPN532*(irq: uint8, reset: uint8, theWire: ptr TwoWire): AdafruitPN532 {.
    constructor, importcpp: "Adafruit_PN532(@)", header: "adafruit_pn532.h".}
proc begin*(this: var AdafruitPN532): bool {.importcpp: "begin",
                                        header: "adafruit_pn532.h".}
proc reset*(this: var AdafruitPN532) {.importcpp: "reset", header: "adafruit_pn532.h".}
proc wakeup*(this: var AdafruitPN532) {.importcpp: "wakeup",
                                    header: "adafruit_pn532.h".}
proc sAMConfig*(this: var AdafruitPN532): bool {.importcpp: "SAMConfig",
    header: "adafruit_pn532.h".}
proc getFirmwareVersion*(this: var AdafruitPN532): uint32 {.
    importcpp: "getFirmwareVersion", header: "adafruit_pn532.h".}
proc sendCommandCheckAck*(this: var AdafruitPN532, cmd: ptr uint8, cmdlen: uint8,
                         timeout: uint16 = 100): bool {.
    importcpp: "sendCommandCheckAck", header: "adafruit_pn532.h".}
proc writeGPIO*(this: var AdafruitPN532, pinstate: uint8): bool {.
    importcpp: "writeGPIO", header: "adafruit_pn532.h".}
proc readGPIO*(this: var AdafruitPN532): uint8 {.importcpp: "readGPIO",
    header: "adafruit_pn532.h".}
proc setPassiveActivationRetries*(this: var AdafruitPN532, maxRetries: uint8): bool {.
    importcpp: "setPassiveActivationRetries", header: "adafruit_pn532.h".}
proc readPassiveTargetID*(this: var AdafruitPN532, cardbaudrate: uint8,
                         uid: ptr uint8, uidLength: ptr uint8, timeout: uint16 = 0): bool {.
    importcpp: "readPassiveTargetID", header: "adafruit_pn532.h".}
proc startPassiveTargetIDDetection*(this: var AdafruitPN532, cardbaudrate: uint8): bool {.
    importcpp: "startPassiveTargetIDDetection", header: "adafruit_pn532.h".}
proc readDetectedPassiveTargetID*(this: var AdafruitPN532, uid: ptr uint8,
                                 uidLength: ptr uint8): bool {.
    importcpp: "readDetectedPassiveTargetID", header: "adafruit_pn532.h".}
proc inDataExchange*(this: var AdafruitPN532, send: ptr uint8, sendLength: uint8,
                    response: ptr uint8, responseLength: ptr uint8): bool {.
    importcpp: "inDataExchange", header: "adafruit_pn532.h".}
proc inListPassiveTarget*(this: var AdafruitPN532): bool {.
    importcpp: "inListPassiveTarget", header: "adafruit_pn532.h".}
proc asTarget*(this: var AdafruitPN532): uint8 {.importcpp: "AsTarget",
    header: "adafruit_pn532.h".}
proc getDataTarget*(this: var AdafruitPN532, cmd: ptr uint8, cmdlen: ptr uint8): uint8 {.
    importcpp: "getDataTarget", header: "adafruit_pn532.h".}
proc setDataTarget*(this: var AdafruitPN532, cmd: ptr uint8, cmdlen: uint8): uint8 {.
    importcpp: "setDataTarget", header: "adafruit_pn532.h".}
proc mifareclassicIsFirstBlock*(this: var AdafruitPN532, uiBlock: uint32): bool {.
    importcpp: "mifareclassic_IsFirstBlock", header: "adafruit_pn532.h".}
proc mifareclassicIsTrailerBlock*(this: var AdafruitPN532, uiBlock: uint32): bool {.
    importcpp: "mifareclassic_IsTrailerBlock", header: "adafruit_pn532.h".}
proc mifareclassicAuthenticateBlock*(this: var AdafruitPN532, uid: ptr uint8,
                                    uidLen: uint8, blockNumber: uint32,
                                    keyNumber: uint8, keyData: ptr uint8): uint8 {.
    importcpp: "mifareclassic_AuthenticateBlock", header: "adafruit_pn532.h".}
proc mifareclassicReadDataBlock*(this: var AdafruitPN532, blockNumber: uint8,
                                data: ptr uint8): uint8 {.
    importcpp: "mifareclassic_ReadDataBlock", header: "adafruit_pn532.h".}
proc mifareclassicWriteDataBlock*(this: var AdafruitPN532, blockNumber: uint8,
                                 data: ptr uint8): uint8 {.
    importcpp: "mifareclassic_WriteDataBlock", header: "adafruit_pn532.h".}
proc mifareclassicFormatNDEF*(this: var AdafruitPN532): uint8 {.
    importcpp: "mifareclassic_FormatNDEF", header: "adafruit_pn532.h".}
proc mifareclassicWriteNDEFURI*(this: var AdafruitPN532, sectorNumber: uint8,
                               uriIdentifier: uint8, url: cstring): uint8 {.
    importcpp: "mifareclassic_WriteNDEFURI", header: "adafruit_pn532.h".}
proc mifareultralightReadPage*(this: var AdafruitPN532, page: uint8, buffer: ptr uint8): uint8 {.
    importcpp: "mifareultralight_ReadPage", header: "adafruit_pn532.h".}
proc mifareultralightWritePage*(this: var AdafruitPN532, page: uint8, data: ptr uint8): uint8 {.
    importcpp: "mifareultralight_WritePage", header: "adafruit_pn532.h".}
proc ntag2xxReadPage*(this: var AdafruitPN532, page: uint8, buffer: ptr uint8): uint8 {.
    importcpp: "ntag2xx_ReadPage", header: "adafruit_pn532.h".}
proc ntag2xxWritePage*(this: var AdafruitPN532, page: uint8, data: ptr uint8): uint8 {.
    importcpp: "ntag2xx_WritePage", header: "adafruit_pn532.h".}
proc ntag2xxWriteNDEFURI*(this: var AdafruitPN532, uriIdentifier: uint8, url: cstring,
                         dataLen: uint8): uint8 {.
    importcpp: "ntag2xx_WriteNDEFURI", header: "adafruit_pn532.h".}
proc printHex*(data: ptr byte, numBytes: uint32) {.
    importcpp: "Adafruit_PN532::PrintHex(@)", header: "adafruit_pn532.h".}
proc printHexChar*(pbtData: ptr byte, numBytes: uint32) {.
    importcpp: "Adafruit_PN532::PrintHexChar(@)", header: "adafruit_pn532.h".}
