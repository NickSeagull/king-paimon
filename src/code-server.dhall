let secrets = ./secrets.dhall
in
{ container_name = "code-server"
, environment =
  [ "PUID=1000"
  , "PGID=1000"
  , "TZ=Atlantic/Canary"
  , "PASSWORD=${secrets.code-server.password}"
  , "SUDO_PASSWORD=${secrets.code-server.sudoPassword}"
  , "DEFAULT_WORKSPACE=/data"
  ]
, image = "lscr.io/linuxserver/code-server:latest"
, ports = [ "8443:8443" ]
, restart = "unless-stopped"
, volumes =
  [ "/home/nick/config/code-server:/config"
  , "/home/nick/config:/root-config"
  , "/data/code-server:/data"
  ]
}
