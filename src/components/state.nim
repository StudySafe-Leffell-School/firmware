## State functions.

import types

proc makeState*(usersInit: seq[User], slotsInit: seq[Slot], userReaderInit: UserReader): State =
  ## Return a new State object.
  result =
    State(
      users: usersInit,
      slots: slotsInit,
      userReader: userReaderInit
    )
