# Build stage
FROM oven/bun:1-alpine AS builder

WORKDIR /app

COPY package.json bun.lock* ./
RUN bun install --frozen-lockfile

COPY tsconfig.json tsconfig.build.json ./
COPY src ./src
COPY convex ./convex

# (Opcional) Generar tipos de Convex (_generated) en CI.
# Solo se ejecuta si hay deployment Y un token de acceso configurado.
ARG CONVEX_DEPLOYMENT
ARG CONVEX_ACCESS_TOKEN
ENV CONVEX_DEPLOYMENT=${CONVEX_DEPLOYMENT}
ENV CONVEX_ACCESS_TOKEN=${CONVEX_ACCESS_TOKEN}
RUN sh -c 'if [ -n "$CONVEX_DEPLOYMENT" ] && [ -n "$CONVEX_ACCESS_TOKEN" ]; then \
  echo "Running convex codegen for $CONVEX_DEPLOYMENT"; \
  CONVEX_ACCESS_TOKEN="$CONVEX_ACCESS_TOKEN" bunx convex codegen; \
else \
  echo "Skipping convex codegen (no CONVEX_DEPLOYMENT or CONVEX_ACCESS_TOKEN)"; \
fi'

RUN bun run build

# Production stage
FROM oven/bun:1-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3001

COPY package.json bun.lock* ./
RUN bun install --frozen-lockfile --production

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/convex/_generated ./convex/_generated

EXPOSE 3001

CMD ["bun", "run", "start"]
