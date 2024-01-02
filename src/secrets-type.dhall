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
  , n8n : { webhookUrl : Text }
  }
: Type
