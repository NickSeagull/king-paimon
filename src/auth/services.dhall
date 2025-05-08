{ services =
  { authelia = ./authelia.dhall
  }
  , networks = { net = { external = True, name = "net", driver = "bridge" } }
} /\ ./traefik/services.dhall
