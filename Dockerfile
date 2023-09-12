# Build stage
FROM golang:latest AS build
# Desativar o suporte a módulos Go
ENV GO111MODULE=off
WORKDIR /go/src/app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags "-w -s" -o main .

# Final stage
FROM scratch
WORKDIR /app
COPY --from=build /go/src/app/main .
CMD ["./main"]
