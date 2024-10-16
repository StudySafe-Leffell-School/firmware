# Package

version       = "0.0.1"
author        = "David Goldstein"
description   = "Embedded firmware for device."
license       = "Proprietary"
srcDir        = "src"
bin           = @["firmware"]


# Dependencies

requires "nim >= 2.0.6"


task debug, "Transpile, build, and run debug.":
  exec "nim cpp --run --hints:off src/firmware"