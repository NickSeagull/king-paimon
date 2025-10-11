let secrets = ../secrets.dhall

in  {
, container_name = "minecraft"
, image = "itzg/minecraft-server"
, environment = [
    "EULA=TRUE"
  , "TYPE=NEOFORGE"
  , "DEBUG=TRUE"
  , "JAVA_VERSION=jdk-21.0.4+7"
  , "MODPACK_PLATFORM=AUTO_CURSEFORGE"
  , "CF_API_KEY=${secrets.minecraft.cfApiKey}"
  , "CF_SLUG=better-mc-neoforge-bmc5"
  , "VERSION=1.21.1"
  , "DIFFICULTY=normal"
  , "DISABLE_HEALTHCHECK=true"
  , "MAX_MEMORY=24G"
  , "INIT_MEMORY=4G"
  , "OPS=${secrets.minecraft.ops}"
  , "LEVEL=bettermc-5"
  , "MAX_TICK_TIME=-1"
  , "VIEW_DISTANCE=12"
  , "SIMULATION_DISTANCE=10"
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
  ]
, ports = [ "25565:25565", "25575:25575"]
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
