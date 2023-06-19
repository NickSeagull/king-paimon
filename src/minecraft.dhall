{ command = "./startserver.sh"
, container_name = "minecraft"
, image = "openjdk:17"
, ports = [ "25565:25565" ]
, restart = "unless-stopped"
, volumes = [ "./minecraft/aqm2_server_files:/data" ]
, working_dir = "/data"
}
