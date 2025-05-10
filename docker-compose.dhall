    { services =
      { duplicati = ./src/duplicati.dhall
      , ddclient = ./src/ddclient.dhall
      }
    , networks =
      { proxy = { name = "proxy" }
      }
    }
/\  ./src/auth/services.dhall
/\  ./src/home-automation/services.dhall
