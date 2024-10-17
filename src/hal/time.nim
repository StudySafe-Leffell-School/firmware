when defined(release):
  import ../drivers/core
else:
  import os


proc sleep*(milliseconds: int) =
  when defined(release):
    core.delay(milliseconds.culong)
  else:
    os.sleep(milliseconds)


proc getUpTimeMillis*(debugResult: int = 0): int =
  when defined(release):
    result = core.millis().int
  else:
    result = debugResult