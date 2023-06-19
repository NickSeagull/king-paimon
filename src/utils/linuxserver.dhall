let Map = https://prelude.dhall-lang.org/Map/Type.dhall

let MapEntry = https://prelude.dhall-lang.org/Map/Entry.dhall

let Map/empty = https://prelude.dhall-lang.org/Map/empty.dhall

let List/map = https://prelude.dhall-lang.org/List/map.dhall

let List/filter = https://prelude.dhall-lang.org/List/filter.dhall

let List/empty = https://prelude.dhall-lang.org/List/empty.dhall

let Optional/fold = https://prelude.dhall-lang.org/Optional/fold.dhall

let Mapping = ./mapping.dhall

let EnvEntry = MapEntry Text Text

let Input =
      { name : Text
      , env : Map Text Text
      , ports : List Mapping
      , volumes : List Mapping
      , puid : Optional Natural
      , pgid : Optional Natural
      }

let combineEnv = \(e : EnvEntry) -> "${e.mapKey}=${e.mapValue}"

let combineMapping = \(m : Mapping) -> "${m.onHost}:${m.onGuest}"

in  \(input : Input) ->
      let envTexts = List/map EnvEntry Text combineEnv input.env

      let portTexts = List/map Mapping Text combineMapping input.ports

      let volumeTexts = List/map Mapping Text combineMapping input.volumes

      let puid = Optional/fold Natural input.puid Text Natural/show "1000"

      let pgid = Optional/fold Natural input.pgid Text Natural/show "1000"

      let defaultEnv = [ "PUID=${puid}", "PGID=${pgid}", "TZ=Atlantic/Canary" ]

      let environment = defaultEnv # envTexts

      in  { container_name = input.name
          , environment
          , image = "lscr.io/linuxserver/${input.name}:latest"
          , ports = portTexts
          , restart = "unless-stopped"
          , volumes = volumeTexts
          }
