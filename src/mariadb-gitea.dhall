let linuxserver = ./utils/linuxserver.dhall

let secrets = ./secrets.dhall

let s = secrets.mariadb-gitea

let Map/empty = https://prelude.dhall-lang.org/Map/empty.dhall

let c =
      linuxserver
        { name = "mariadb"
        , env = toMap
            { MYSQL_ROOT_PASSWORD = s.rootPassword
            , MYSQL_DATABASE = s.database
            , MYSQL_USER = s.user
            , MYSQL_PASSWORD = s.password
            }
        , ports = [] : List { onGuest : Text, onHost : Text }
        , volumes =
          [ { onHost = "/home/nick/config/appdata/mariadb-gitea"
            , onGuest = "/config"
            }
          , { onHost = "/home/nick/config/appdata/mariadb-gitea/data"
            , onGuest = "/data"
            }
          ]
        , puid = None Natural
        , pgid = None Natural
        }

in  c // { container_name = "mariadb-gitea", restart = "always" }
