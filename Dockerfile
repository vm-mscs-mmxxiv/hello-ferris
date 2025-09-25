# Use official Rust image to build the binary
FROM rust:1.90.0-slim-trixie AS builder

WORKDIR /usr/src/rust_action
COPY . .

# Build the release binary
RUN cargo build --release

# Use a minimal image to run the binary
FROM debian:trixie-slim
RUN apt-get update && apt-get upgrade -y

COPY --from=builder /usr/src/rust_action/target/release/hello-ferris /usr/local/bin/hello-ferris

ENTRYPOINT ["/usr/local/bin/hello-ferris"]

