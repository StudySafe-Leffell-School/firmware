## Hardware abstraction for time-related functions.

when not defined(host):
  import ./drivers/core
else:
  import os


proc sleep*(milliseconds: int): bool {.discardable.} =
  when not defined(host):
    core.delay(milliseconds.culong)
  else:
    os.sleep(milliseconds)


proc getUpTimeMillis*(debugResult: int = 0): int =
  when not defined(host):
    result = core.millis().int
  else:
    result = debugResult
