let secrets = ../secrets.dhall

let minecraft = ./minecraft.dhall

in  { container_name = "mc-router"
    , image = "itzg/mc-router"
    , restart = "unless-stopped"
    , depends_on = [ minecraft.container_name ]
    , environment = {
        MAPPING =
          "${secrets.minecraft.host}=${minecraft.container_name}:25565"
      }
    , ports = [ "25565:25565", "25575:25575" ]
    , networks = [ "proxy" ]
    , labels = [
        "traefik.enable=true"
      , "traefik.http.routers.mc-router.rule=Host(`${secrets.minecraft.host}`)"
      , "traefik.http.routers.mc-router.entrypoints=websecure"
      , "traefik.http.routers.mc-router.tls.certresolver=letsencrypt"
      , "traefik.http.services.mc-router.loadbalancer.server.port=25565"
      ]
    , volumes = [ "/var/run/docker.sock:/var/run/docker.sock:ro" ]
    , command = [ "-debug", "-in-docker" ]
    }
