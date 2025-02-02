let secrets = ./secrets.dhall

in  { container_name = "portainer"
    , image = "portainer/portainer-ce"
    , ports = [ "9000:9000" ]
    , restart = "always"
    , environment.TZ = "Atlantic/Canary"
    , volumes =
      [ "./appdata/portainer:/data"
      , "/var/run/docker.sock:/var/run/docker.sock"
      ]
    , working_dir = "/data"
    }
