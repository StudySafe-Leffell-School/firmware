const
  WIRE_HAS_END* = 1
  WIRE_HAS_BUFFER_SIZE* = 1
const
  I2C_BUFFER_LENGTH* = 128

{.push header: "Wire.h".}
type
  TwoWire* {.importcpp: "TwoWire", bycopy.} = object


proc constructTwoWire*(busNum: uint8): TwoWire {.constructor,importcpp: "TwoWire(@)".}
proc destroyTwoWire*(this: var TwoWire) {.importcpp: "#.~TwoWire()".}
proc setPins*(this: var TwoWire; sda: cint; scl: cint): bool {.importcpp: "setPins".}
proc begin*(this: var TwoWire; sda: cint; scl: cint; frequency: uint32 = 0): bool {.importcpp: "begin".}
proc begin*(this: var TwoWire; slaveAddr: uint8; sda: cint; scl: cint; frequency: uint32): bool {.importcpp: "begin".}
proc begin*(this: var TwoWire): bool {.importcpp: "begin".}
proc begin*(this: var TwoWire; `addr`: uint8): bool {.importcpp: "begin".}
proc begin*(this: var TwoWire; `addr`: cint): bool {.importcpp: "begin".}
proc `end`*(this: var TwoWire): bool {.importcpp: "end".}

proc setBufferSize*(this: var TwoWire; bSize: csize_t): csize_t {.importcpp: "setBufferSize".}
proc setTimeOut*(this: var TwoWire; timeOutMillis: uint16) {.importcpp: "setTimeOut".}
proc getTimeOut*(this: var TwoWire): uint16 {.importcpp: "getTimeOut".}
proc setClock*(this: var TwoWire; a2: uint32): bool {.importcpp: "setClock".}
proc getClock*(this: var TwoWire): uint32 {.importcpp: "getClock".}
proc beginTransmission*(this: var TwoWire; address: uint16) {.importcpp: "beginTransmission".}
proc beginTransmission*(this: var TwoWire; address: uint8) {.importcpp: "beginTransmission".}
proc beginTransmission*(this: var TwoWire; address: cint) {.importcpp: "beginTransmission".}
proc endTransmission*(this: var TwoWire; sendStop: bool): uint8 {.importcpp: "endTransmission".}
proc endTransmission*(this: var TwoWire): uint8 {.importcpp: "endTransmission".}
proc requestFrom*(this: var TwoWire; address: uint16; size: csize_t; sendStop: bool): csize_t {.
    importcpp: "requestFrom".}
proc requestFrom*(this: var TwoWire; address: uint16; size: uint8; sendStop: bool): uint8 {.importcpp: "requestFrom".}
proc requestFrom*(this: var TwoWire; address: uint16; size: uint8; sendStop: uint8): uint8 {.importcpp: "requestFrom".}
proc requestFrom*(this: var TwoWire; address: uint8; len: csize_t; stopBit: bool): csize_t {.importcpp: "requestFrom".}
proc requestFrom*(this: var TwoWire; address: uint16; size: uint8): uint8 {.importcpp: "requestFrom".}
proc requestFrom*(this: var TwoWire; address: uint8; size: uint8; sendStop: uint8): uint8 {.importcpp: "requestFrom".}
proc requestFrom*(this: var TwoWire; address: uint8; size: uint8): uint8 {.importcpp: "requestFrom".}
proc requestFrom*(this: var TwoWire; address: cint; size: cint; sendStop: cint): uint8 {.importcpp: "requestFrom".}
proc requestFrom*(this: var TwoWire; address: cint; size: cint): uint8 {.importcpp: "requestFrom".}
proc write*(this: var TwoWire; a2: uint8): csize_t {.importcpp: "write".}
proc write*(this: var TwoWire; a2: ptr uint8; a3: csize_t): csize_t {.importcpp: "write".}
proc available*(this: var TwoWire): cint {.importcpp: "available".}
proc read*(this: var TwoWire): cint {.importcpp: "read".}
proc peek*(this: var TwoWire): cint {.importcpp: "peek".}
proc flush*(this: var TwoWire) {.importcpp: "flush".}
proc write*(this: var TwoWire; s: cstring): csize_t {.importcpp: "write".}
proc write*(this: var TwoWire; n: culong): csize_t {.importcpp: "write".}
proc write*(this: var TwoWire; n: clong): csize_t {.importcpp: "write".}
proc write*(this: var TwoWire; n: cuint): csize_t {.importcpp: "write".}
proc write*(this: var TwoWire; n: cint): csize_t {.importcpp: "write".}
proc onReceive*(this: var TwoWire; a2: proc (a1: cint)) {.importcpp: "onReceive".}
proc onRequest*(this: var TwoWire; a2: proc ()) {.importcpp: "onRequest".}
proc slaveWrite*(this: var TwoWire; a2: ptr uint8; a3: csize_t): csize_t {.importcpp: "slaveWrite".}
var wire* {.importcpp: "Wire", nodecl.}: TwoWire
var wire1* {.importcpp: "Wire1", nodecl.}: TwoWire
{.pop}
