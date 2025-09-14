#!/bin/bash
set -euo pipefail

# Set memory limits based on environment variable or use default
JVM_OPTS="-Xms${JAVA_MEMORY} -Xmx${JAVA_MEMORY}"

# Additional JVM options for better performance
JVM_OPTS="${JVM_OPTS} -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200"
JVM_OPTS="${JVM_OPTS} -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC"
JVM_OPTS="${JVM_OPTS} -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30"
JVM_OPTS="${JVM_OPTS} -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M"
JVM_OPTS="${JVM_OPTS} -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5"
JVM_OPTS="${JVM_OPTS} -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15"
JVM_OPTS="${JVM_OPTS} -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5"
JVM_OPTS="${JVM_OPTS} -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1"
JVM_OPTS="${JVM_OPTS} -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"

# Debug mode if enabled
if [ "${DEBUG:-false}" = "true" ]; then
  echo "Running in debug mode"
  set -x
fi

# Print server information
echo "Starting Minecraft server ${MINECRAFT_VERSION}"
echo "Using Java options: ${JVM_OPTS}"

# Run the server
exec java ${JVM_OPTS} -jar "${MINECRAFT_JAR}" nogui
