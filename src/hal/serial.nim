## Hardware abstraction for serial communication.

when not defined(host):
  import ./drivers/core


proc isAvailable*(debugResult: bool = true): bool {.discardable.} =
  ## Return true if the serial interface is available.

  when not defined(host):
    result = core.serial1.available().bool
  else:
    result = debugResult

proc start*(baudRate: int = 9600): bool {.discardable.} =
  ## Start the serial interface with the specified baud rate.

  when not defined(host):
    core.serial1.begin(baudRate.culong)
  else:
    discard

proc stop*(): bool {.discardable.} =
  ## Stop the serial interface.

  when not defined(host):
    core.serial1.endproc()
  else:
    discard

proc print*(text: string): bool {.discardable.} =
  ## Print the specified text to the serial interface.

  when not defined(host):
    core.serial1.print(text)
  else:
    stdout.write(text)

proc printOnNewLine*(text: string): bool {.discardable.} =
  ## Print the specified text to the serial interface, followed by a new line.

  when not defined(host):
    core.serial1.println(text.cstring)
  else:
    stdout.write(text & "\n")
