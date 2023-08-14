let secrets = ./secrets.dhall

let s = secrets.gitea-runner

in  { container_name = "gitea-act-runner"
    , image = "gitea/act_runner:latest"
    , restart = "always"
    , volumes =
      [ "/var/run/docker.sock:/var/run/docker.sock"
      , "./gitea-act-runner:/data"
      ]
    , depends_on = [ "gitea" ]
    , environment =
      [ "GITEA_INSTANCE_URL=" ++ s.instanceUrl
      , "GITEA_RUNNER_REGISTRATION_TOKEN=" ++ s.registrationToken
      ]
    }
