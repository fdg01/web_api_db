# Multi-stage build for API
FROM node:20-alpine AS base

ENV NODE_OPTIONS="--max-old-space-size=1024"

RUN apk add --no-cache netcat-openbsd && \
    rm -rf /var/cache/apk/*

WORKDIR /app

# Stage: Dependencies
FROM base AS dependencies

COPY package.json ./
RUN npm install --omit=dev --legacy-peer-deps && \
    npm cache clean --force && \
    find node_modules -type f -name '*.md' -delete && \
    find node_modules -type f -name 'LICENSE*' -delete && \
    find node_modules -type d -name 'test' -exec rm -rf {} + 2>/dev/null || true

# Stage: Production
FROM base AS production

COPY --from=dependencies /app/node_modules ./node_modules
COPY . .

COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN mkdir -p uploads logs && \
    chmod 755 uploads logs && \
    chown -R node:node /app

USER node

EXPOSE 4000

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD node -e "require('http').get('http://localhost:4000/health', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})"

ENV NODE_ENV=production \
    PORT=4000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["node", "src/server.js"]

# Stage: Development
FROM base AS development

COPY package.json ./
RUN npm install --legacy-peer-deps && \
    npm cache clean --force

COPY . .

RUN mkdir -p uploads logs

USER node

EXPOSE 4000

ENV NODE_ENV=development \
    PORT=4000

CMD ["npm", "run", "dev"]
