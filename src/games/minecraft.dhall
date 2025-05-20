let secrets = ../secrets.dhall

in  {
, container_name = "minecraft"
, image = "itzg/minecraft-server:java21"
, environment = [
    "EULA=TRUE"
  , "TYPE=AUTO_CURSEFORGE"
  , "DEBUG=TRUE"
  , "CF_API_KEY=${secrets.minecraft.cfApiKey}"
  , "CF_PAGE_URL=https://www.curseforge.com/minecraft/modpacks/prominence-2-rpg"
  , "CF_FILENAME_MATCHER=3.1.11"
  , "CF_FORCE_INCLUDE_MODS=modmenu,luna,fancymenu"
  -- , "CF_FORCE_SYNCHRONIZE=true"
  , "FABRIC_LOADER_VERSION=0.16.5"
  , "VERSION=1.20.1"
  , "DIFFICULTY=normal"
  , "DISABLE_HEALTHCHECK=true"
  , "MEMORY=24G"
  , "INIT_MEMORY=24G"
  , "JVM_XX_OPTS=-XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:SurvivorRatio=32 -XX:MaxTenuringThreshold=1 -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UseCompressedOops -XX:+OptimizeStringConcat -XX:-UseAdaptiveSizePolicy -XX:G1HeapWastePercent=5 -XX:+UseStringDeduplication -Dusing.aikars.flags=https://mcflags.emc.gs"
  , "MAX_TICK_TIME=-1"
  , "VIEW_DISTANCE=8"
  , "SIMULATION_DISTANCE=6"
  , "SPAWN_PROTECTION=0"
  , "ENABLE_JMX=true"
  , "ENABLE_RCON=true"
  , "ALLOW_FLIGHT=true"
  , "MAX_WORLD_SIZE=15000"
  , "ENTITY_BROADCAST_RANGE_PERCENTAGE=75"
  , "NETWORK_COMPRESSION_THRESHOLD=256"
  , "USE_NATIVE_TRANSPORT=true"
  , "SYNC_CHUNK_WRITES=false"
  , "RCON_PASSWORD=${secrets.minecraft.rconPassword}"
  , "WHITELIST=${secrets.minecraft.whitelist}"
  ]
, ports = [ "25565:25565", "25575:25575" ]
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
