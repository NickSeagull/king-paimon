{ container_name = "yhlygh"
, image = "yhlygh:latest"
, restart = "unless-stopped"
, volumes =
  [ "/home/nick/config/yhlygh-mind:/app"
  , "/mnt/nextcloud/1 Projects/YhLygh:/yhlygh"
  ]
, environment = { PUID = "1000", PGID = "1000" }
}
