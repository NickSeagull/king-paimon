{ services =
  { code-server = ./src/code-server.dhall
  , duplicati =
    { container_name = "duplicati"
    , environment = [ "PUID=0", "PGID=0", "TZ=Atlantic/Canary" ]
    , image = "lscr.io/linuxserver/duplicati:latest"
    , ports = [ "8200:8200" ]
    , restart = "unless-stopped"
    , volumes =
      [ "/home/nick/config/duplicati:/config"
      , "/home/nick/config:/source"
      , "/data:/data"
      ]
    }
  , minecraft =
    { command = "./startserver.sh"
    , container_name = "minecraft"
    , image = "openjdk:17"
    , ports = [ "25565:25565" ]
    , restart = "unless-stopped"
    , volumes = [ "./minecraft/aqm2_server_files:/data" ]
    , working_dir = "/data"
    }
  }
, version = "2.1"
}
