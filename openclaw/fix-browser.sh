#!/bin/bash
# Remove browser upstream and location blocks from nginx config
# so openclaw can start without a browser sidecar container.
CONF="/etc/nginx/conf.d/openclaw.conf"
if [ -f "$CONF" ]; then
  # Remove upstream browser { ... } block
  sed -i '/upstream.*browser\s*{/,/}/d' "$CONF"
  # Remove location /browser { ... } blocks (including nested braces)
  # Use perl for nested brace handling since sed struggles with it
  perl -0777 -i -pe 's/\s*location\s+[~]*\s*\/browser[^\{]*\{[^}]*(\{[^}]*\}[^}]*)*\}//gs' "$CONF" 2>/dev/null || \
    sed -i '/location.*\/browser/,/}/d' "$CONF"
fi