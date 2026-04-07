# Сборка
FROM golang:1.25 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 go build -o app .

# Запуск
FROM alpine:3.21

WORKDIR /app

COPY --from=builder /app/app .

CMD ["./app"]