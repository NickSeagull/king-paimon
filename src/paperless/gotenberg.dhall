{ container_name = "paperless-gotenberg"
, image = "docker.io/gotenberg/gotenberg:8.22"
, restart = "unless-stopped"
, command =
  [ "gotenberg"
  , "--chromium-disable-javascript=true"
  , "--chromium-allow-list=file:///tmp/.*"
  ]
, networks = [ "proxy" ]
}