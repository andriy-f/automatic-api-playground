FROM node:24-slim AS base

USER root

RUN npm uninstall -g pnpm \
	&& npm install -g corepack@latest

USER node

ENV MY_BIN_DIR=/home/node/bin
RUN mkdir -p $MY_BIN_DIR
ENV PATH=$PATH:$MY_BIN_DIR

RUN corepack enable --install-directory $MY_BIN_DIR pnpm \
	&& corepack install -g pnpm@latest-10

WORKDIR /home/node/app

FROM base AS build

COPY --chown=node:node pnpm-lock.yaml ./
RUN pnpm fetch

COPY --chown=node:node package.json ./
RUN corepack install
RUN pnpm install --offline
COPY --chown=node:node tsconfig.json ./
COPY --chown=node:node src ./src
RUN pnpm run build

ENV NODE_ENV=development
CMD ["node", "--watch", "./src/index.ts"]

FROM base AS production

COPY --chown=node:node pnpm-lock.yaml ./
COPY --chown=node:node package.json ./
# TODO use slimmer node_modules for production
COPY --chown=node:node --from=build /home/node/app/node_modules ./node_modules
COPY --chown=node:node --from=build /home/node/app/build ./build

ENV NODE_ENV=production
CMD ["node", "./build/index.js"]