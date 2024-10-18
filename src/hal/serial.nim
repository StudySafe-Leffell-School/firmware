when not defined(debug):
  import ../drivers/core

import ../state

var globalState {. importcpp: "state", codegenDecl: "extern $# $#" .}: ptr State

proc isAvailable*(debugResult: bool = true): bool =
  ## Returns true if the serial port is available.

  when not defined(debug):
    result = Serial.ifproc().bool
  else:
    result = debugResult

proc start*(baud: int) =
  ## Starts the serial port with the specified baud rate.

  when not defined(debug):
    Serial.begin(baud.cint)
  else:
    discard

proc stop*() =
  ## Stops the serial port.

  when not defined(debug):
    Serial.endproc()
  else:
    discard

proc print*(text: string) =
  ## Prints the specified text to the serial port.

  when not defined(debug):
    Serial.print(text.cstring)
  else:
    stdout.write(text)

proc printOnNewLine*(text: string) =
  ## Prints the specified text to the serial port followed by a new line.

  globalState.data += 1

  when not defined(debug):
    Serial.println(text.cstring)
  else:
    stdout.write(text & "\n")
