## Static configuration definitions.

import std/sequtils

import ./types

const i2cMuxSda* = 16
const i2cMuxScl* = 17
const i2cMuxAddress* = 0x70

const slotNfcChannels* = (0..1).toSeq()

const usersInit* =
  @[
    User(
      name: "David",
      cardId: 209,
      itemId: 35
    ),
    User(
      name: "Jakey",
      cardId: 242,
      itemId: 19
    ),
    User(
      name: "Liel",
      cardId: 10,
      itemId: 67
    ),
    User(
      name: "Javier",
      cardId: 74,
      itemId: 163
    )
  ]
