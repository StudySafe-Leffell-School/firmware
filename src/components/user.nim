## User functions.

import std/[sugar, options, sequtils]

import types
import chain


proc getUserFromUsersByCardId*(cardId: int, users: seq[User]): Option[User] =
  ## If present, get the user with the specified card ID from a list of users.
  let filteredUsers: seq[User] = users.filterIt(it.cardId == cardId)

  if filteredUsers.len > 0:
    result = filteredUsers[0].some()

proc getUserFromUsersByItemId*(itemId: int, users: seq[User]): Option[User] =
  ## If present, get the user with the specified card ID from a list of users.
  let filteredUsers: seq[User] = users.filterIt(it.itemId == itemId)

  if filteredUsers.len > 0:
    result = filteredUsers[0].some()

proc isUserInSlots*(user: User, slots: seq[Slot]): bool =

  result = slots.filterIt(it.user == user.some()).len() > 0
