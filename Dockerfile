# Use an official Go runtime as a parent image
FROM golang:1.20 as builder

# Set the working directory to /app
WORKDIR /app

# Copy the Go program source code into the container
COPY exporter.go .
COPY go.mod .
COPY go.sum .
# Build the Go program
RUN go mod download
RUN go build -o exporter .

# Use a lightweight base image for the final container
FROM ubuntu:latest

# Copy the built binary from the builder stage
COPY --from=builder /app/exporter exporter
RUN chmod +x exporter
RUN mv exporter /usr/bin/
RUN ls
# Expose port 8080
EXPOSE 8080
# Run the exporter binary
CMD ["exporter"]