FROM rust:latest as build
ENV PKG_CONFIG_ALLOW_CROSS=1

COPY . .

RUN cargo install --path .

FROM debian:buster-slim

COPY --from=build /usr/local/cargo/bin/htmx-playground /usr/local/bin/htmx-playground
COPY --from=build src/static /usr/local/bin/src/static
EXPOSE 8080
WORKDIR /usr/local/bin
ENTRYPOINT ["htmx-playground"]
