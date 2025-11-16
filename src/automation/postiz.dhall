let secrets = ../secrets.dhall

in  { container_name = "postiz"
    , image = "ghcr.io/gitroomhq/postiz-app:latest"
    , restart = "unless-stopped"
    , depends_on = [ "postiz-postgres", "postiz-redis" ]
    , ports = [ "127.0.0.1:5000:5000" ]
    , networks = [ "proxy" ]
    , volumes =
      [ "/data/volumes/postiz/config:/config/"
      , "/data/volumes/postiz/uploads:/uploads/"
      ]
    , environment =
      [ "DATABASE_URL=postgresql://${secrets.postiz.pgUser}:${secrets.postiz.pgPassword}@postiz-postgres:5432/${secrets.postiz.pgDb}"
      , "REDIS_URL=redis://postiz-redis:6379"
      , "BACKEND_INTERNAL_URL=http://localhost:3000"
      , "FRONTEND_URL=https://${secrets.postiz.host}.${secrets.postiz.domainName}"
      , "NEXT_PUBLIC_BACKEND_URL=https://${secrets.postiz.host}.${secrets.postiz.domainName}/api"
      , "JWT_SECRET=${secrets.postiz.jwtSecret}"
      , "MAIN_URL=https://${secrets.postiz.host}.${secrets.postiz.domainName}"
      , "IS_GENERAL=true"
      , "DISABLE_REGISTRATION=false"
      -- Storage Settings
      , "STORAGE_PROVIDER=cloudflare"
      , "UPLOAD_DIRECTORY=/uploads"
      , "NEXT_PUBLIC_UPLOAD_DIRECTORY=/uploads"
      , "CLOUDFLARE_ACCOUNT_ID=${secrets.postiz.cloudflareAccountId}"
      , "CLOUDFLARE_ACCESS_KEY=${secrets.postiz.cloudflareAccessKey}"
      , "CLOUDFLARE_SECRET_ACCESS_KEY=${secrets.postiz.cloudflareSecretAccessKey}"
      , "CLOUDFLARE_BUCKETNAME=${secrets.postiz.cloudflareBucketname}"
      , "CLOUDFLARE_BUCKET_URL=${secrets.postiz.cloudflareBucketUrl}"
      , "CLOUDFLARE_REGION=weur"
      -- Authentik OAuth Integration
      , "NEXT_PUBLIC_POSTIZ_OAUTH_DISPLAY_NAME=Authentik"
      , "NEXT_PUBLIC_POSTIZ_OAUTH_LOGO_URL=https://raw.githubusercontent.com/walkxcode/dashboard-icons/master/png/authentik.png"
      , "POSTIZ_GENERIC_OAUTH=true"
      , "POSTIZ_OAUTH_URL=https://${secrets.authentik.domain}"
      , "POSTIZ_OAUTH_AUTH_URL=https://${secrets.authentik.domain}/application/o/authorize/"
      , "POSTIZ_OAUTH_TOKEN_URL=https://${secrets.authentik.domain}/application/o/token/"
      , "POSTIZ_OAUTH_USERINFO_URL=https://${secrets.authentik.domain}/application/o/userinfo/"
      , "POSTIZ_OAUTH_CLIENT_ID=${secrets.postiz.oauthClientId}"
      , "POSTIZ_OAUTH_CLIENT_SECRET=${secrets.postiz.oauthClientSecret}"
      -- LinkedIn
      , "LINKEDIN_CLIENT_ID=${secrets.postiz.linkedinClientId}"
      , "LINKEDIN_CLIENT_SECRET=${secrets.postiz.linkedinClientSecret}"
      -- Misc Settings
      , "API_LIMIT=30"
      , "NX_ADD_PLUGINS=false"
      ]
    , labels =
      [ "traefik.enable=true"
      , "traefik.http.routers.postiz.rule=Host(`${secrets.postiz.host}.${secrets.postiz.domainName}`)"
      , "traefik.http.routers.postiz.entrypoints=websecure"
      , "traefik.http.routers.postiz.tls.certresolver=letsencrypt"
      , "traefik.http.services.postiz.loadbalancer.server.port=5000"
      , "traefik.http.routers.postiz.service=postiz"
      ]
    }
