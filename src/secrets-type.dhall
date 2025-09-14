  { code-server : { password : Text, sudoPassword : Text, host : Text, domainName : Text }
  , duplicati : { encryptionKey : Text, password : Text }
  , gitea-runner : { registrationToken : Text, instanceUrl : Text }
  , openai-api-key : Text
  , mariadb :
      { database : Text, user : Text, password : Text, rootPassword : Text }
  , mariadb-gitea :
      { database : Text, user : Text, password : Text, rootPassword : Text }
  , authentik :
      { pgUser : Text
      , pgPassword : Text
      , pgDb : Text
      , secretKey : Text
      , domain : Text
      }
  , mongodb : { username : Text, password : Text }
  , memgpt-db : { password : Text }
  , memgpt : { openaiApiKey : Text }
  , rocketchat : { port : Text, host : Text }
  , cloudflare : { apiEmail : Text, apiKey : Text }
  , traefik :
      { dashboardPort : Text
      , sslEmail : Text
      , publicHost : Text
      , secureHost : Text
      }
  , nextcloud : { host : Text, domainName : Text }
  , syncthing : { host : Text, domainName : Text }
  , dokuwiki : { host : Text, domainName : Text }
  , n8n : { webhookUrl : Text, host : Text, domainName : Text, sslEmail : Text }
  , actual-budget : { host : Text, domainName : Text, sslEmail : Text }
  , minecraft : { host : Text, rconPassword : Text, cfApiKey : Text, whitelist : Text, ops : Text }
  , paperless :
      { pgUser : Text
      , pgPassword : Text
      , pgDb : Text
      , secretKey : Text
      , adminUser : Text
      , adminPassword : Text
      , host : Text
      , hostAI : Text
      , domainName : Text
      }
  }
: Type
