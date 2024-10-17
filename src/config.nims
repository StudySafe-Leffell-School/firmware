--backend:"cpp"

when not defined(release):
  --nimcache:"./build/debug/nimcache"
  --outdir:"./build/debug"

else:
  --nimcache:"./build/release"
  --outdir:"./build/release"
  --cpu:esp
  --os:any
  --mm:orc
  --opt:speed
  --stacktrace:off
  --threads:off
  --d:useMalloc
  --d:noSignalHandler
  --noMain
  --compileOnly