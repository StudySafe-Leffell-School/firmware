## Component functions for users.

import std/[options, sequtils]

import ../stateTypes


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


proc getUpdatedUsers*(slotsNfcId: seq[Option[int]], users: seq[User]): seq[Option[User]] =
  ## If present, get the users with the specified item IDs from a list of users.

  let updatedUsers: seq[Option[User]] = slotsNfcId.mapIt(getUpdatedUser(it, users))

  result = updatedUsers
