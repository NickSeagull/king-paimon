{ container_name = "typesense"
, image = "typesense/typesense:26.0"
, restart = "on-failure"
, volumes = [ "./appdata/typesense:/data" ]
, ports = [ "8108:8108" ]
, command = "--data-dir /data --api-key=xyz --enable-cors"
}
