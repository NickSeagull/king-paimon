let secrets = ../secrets.dhall

in  { container_name = "necesse-server"
    , image = "brammys/necesse-server"
    , environment =
      [ "MOTD=${secrets.necesse.motd}"
      , "PASSWORD=${secrets.necesse.password}"
      , "SLOTS=${secrets.necesse.slots}"
      , "PAUSE=${secrets.necesse.pause}"
      ]
    , ports = [ "14159:14159/udp" ]
    , restart = "always"
    , volumes =
      [ "/data/volumes/necesse/saves:/necesse/saves"
      , "/data/volumes/necesse/logs:/necesse/logs"
      ]
    }
