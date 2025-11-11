FROM node:24-slim 

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

COPY --chown=node:node pnpm-lock.yaml ./
RUN pnpm fetch

COPY --chown=node:node package.json ./
RUN pnpm install --offline
COPY --chown=node:node tsconfig.json ./
COPY --chown=node:node src ./src
RUN pnpm run build

CMD ["pnpm", "dlx", "postgraphile", "-P", "postgraphile/presets/amber", "-e", "-c", "$DATABASE_URL"]