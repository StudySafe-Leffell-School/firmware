when not defined(debug):
  import ./drivers/core
else:
  import os


proc sleep*(milliseconds: int) =
  when not defined(debug):
    core.delay(milliseconds.culong)
  else:
    os.sleep(milliseconds)


proc getUpTimeMillis*(debugResult: int = 0): int =
  when not defined(debug):
    result = core.millis().int
  else:
    result = debugResult
