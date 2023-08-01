let linuxserver = ./utils/linuxserver.dhall

let Map/empty = https://prelude.dhall-lang.org/Map/empty.dhall

let Text/concatSep = https://prelude.dhall-lang.org/Text/concatSep.dhall

let entryPort = "51820"

let peers =
      [ "booxtablet"
      , "movilgati"
      , "movilosi"
      , "ipadosi"
      , "macbookosi"
      , "macbookgati"
      ]

in      linuxserver
          { name = "wireguard"
          , env = toMap
              { SERVERURL = "qliphoth.nickseagull.dev"
              , SERVERPORT = entryPort
              , PEERS = Text/concatSep "," peers
              }
          , ports = [ { onHost = entryPort, onGuest = entryPort ++ "/udp" } ]
          , volumes =
            [ { onHost = "/home/nick/config/wireguard", onGuest = "/config" }
            , { onHost = "/lib/modules", onGuest = "/lib/modules" }
            ]
          , puid = None Natural
          , pgid = None Natural
          }
    /\  { cap_add = [ "NET_ADMIN", "SYS_MODULE" ]
        , sysctls.`net.ipv4.conf.all.src_valid_mark` = 1
        , networks = [ "wireguard" ]
        }
