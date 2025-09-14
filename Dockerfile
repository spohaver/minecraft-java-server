FROM eclipse-temurin:17-jre

LABEL maintainer="GitHub Copilot"

# Environment variables
ENV MINECRAFT_VERSION=1.21.8
ENV MINECRAFT_JAR=minecraft_server.${MINECRAFT_VERSION}.jar
ENV MINECRAFT_URL=https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar
ENV MINECRAFT_HOME=/data
ENV JAVA_MEMORY=1G

# Install necessary tools
RUN apt-get update && \
    apt-get install -y curl wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create user and group for running Minecraft
RUN groupadd -r minecraft && \
    useradd -r -g minecraft -d ${MINECRAFT_HOME} -s /bin/bash minecraft && \
    mkdir -p ${MINECRAFT_HOME} && \
    chown -R minecraft:minecraft ${MINECRAFT_HOME}

WORKDIR ${MINECRAFT_HOME}

# Download the Minecraft server jar
RUN wget -O ${MINECRAFT_JAR} ${MINECRAFT_URL}

# Accept EULA
RUN echo "eula=true" > eula.txt

# Copy server properties and entry script
COPY server.properties .
COPY start-minecraft.sh .

# Ensure proper permissions
RUN chmod +x start-minecraft.sh && \
    chown -R minecraft:minecraft ${MINECRAFT_HOME}

# Expose Minecraft port
EXPOSE 25565

# Switch to the minecraft user
USER minecraft

# Set the volume for data persistence
VOLUME ["${MINECRAFT_HOME}"]

# Start the server
CMD ["./start-minecraft.sh"]
