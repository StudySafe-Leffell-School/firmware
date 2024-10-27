--backend:"cpp"
--path:"."
--mm:orc

when not defined(host):
  --cpu:arm
  --os:any
  --opt:speed
  --stacktrace:off
  --threads:off
  --d:useMalloc
  --d:noSignalHandler
  --noMain
  --compileOnly

  when defined(debug):
    --nimcache:"../build/debug"
    --outdir:"./build/debug"

  else:
    --nimcache:"../build/release"
    --outdir:"./build/release"

else:
  --nimcache:"../build/host"
  --outdir:"./build/host"
