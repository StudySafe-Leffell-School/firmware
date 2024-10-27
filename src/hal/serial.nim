## Hardware abstraction layer for serial interfacing.

when not defined(host):
  import ./drivers/core


proc isAvailable*(debugResult: bool = true): bool {.discardable.} =
  ## Returns true if the serial port is available.

  when not defined(host):
    result = core.serial1.available().bool
  else:
    result = debugResult

proc start*(baudRate: int = 9600): bool {.discardable.} =
  ## Starts the serial port with the specified baud rate.

  when not defined(host):
    core.serial1.begin(baudRate.culong)
  else:
    discard

proc stop*(): bool {.discardable.} =
  ## Stops the serial port.

  when not defined(host):
    core.serial1.endproc()
  else:
    discard

proc print*(text: string): bool {.discardable.} =
  ## Prints the specified text to the serial port.

  when not defined(host):
    core.serial1.print(text)
  else:
    stdout.write(text)

proc printOnNewLine*(text: string): bool {.discardable.} =
  ## Prints the specified text to the serial port followed by a new line.

  when not defined(host):
    core.serial1.println(text.cstring)
  else:
    stdout.write(text & "\n")
