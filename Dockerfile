#Stage-1 Build
FROM python:3.9.23-alpine3.22 AS builder
WORKDIR /build
#Install build dependencies
RUN apk add --no-cache gcc musl-dev python3-dev
COPY requirements.txt .
RUN pip3 install --upgrade pip setuptools wheel
RUN pip3 install --no-cache-dir --prefix=/install -r requirements.txt


#Stage-2 Final image
FROM python:3.9.23-alpine3.22
EXPOSE 8080
WORKDIR /opt/server
# Runtime dependencies only
RUN apk add --no-cache libgcc
#Create appuser
RUN addgroup -S appuser && adduser -S appuser -G appuser
#Switching to non-root user
USER appuser
# Copy installed Python packages from builder
COPY --from=builder /install /usr/local
# Copy application code
COPY --chown=app:app *.py .
CMD ["python", "app.py"]
