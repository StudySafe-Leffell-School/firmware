## Bindings for arduino-pico `Wire.h`.


{.push header: "Wire.h".}
type
  TwoWire* {.importcpp: "TwoWire", bycopy.} = object
  PinSizeT* {.importcpp: "pin_size_t", bycopy.} = object


proc begin*(this: var TwoWire) {.importcpp: "begin".}
proc begin*(this: var TwoWire; address: uint8) {.importcpp: "begin".}
proc endProc*(this: var TwoWire) {.importcpp: "end".}
proc setSda*(this: var TwoWire; sda: PinSizeT): bool {.importcpp: "setSDA".}
proc setScl*(this: var TwoWire; scl: PinSizeT): bool {.importcpp: "setSCL".}
proc setSda*(this: var TwoWire; sda: cint): bool {.importcpp: "setSDA".}
proc setScl*(this: var TwoWire; scl: cint): bool {.importcpp: "setSCL".}
proc setClock*(this: var TwoWire; freqHz: uint32) {.importcpp: "setClock".}
proc beginTransmission*(this: var TwoWire; a2: uint8) {.
    importcpp: "beginTransmission".}
proc endTransmission*(this: var TwoWire; stopBit: bool): uint8 {.
    importcpp: "endTransmission".}
proc endTransmission*(this: var TwoWire): uint8 {.importcpp: "endTransmission".}
proc requestFrom*(this: var TwoWire; address: uint8; quantity: csize_t; stopBit: bool): csize_t {.
    importcpp: "requestFrom".}
proc requestFrom*(this: var TwoWire; address: uint8; quantity: csize_t): csize_t {.
    importcpp: "requestFrom".}
proc write*(this: var TwoWire; data: uint8): csize_t {.importcpp: "write".}
proc write*(this: var TwoWire; data: ptr uint8; quantity: csize_t): csize_t {.
    importcpp: "write".}
proc available*(this: var TwoWire): cint {.importcpp: "available".}
proc read*(this: var TwoWire): cint {.importcpp: "read".}
proc peek*(this: var TwoWire): cint {.importcpp: "peek".}
proc flush*(this: var TwoWire) {.importcpp: "flush".}
proc onReceive*(this: var TwoWire; a2: proc (a1: cint)) {.importcpp: "onReceive".}
proc onRequest*(this: var TwoWire; a2: proc ()) {.importcpp: "onRequest".}
proc write*(this: var TwoWire; n: culong): csize_t {.importcpp: "write".}
proc write*(this: var TwoWire; n: clong): csize_t {.importcpp: "write".}
proc write*(this: var TwoWire; n: cuint): csize_t {.importcpp: "write".}
proc write*(this: var TwoWire; n: cint): csize_t {.importcpp: "write".}
## using statement

proc writeReadAsync*(this: var TwoWire; address: uint8; wbuffer: pointer;
                    wbytes: csize_t; rbuffer: pointer; rbytes: csize_t;
                    sendStop: bool = true): bool {.importcpp: "writeReadAsync".}
proc writeAsync*(this: var TwoWire; address: uint8; buffer: pointer; bytes: csize_t;
                sendStop: bool = true): bool {.importcpp: "writeAsync".}
proc readAsync*(this: var TwoWire; address: uint8; buffer: pointer; bytes: csize_t;
               sendStop: bool = true): bool {.importcpp: "readAsync".}
proc finishedAsync*(this: var TwoWire): bool {.importcpp: "finishedAsync".}
proc abortAsync*(this: var TwoWire) {.importcpp: "abortAsync".}
proc onFinishedAsync*(this: var TwoWire; function: proc ()) {.
    importcpp: "onFinishedAsync".}
proc dmaIrqHandler*(this: var TwoWire) {.importcpp: "_dma_irq_handler".}
proc setTimeout*(this: var TwoWire; timeout: uint32 = 25; resetWithTimeout: bool = false) {.
    importcpp: "setTimeout".}
proc getTimeoutFlag*(this: var TwoWire): bool {.importcpp: "getTimeoutFlag".}
proc clearTimeoutFlag*(this: var TwoWire) {.importcpp: "clearTimeoutFlag".}
proc onIrq*(this: var TwoWire) {.importcpp: "onIRQ".}
var wire* {.importcpp: "Wire".}: TwoWire
var wire1* {.importcpp: "Wire1".}: TwoWire
{.pop.}
