# Package

version       = "0.0.1"
author        = "David Goldstein"
description   = "Embedded firmware for StudySafe."
license       = "Proprietary"
srcDir        = "src"
bin           = @["firmware"]


# Dependencies

requires "nim >= 2.0.6"


task debug, "Transpile, build, and run debug.":
  rmDir("build/debug")
  exec "nim cpp -d:debug --run --hints:off -w:off src/firmware"

task simulate, "Transpile, build, and run simulation.":
  exec "nim cpp -d:simulate --hints:off -w:off src/firmware"
  exec "pio run -d platformio -e simulate"
  rmDir("build/simulate")
  mkdir("build/simulate")
  mvDir("build/.pio/build/simulate", "build/simulate/build")
  rmDir("build/.pio")
  exec "wokwi-cli --interactive"

task release, "Transpile and build release.":
  exec "nim cpp -d:release --hints:off -w:off src/firmware"
  exec "pio run -d platformio -e release"
  rmDir("build/release")
  mkdir("build/release")
  mvDir("build/.pio/build/release", "build/release/build")
  rmDir("build/.pio")

task upload, "Upload release to board.":
  exec "esptool write_flash 0x0 build/release/build/firmware.bin"
