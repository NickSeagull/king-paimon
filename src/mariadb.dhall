let linuxserver = ./utils/linuxserver.dhall

let secrets = ./secrets.dhall

let Map/empty = https://prelude.dhall-lang.org/Map/empty.dhall

in  linuxserver
      { name = "mariadb"
      , env = toMap
          { MYSQL_ROOT_PASSWORD = secrets.mariadb.rootPassword
          , MYSQL_DATABASE = secrets.mariadb.database
          , MYSQL_USER = secrets.mariadb.user
          , MYSQL_PASSWORD = secrets.mariadb.password
          }
      , ports = [] : List { onGuest : Text, onHost : Text }
      , volumes =
        [ { onHost = "/home/nick/config/appdata/mariadb", onGuest = "/config" }
        , { onHost = "/data", onGuest = "/data" }
        ]
      , puid = None Natural
      , pgid = None Natural
      }
