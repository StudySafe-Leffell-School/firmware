--backend:"cpp"
--path:"."

when not defined(debug):
  --cpu:arm
  --os:any
  --mm:orc
  --opt:speed
  --stacktrace:off
  --threads:off
  --d:useMalloc
  --d:noSignalHandler
  --noMain
  --compileOnly

when defined(release):
  --nimcache:"./build/release"
  --outdir:"./build/release"


elif defined(simulate):
  --nimcache:"./build/simulate"
  --outdir:"./build/simulate"

else:
  --nimcache:"./build/debug"
  --outdir:"./build/debug"
