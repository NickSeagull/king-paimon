let secrets = ./secrets.dhall

in  { container_name = "chatbot-ui"
    , image = "ghcr.io/mckaywrigley/chatbot-ui:main"
    , restart = "unless-stopped"
    , environment = [ "OPENAI_API_KEY=" ++ secrets.openai-api-key ]
    , ports = [ "8884:3000" ]
    }
