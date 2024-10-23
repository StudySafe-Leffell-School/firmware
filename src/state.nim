## State functions.

import types

proc makeState*(configInit: Config, usersInit: seq[User], slotsInit: seq[Slot]): State =
  result =
    State(
      config: configInit,
      users: usersInit,
      slots: slotsInit
    )
