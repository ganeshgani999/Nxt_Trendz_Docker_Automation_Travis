# Stage 1: Builder
FROM node:alpine AS builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

# Set NODE_OPTIONS to allow legacy OpenSSL provider during the build
RUN export NODE_OPTIONS=--openssl-legacy-provider && npm run build


# Stage 2: Runner
FROM nginx AS runner

COPY --from=builder /app/build /usr/share/nginx/html