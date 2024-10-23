##Type definitions for state.

import ./components

type
  State* = object
    ## Contains information about the system's current state.
    slots*: seq[Slot]
    users*: seq[User]
    config*: Config
