VERSION 0.7

setup:
    ARG ELIXIR_VERSION=1.16.2
    ARG OTP_VERSION=26.2.3
    ARG ALPINE_VERSION=3.19.1

    FROM hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-alpine-${ALPINE_VERSION}

    RUN apk update \
        && apk upgrade \
        && apk add build-base git

    WORKDIR /app

    RUN mix local.hex --force && \
        mix local.rebar --force

build:
    ARG MIX_ENV=prod
    FROM +setup
    ENV MIX_ENV=${MIX_ENV}

    COPY mix.exs mix.lock ./
    COPY lib lib
    COPY test test
    
    RUN mix deps.get
    RUN mkdir config

    COPY config/config.exs config/${MIX_ENV}.exs config/
    RUN mix deps.compile

    COPY assets assets
    RUN mix assets.deploy

    RUN mix compile

    COPY config/runtime.exs config/
    COPY priv/repo/migrations priv/repo/migrations

credo:
    FROM +build --MIX_ENV=test
    COPY .credo.exs .credo.exs
    RUN mix credo

format:
    FROM +build --MIX_ENV=test
    COPY .formatter.exs .formatter.exs
    RUN mix format --check-formatted

test:
    FROM +build --MIX_ENV=test
    RUN apk add --no-progress --update docker docker-compose postgresql-client
    COPY docker-compose.yaml docker-compose.yaml
    WITH DOCKER
        RUN docker-compose up -d & \
            mix deps.compile && \
            while ! pg_isready --host=localhost --port=5432 --quiet; do sleep 1; done; \
            mix test
    END

release:
    FROM +build
    COPY rel rel
    RUN mix release
    SAVE ARTIFACT _build/${MIX_ENV}

image:
    ARG VERSION
    ARG MIX_ENV=prod
    ARG ALPINE_VERSION=3.19.1
    FROM alpine:${ALPINE_VERSION}

    RUN apk update \
        && apk upgrade \
        && apk add libstdc++ openssl ncurses tzdata

    RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

    ENV TZ America/Sao_Paulo
    ENV LANG pt_BR.UTF-8
    ENV LANGUAGE pt_BR.UTF-8
    ENV LC_ALL pt_BR.UTF-8

    WORKDIR "/app"
    RUN chown nobody /app

    ENV MIX_ENV=${MIX_ENV}

    COPY +release/${MIX_ENV}/rel/our_expenses ./
    COPY priv/repo/migrations priv/repo/migrations

    USER nobody

    CMD ["/app/bin/server"]
    SAVE IMAGE --push registry.fly.io/our-expenses:latest registry.fly.io/our-expenses:${VERSION}
