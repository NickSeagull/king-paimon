  { code-server : { password : Text, sudoPassword : Text }
  , gitea-runner : { registrationToken : Text, instanceUrl : Text }
  , openai-api-key : Text
  , mariadb :
      { database : Text, user : Text, password : Text, rootPassword : Text }
  , mariadb-gitea :
      { database : Text, user : Text, password : Text, rootPassword : Text }
  , mongodb : { username : Text, password : Text }
  , memgpt-db : { password : Text }
  , memgpt : { openaiApiKey : Text }
  , rocketchat : { port : Text, host : Text }
  , traefik : { dashboardPort : Text }
  , nextcloud : { host : Text, domainName : Text }
  , dokuwiki : { host : Text, domainName : Text }
  , n8n : { webhookUrl : Text, host : Text, domainName : Text, sslEmail : Text }
  , actual-budget : { host : Text, domainName : Text, sslEmail : Text }
  }
: Type
