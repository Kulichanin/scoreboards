FROM gcr.io/gcp-runtimes/go1-builder:1.9 as builder

WORKDIR /go/src/app
COPY main.go .
COPY cmd .

RUN /usr/local/go/bin/go build -o scoreboards .

# Application image.
FROM gcr.io/distroless/base:latest

COPY --from=builder /go/src/app/scoreboards /usr/local/bin/scoreboards

CMD ["/usr/local/bin/scoreboards"]