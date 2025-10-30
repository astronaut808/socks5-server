ARG GOLANG_VERSION="1.25"

FROM golang:$GOLANG_VERSION-alpine as builder
RUN apk --no-cache add tzdata
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-s' -o ./socks5

FROM gcr.io/distroless/static:nonroot
COPY --from=builder /app /
ENTRYPOINT ["/socks5"]
