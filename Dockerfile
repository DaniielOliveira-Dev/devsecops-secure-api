
# Estagio 1 - Instalacao das dependencias
FROM node:24-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev

# Estagio 2 - Ambiente de execucao
FROM node:24-alpine AS runtime

WORKDIR /app

ENV NODE_ENV=production

# Remover ferramentas desnecessarias em runtime
RUN rm -rf /usr/local/lib/node_modules \
    /opt/yarn* \
    /usr/local/bin/npm \
    /usr/local/bin/npx \
    /usr/local/bin/yarn \
    /usr/local/bin/yarnpkg \
    /usr/local/bin/corepack

# Copiar apenas os arquivos necessarios
COPY --from=builder --chown=node:node /app/node_modules ./node_modules
COPY --chown=node:node package*.json ./
COPY --chown=node:node src ./src

# Executar com usuario sem privilegios
USER node

EXPOSE 3000

HEALTHCHECK --interval=10s --timeout=3s CMD node -e "fetch('http://127.0.0.1:3000/health').then(r=>{if(!r.ok)process.exit(1)}).catch(()=>process.exit(1))"

CMD ["node", "src/app.js"]
