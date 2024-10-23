## User functions.

import std/[options, sequtils]

import types


proc getUserFromUsersByCardId*(users: seq[User], cardId: int): Option[User] =
  ## Get the user with the specified card ID from a list of users if present.

  let filteredUsers: seq[User] = users.filterIt(it.cardId == cardId)

  if filteredUsers.len > 0:
    result = filteredUsers[0].some()

proc getUpdatedUser*(slotNfcId: Option[int], users: seq[User]): Option[User] =
  ## If present, get the user with the specified item ID from a list of users.

  if slotNfcId.isSome():
    let filteredUsers: seq[User] = users.filterIt(it.itemId == slotNfcId.get())

    if filteredUsers.len > 0:
      result = filteredUsers[0].some()
