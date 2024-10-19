{.push header: "Arduino.h".}
type
  Serial* = object

proc begin*(this: var Serial) {.importcpp: "begin".}
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
