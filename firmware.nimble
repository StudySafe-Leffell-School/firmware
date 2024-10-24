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
  rmDir("build/simulate")
  exec "nim cpp -d:simulate --hints:off -w:off src/firmware"
  exec "pio run -d platformio -e simulate"
  mkdir("build/simulate")
  mvDir("build/.pio/build/simulate", "build/simulate/build")
  rmDir("build/.pio")
  exec "wokwi-cli --interactive"

task release, "Transpile and build release.":
  rmDir("build/release")
  exec "nim cpp -d:release --hints:off -w:off src/firmware"
  if paramStr(10) != "transpile":
    exec "pio run -d platformio -e release"
    mkdir("build/release")
    mvDir("build/.pio/build/release", "build/release/build")
    rmDir("build/.pio")

task upload, "Upload and run release on board.":
  exec "picotool load -x build/release/build/firmware.uf2"

task monitor, "Serial monitor.":
  echo "Serial monitor: " & paramStr(10)

  when defined(windows):
    while true:
      try:
        exec "plink -serial " & paramStr(10) & " -sercfg 115200"
      except:
        discard
      echo "\nReconnecting..."
      exec "cmd /c timeout 1 > nul"
  else:
    while true:
      try:
        exec "screen " & paramStr(10) & " 115200"
      except:
        discard
      echo "\nReconnecting..."
      exec "sleep 1"
