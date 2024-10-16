{.push importc, header: "HardwareSerial.h".}
type
  HardwareSerial* {.importcpp: "HardwareSerial",  bycopy.} = object

var Serial* {.importcpp: "Serial".}: HardwareSerial
proc begin*(self: var HardwareSerial; baud: cint)
proc available*(self: var HardwareSerial): cint
proc read*(self: var HardwareSerial): cint
proc write*(self: var HardwareSerial; n: uint8): csize_t
proc print*(self: var HardwareSerial; s: cstring)
proc println*(self: var HardwareSerial; s: cstring)
{.pop.}

{.push importc, header: "Arduino.h".}
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
