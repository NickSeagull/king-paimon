let secrets = ./secrets.dhall

let s = secrets.mariadb-gitea

in  { container_name = "gitea"
    , image = "gitea/gitea:latest"
    , restart = "unless-stopped"
    , volumes =
      [ "./appdata/gitea:/data"
      , "/etc/timezone:/etc/timezone:ro"
      , "/etc/localtime:/etc/localtime:ro"
      ]
    , ports = [ "3000:3000", "222:22" ]
    , depends_on = [ "mariadb-gitea" ]
    , environment =
      [ "TZ=Atlantic/Canary"
      , "USER_UID=1000"
      , "USER_GID=1000"
      , "GITEA__database__DB_TYPE=mysql"
      , "GITEA__database__HOST=mariadb-gitea"
      , "GITEA__database__NAME=" ++ s.database
      , "GITEA__database__USER=" ++ s.user
      , "GITEA__database__PASSWD=" ++ s.password
      ]
    }
