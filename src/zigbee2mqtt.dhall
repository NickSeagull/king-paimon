let secrets = ./secrets.dhall

in      { container_name = "zigbee2mqtt"
        , image = "koenkk/zigbee2mqtt"
        , restart = "unless-stopped"
        , volumes =
          [ "/data/volumes/zigbee2mqtt:/app/data", 
          "/run/udev:/run/udev:ro" ]
        , ports = [ "8999:8080" ]
        , environment = [ 
          "TZ=Atlantic/Canary",
          "PUID=1000",
          "PGID=1000" 
          ]
        , devices =
          [ "/dev/serial/by-id/usb-Silicon_Labs_slae.sh_cc2652rb_stick_-_slaesh_s_iot_stuff_00_12_4B_00_25_9B_BA_72-if00-port0:/dev/ttyACM0"
          ]
        }
    /\  { depends_on = [ "mosquitto" ] }
