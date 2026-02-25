FROM coollabsio/openclaw:latest

# Add process tools so we can ps/kill without losing the container
RUN apt-get update && apt-get install -y --no-install-recommends procps && \
    rm -rf /var/lib/apt/lists/*

# Init script that adds "browser" to /etc/hosts before nginx starts.
# The entrypoint runs: 1) init script, 2) configure.js, 3) nginx, 4) gateway
# So this runs early enough to make the hostname resolve for nginx.
RUN mkdir -p /opt/openclaw-init && \
    printf '#!/bin/bash\necho "127.0.0.1 browser" >> /etc/hosts\n' > /opt/openclaw-init/fix-browser.sh && \
    chmod +x /opt/openclaw-init/fix-browser.sh

# Install custom gateway config outside /data (which is a volume mount)
COPY custom-openclaw.json /opt/openclaw-init/custom-openclaw.json