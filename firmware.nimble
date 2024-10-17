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
  exec "cmd /c start /min cmd /c rd /s /q \"build/debug/nimcache\""
  exec "nim cpp --run --hints:off -w:off src/firmware"

task release, "Transpile and build release.":
  exec "nim cpp -d:release --hints:off src/firmware"
  exec "pio run -d platformio"

task upload, "Transpile, build, and upload release.":
  exec "nim cpp -d:release --hints:off src/firmware"
  exec "pio run -d platformio -t upload"
