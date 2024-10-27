## Bindings for arduino-pico `Arduino.h`.

{.push header: "Arduino.h".}

{.push importc.}

{.push nodecl.}
let LED_BUILTIN*: uint8
let INPUT*: uint8
let OUTPUT*: uint8
let INPUT_PULLUP*: uint8
let HIGH*: uint8
let LOW*: uint8
let LSBFIRST*: uint8
let MSBFIRST*: uint8
{.pop.}

proc delay*(milliseconds: culong)
proc delayMicroseconds*(microseconds: cuint)
proc millis*: culong
proc micros*: culong
proc pinMode*(pin: uint8, mode: uint8)
proc digitalWrite*(pin: uint8, value: uint8)
proc digitalRead*(pin: uint8): uint8
proc analogRead*(pin: uint8): cint
proc analogReference*(mode: uint8)
proc analogWrite*(pin: uint8, value: cint)
proc tone*(pin: uint8, frequency: cint, duration: culong = 0)
proc noTone*(pin: uint8)
proc pulseIn*(pin: uint8, value: uint8, timeout: culong = 1000000): culong
proc pulseInLong*(pin: uint8, value: uint8, timeout: culong = 1000000): culong
proc shiftIn*(data, clock: uint8, order: uint8): uint8
proc shiftOut*(data, clock: uint8, order: uint8, value: uint8)
proc randomSeed*(seed: int32)
proc random*(max: culong): culong
proc random*(min: culong, max: culong): culong
{.pop.}

type
  Serial* = object

proc begin*(this: var Serial) {.importcpp: "begin".}
proc begin*(this: var Serial; baud: culong) {.importcpp: "begin".}
proc begin*(this: var Serial; baud: culong; config: uint16) {.importcpp: "begin".}
proc endProc*(this: var Serial) {.importcpp: "end".}
proc peek*(this: var Serial): cint {.importcpp: "peek".}
proc read*(this: var Serial): cint {.importcpp: "read".}
proc available*(this: var Serial): cint {.importcpp: "available".}
proc availableForWrite*(this: var Serial): cint {.importcpp: "availableForWrite".}
proc flush*(this: var Serial) {.importcpp: "flush".}
proc write*(this: var Serial; c: uint8): csize_t {.importcpp: "write".}
proc write*(this: var Serial; p: ptr uint8; len: csize_t): csize_t {.importcpp: "write".}
proc print*(this: var Serial, s: cstring) {.importcpp: "print".}
proc println*(this: var Serial, s: cstring) {.importcpp: "println".}

var serial* {.importcpp: "Serial", nodecl.}: Serial
var serial1* {.importcpp: "Serial1", nodecl.}: Serial

{.pop.}
