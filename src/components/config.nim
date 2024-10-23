## Config functions.

import std/sequtils

import types


proc makeConfig*(): Config =
  result = Config(
    slotNfcChannels: (0..1).toSeq()
  )
