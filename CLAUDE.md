# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository contains a self-hosted infrastructure configuration called "King Paimon" using Dhall configuration language to generate Docker Compose files. The system manages various services including authentication (Authentik), reverse proxy (Traefik), home automation (Home Assistant), gaming (Minecraft), and development tools (code-server).

## Commands

### Development Environment
- `nix-shell --command "dhall version"` - Check Dhall version
- `nix-shell --command "dhall repl"` - Interactive Dhall development

### Dhall Configuration
- `nix-shell --command "dhall-to-yaml --file docker-compose.dhall --output docker-compose.yml"` - Convert Dhall to YAML
- `nix-shell --command "dhall format --inplace src/**/*.dhall"` - Format all Dhall files
- `nix-shell --command "dhall lint --inplace src/**/*.dhall"` - Lint all Dhall files

### Docker Operations
- `docker-compose up -d` - Start all services
- `docker-compose down` - Stop all services
- `docker-compose logs -f [service]` - View logs for specific service
- `docker-compose pull` - Update all images
- `docker-compose build` - Build custom images

### Custom Image Building
- `cd images/[image-name] && ./build.sh` - Build custom Docker images
- Available custom images: `custom-n8n`, `mem-gpt`, `mem-gpt-psql`, `yhlygh`

## Architecture

### Configuration Structure
- **Root**: `docker-compose.dhall` - Main composition file that imports all services
- **Services**: `src/` - Individual service configurations in Dhall
- **Utilities**: `src/utils/` - Shared utilities and types
- **Authentication**: `src/auth/` - Authentik and Traefik configurations
- **Games**: `src/games/` - Gaming services (Minecraft)
- **Secrets**: `src/secrets-type.dhall` - Type definitions for secrets
- **Custom Images**: `images/` - Custom Docker image builds

### Key Patterns
1. **Dhall Modules**: Each service is a separate Dhall module that exports Docker Compose service definition
2. **Secrets Management**: All secrets are typed using `secrets-type.dhall` and imported via `secrets.dhall`
3. **LinuxServer.io Pattern**: Common pattern for services using LinuxServer.io images via `src/utils/linuxserver.dhall`
4. **Service Composition**: Services are composed using Dhall's `/\` operator for merging records
5. **Traefik Integration**: Most web services include Traefik labels for reverse proxy and SSL

### Service Categories
- **Authentication**: Authentik (OpenID Connect provider) with PostgreSQL and Redis
- **Reverse Proxy**: Traefik with Let's Encrypt SSL and Cloudflare DNS challenge
- **Home Automation**: Home Assistant, Zigbee2MQTT, Mosquitto MQTT, Node-RED
- **Development**: code-server, Gitea, Gitea Actions runner
- **Gaming**: Minecraft server with CurseForge mod support
- **Backup**: Duplicati
- **Networking**: Syncthing, Wireguard, ddclient

### Network Configuration
- All services use the `proxy` network for Traefik routing
- Some services (Home Assistant, Node-RED) use `network_mode: host` for hardware access
- Custom domains are configured via secrets for each service

### Volume Management
- Data volumes are mounted to `/data/volumes/[service-name]/`
- Configuration files are typically in `/data/volumes/[service-name]/config/`
- The project itself is backed up via Duplicati

## Development Notes

### Working with Dhall
- Use `nix-shell --command "..."` to run Dhall commands in development environment
- Dhall files are strongly typed - check `secrets-type.dhall` for available secrets
- Use `nix-shell --command "dhall repl"` for interactive development
- Import paths are relative to the importing file

### Adding New Services
1. Create new `.dhall` file in appropriate `src/` subdirectory
2. Follow existing patterns for service definition
3. Add secrets to `secrets-type.dhall` if needed
4. Import service in main `docker-compose.dhall`
5. Add Traefik labels for web services

### Secret Management
- Never commit actual secrets - only type definitions
- Secrets are imported from `src/secrets.dhall` (not in repository)
- Use environment variable interpolation for runtime secrets

### Custom Images
- Custom Dockerfiles are in `images/` directory
- Each has a `build.sh` script for building
- Images are typically based on upstream with custom modifications