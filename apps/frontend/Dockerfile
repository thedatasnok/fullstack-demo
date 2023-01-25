FROM node:alpine AS builder

WORKDIR /app

RUN npm install -g pnpm

COPY package.json ./
COPY pnpm-lock.yaml ./

RUN pnpm install

COPY src ./src
COPY public ./public
COPY index.html index.html
COPY tsconfig* ./

RUN pnpm build

FROM nginx:alpine AS production

COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

LABEL org.opencontainers.image.source="https://github.com/thedatasnok/fullstack-demo"
LABEL org.opencontainers.image.description="Demonstration frontend"
LABEL org.opencontainers.image.licenses="MIT"
