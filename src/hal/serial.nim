## Hardware abstraction layer for serial interfacing.

when not defined(debug):
  import ./drivers/serial


proc isAvailable*(debugResult: bool = true): bool {.discardable.} =
  ## Returns true if the serial port is available.

  when not defined(debug):
    when defined(simulate):
      result = serial.serial.available().bool
    else:
      result = serial.serial1.available().bool
  else:
    result = debugResult

proc start*(): bool {.discardable.} =
  ## Starts the serial port with the specified baud rate.

  when not defined(debug):
    when defined(simulate):
      serial.serial1.begin()
    else:
      serial.serial.begin()
  else:
    discard

proc stop*(): bool {.discardable.} =
  ## Stops the serial port.

  when not defined(debug):
    when defined(simulate):
      serial.serial1.endproc()
    else:
      serial.serial.endproc()
  else:
    discard

proc print*(text: string): bool {.discardable.} =
  ## Prints the specified text to the serial port.

  when not defined(debug):
    when defined(simulate):
      serial.serial1.print(text)
    else:
      serial.serial.print(text)
  else:
    stdout.write(text)

proc printOnNewLine*(text: string): bool {.discardable.} =
  ## Prints the specified text to the serial port followed by a new line.

  when not defined(debug):
    when defined(simulate):
      serial.serial1.println(text.cstring)
    else:
      serial.serial.println(text.cstring)
  else:
    stdout.write(text & "\n")
