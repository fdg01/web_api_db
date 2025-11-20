# Multi-stage build for Web (React + Vite)

# Stage: Build
FROM node:20-alpine AS build

WORKDIR /app

ENV NODE_OPTIONS="--max-old-space-size=2048"

RUN apk add --no-cache python3 make g++

COPY package.json ./

RUN npm install --legacy-peer-deps && \
    npm cache clean --force

COPY . .

RUN npm run build && \
    rm -rf node_modules src public

# Stage: Production (Nginx)
FROM nginx:alpine AS production

COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /app/dist /usr/share/nginx/html

COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN mkdir -p /usr/share/nginx/html/config

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost/health || exit 1

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

# Stage: Development
FROM node:20-alpine AS development

WORKDIR /app

COPY package.json ./

RUN npm install --legacy-peer-deps

COPY . .

RUN chown -R node:node /app
USER node

EXPOSE 5173

ENV NODE_ENV=development

CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
