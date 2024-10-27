## User functions.

import std/[options, sequtils]

import types


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
