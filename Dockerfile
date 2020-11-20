FROM elixir:1.11.2-alpine AS build

ADD . .

ENV MIX_ENV prod

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix do deps.get, deps.compile && \
    mix do compile && \
    mix release

FROM alpine:3.12.1 AS app

RUN apk add --no-cache \
    openssl \
    ca-certificates \
    bash

COPY --from=build _build .

ENV PORT 4000
EXPOSE 4000

CMD ["./prod/rel/app/bin/app", "start"]
