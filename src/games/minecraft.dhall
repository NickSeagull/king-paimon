let secrets = ../secrets.dhall

in  {
, container_name = "minecraft"
, image = "itzg/minecraft-server"
, environment = [
    "EULA=TRUE"
  , "TYPE=PAPER"
  , "DEBUG=TRUE"
  -- , "CF_API_KEY=${secrets.minecraft.cfApiKey}"
  --, "CF_PAGE_URL=https://www.curseforge.com/minecraft/modpacks/prominence-2-rpg"
  --, "CF_FILENAME_MATCHER=3.1.50"
  -- , "CF_PAGE_URL=https://www.curseforge.com/minecraft/modpacks/meatballcraft"
  -- , "CF_EXCLUDE_MODS=292899,254144"
  --, "CF_FORCE_INCLUDE_MODS=modmenu,luna,fancymenu,dynmapforge"
  -- , "CF_FORCE_SYNCHRONIZE=true"
  , "VERSION=1.21.9"
  -- , "FORGEVERSION=14.23.5.2860"
  , "DIFFICULTY=normal"
  , "DISABLE_HEALTHCHECK=true"
  , "MAX_MEMORY=24G"
  , "INIT_MEMORY=4G"
  , "OPS=${secrets.minecraft.ops}"
  -- , "JVM_XX_OPTS=-XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:SurvivorRatio=32 -XX:MaxTenuringThreshold=1 -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UseCompressedOops -XX:+OptimizeStringConcat -XX:-UseAdaptiveSizePolicy -XX:G1HeapWastePercent=5 -XX:+UseStringDeduplication -Dusing.aikars.flags=https://mcflags.emc.gs"
  -- , "GENERIC_PACK_STRIP_DIRS=1"
--  , "JVM_OPTS=-server -XX:+AggressiveOpts -XX:ParallelGCThreads=3 -XX:+UseConcMarkSweepGC -XX:+UnlockExperimentalVMOptions -XX:+UseParNewGC -XX:+ExplicitGCInvokesConcurrent -XX:MaxGCPauseMillis=10 -XX:GCPauseIntervalMillis=50 -XX:+UseFastAccessorMethods -XX:+OptimizeStringConcat -XX:NewSize=84m -XX:+UseAdaptiveGCBoundary -XX:NewRatio=3 -Dfml.readTimeout=90 -Dfml.queryResult=confirm"
  -- , "JVM_XX_OPTS=-XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions -XX:+AlwaysActAsServerClassMachine -XX:+AlwaysPreTouch -XX:+AggressiveOpts -XX:MaxInlineLevel=15 -XX:MaxVectorSize=32 -XX:+UseCompressedOops -XX:ThreadPriorityPolicy=1 -XX:AllocatePrefetchStyle=3 -XX:+UseNUMA -XX:NmethodSweepActivity=1 -XX:ReservedCodeCacheSize=300M -XX:-DontCompileHugeMethods -XX:MaxNodeLimit=240000 -XX:NodeLimitFudgeFactor=8000 -XX:+UseFPUForSpilling -XX:+UseStringDeduplication -XX:+UseG1GC -XX:MaxGCPauseMillis=37 -XX:G1HeapRegionSize=32M -XX:G1NewSizePercent=23 -XX:G1MaxNewSizePercent=40 -XX:G1ReservePercent=20 -XX:SurvivorRatio=16 -XX:G1MixedGCCountTarget=3 -XX:G1MixedGCLiveThresholdPercent=90 -XX:InitiatingHeapOccupancyPercent=10 -XX:MaxTenuringThreshold=2 -XX:G1RSetUpdatingPauseTimePercent=0 -XX:G1SATBBufferEnqueueingThresholdPercent=30 -XX:G1ConcMarkStepDurationMillis=5.0 -XX:G1ConcRSHotCardLimit=16 -XX:G1ConcRefinementServiceIntervalMillis=150 -XX:GCTimeRatio=99 -XX:+ExplicitGCInvokesConcurrent"
  , "LEVEL=golems-cobre"
  , "MAX_TICK_TIME=-1"
  , "VIEW_DISTANCE=8"
  , "SIMULATION_DISTANCE=6"
  , "SPAWN_PROTECTION=0"
  , "ENABLE_JMX=true"
  , "ENABLE_RCON=true"
  , "ALLOW_FLIGHT=true"
  , "MAX_WORLD_SIZE=15000"
  , "ENTITY_BROADCAST_RANGE_PERCENTAGE=75"
  , "PLAYER_SLEEPING_PERCENTAGE=50"
  , "NETWORK_COMPRESSION_THRESHOLD=256"
  , "USE_NATIVE_TRANSPORT=true"
  , "SYNC_CHUNK_WRITES=false"
  , "RCON_PASSWORD=${secrets.minecraft.rconPassword}"
  , "WHITELIST=${secrets.minecraft.whitelist}"
  , "MODRINTH_PROJECTS=veinminer,magnetic,gravelootz,waypoints,bluemap"
  -- , "SPIGET_RESOURCES=18083,12083,274,74208,59773"
  ]
, ports = [ "25565:25565", "25575:25575", "8100:8100" ]
, restart = "unless-stopped"
, volumes = [ "/data/volumes/minecraft/data:/data", "/data/volumes/minecraft/mods:/data/mods" ]
, deploy = {
    resources = {
      limits = {
        cpus = "5.5"
      , memory = "26G"
      }
    , reservations = {
        cpus = "4.0"
      , memory = "24G"
      }
    }
  }
, ulimits = {
    nofile = {
      soft = 65535
    , hard = 65535
    }
  }
}
