let secrets = ./secrets.dhall

let linuxserver = ./utils/linuxserver.dhall

in  linuxserver
      { name = "code-server"
      , env = toMap
          { PASSWORD = secrets.code-server.password
          , SUDO_PASSWORD = secrets.code-server.sudoPassword
          , DEFAULT_WORKSPACE = "/data"
          }
      , ports = [ { onHost = "8443", onGuest = "8443" } ]
      , volumes =
        [ { onHost = "/home/nick/config/appdata/code-server"
          , onGuest = "/config"
          }
        , { onHost = "/home/nick/config", onGuest = "/root-config" }
        , { onHost = "/data/code-server", onGuest = "/data" }
        ]
      , puid = None Natural
      , pgid = None Natural
      }
