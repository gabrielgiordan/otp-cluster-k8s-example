FROM elixir:1.10-alpine

WORKDIR /app

ADD . /app

EXPOSE 4000
ENV PORT 4000
ENV MIX_ENV prod

RUN mix local.hex --force && \
	  mix local.rebar --force && \
    mix do deps.get, deps.compile && \
    mix do compile

CMD ["mix", "app.start"]
