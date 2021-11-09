FROM golang:1.16.10 as builder

COPY . /build
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -ldflags="-w -s" -o log-generator .


FROM scratch
COPY --from=builder /build/log-generator /log-generator
ENTRYPOINT ["/log-generator"]
