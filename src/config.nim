import std/sequtils

type NfcConfig* = object
  channels*: seq[int]

let nfcConfig* = NfcConfig(
  channels: (0..1).toSeq()
)
