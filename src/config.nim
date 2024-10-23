## System-wide configuration definitions.

import std/sequtils

import ./stateTypes


type
  GeneralConfig* = object
    slotNfcChannels*: seq[int]
    users*: seq[User]

let generalConfig* = GeneralConfig(
  slotNfcChannels: (0..1).toSeq(),
  users: @[
    User(
      name: "David",
      cardId: 19,
      itemId: 55
    ),
    User(
      name: "Jakey",
      cardId: 83,
      itemId: 33
    ),
    User(
      name: "Liel",
      cardId: 46,
      itemId: 11
    )
  ]
)
