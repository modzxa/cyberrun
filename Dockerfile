FROM --platform=$BUILDPLATFORM golang:1.21-alpine AS build
WORKDIR /app
COPY . .
RUN go build -ldflags="-s -w" -o proxy
FROM --platform=$TARGETPLATFORM gcr.io/distroless/static
COPY --from=build /app/proxy /
ENTRYPOINT ["/proxy"]
