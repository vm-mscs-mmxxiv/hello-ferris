# Use official Rust image to build the binary
FROM rust:1.75 as builder

WORKDIR /usr/src/rust_action
COPY . .

# Build the release binary
RUN cargo build --release

# Use a minimal image to run the binary
FROM debian:bullseye-slim
COPY --from=builder /usr/src/rust_action/target/release/hello-ferris /usr/local/bin/hello-ferris

ENTRYPOINT ["/usr/local/bin/hello-ferris"]

