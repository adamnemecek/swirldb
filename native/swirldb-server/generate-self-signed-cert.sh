#!/bin/bash

# Generate self-signed TLS certificates for testing SwirlDB server
# WARNING: These certificates are NOT suitable for production use!

set -e

CERT_DIR="./certs"
CERT_FILE="$CERT_DIR/certificate.pem"
KEY_FILE="$CERT_DIR/private-key.pem"

echo "🔐 Generating self-signed TLS certificate for testing..."

# Create certs directory
mkdir -p "$CERT_DIR"

# Generate certificate
openssl req -x509 -newkey rsa:4096 -nodes \
  -keyout "$KEY_FILE" \
  -out "$CERT_FILE" \
  -days 365 \
  -subj "/CN=localhost" \
  -addext "subjectAltName=DNS:localhost,IP:127.0.0.1"

echo "✅ Certificate generated successfully!"
echo ""
echo "Certificate: $CERT_FILE"
echo "Private key: $KEY_FILE"
echo ""
echo "To run the server with TLS:"
echo "  export TLS_CERT_PATH=$PWD/$CERT_FILE"
echo "  export TLS_KEY_PATH=$PWD/$KEY_FILE"
echo "  cargo run --release"
echo ""
echo "⚠️  WARNING: This is a self-signed certificate."
echo "   Browsers will show security warnings."
echo "   For production, use Let's Encrypt instead."
