# Docker Minecraft Server

A simple, containerized Minecraft server setup using Docker and Docker Compose.

## Features

- Easy to set up and configure
- Data persistence through Docker volumes
- Configurable memory allocation
- Optimized JVM settings for better performance
- Supports vanilla Minecraft server

## Requirements

- Docker
- Docker Compose

## Quick Start

1. Clone this repository
2. Navigate to the project directory
3. Start the server:

```bash
docker-compose up -d
```

4. Check the logs:

```bash
docker-compose logs -f
```

5. Stop the server:

```bash
docker-compose down
```

## Configuration

### Server Properties

Edit the `server.properties` file to configure your Minecraft server settings.

### Docker Compose Settings

Edit the `docker-compose.yml` file to adjust:

- Memory allocation (`JAVA_MEMORY`)
- Port forwarding
- Restart policy
- Debug mode

### Minecraft Version

To change the Minecraft version, edit the `Dockerfile` and update these environment variables:
- `MINECRAFT_VERSION`
- `MINECRAFT_URL` (get this from the Minecraft official website)

## Data Persistence

All server data is stored in a Docker volume named `minecraft-data`. This ensures your world data, player information, and server configurations persist between container restarts.

## Customization

### Adding Mods or Plugins

To add mods or plugins, you'll need to:

1. Create a directory for them in your project
2. Add a volume mapping in `docker-compose.yml`
3. Modify the Dockerfile to use an appropriate server jar (like Paper, Spigot, or Forge)

### Custom Server JAR

To use a different server implementation:

1. Modify the Dockerfile to download your preferred server JAR
2. Adjust the startup script if necessary

## Troubleshooting

### Server won't start

Check the logs with:

```bash
docker-compose logs -f minecraft
```

### Performance issues

- Increase the allocated memory in `docker-compose.yml`
- Check CPU usage with `docker stats`

## License

This project is open source and available under the MIT License.
