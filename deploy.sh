#!/bin/bash
# deploy.sh - Script de despliegue manual a AWS S3

BUCKET="mi-bucket-devops"
SOURCE="src/"

echo "========================================="
echo "  Iniciando despliegue a S3..."
echo "========================================="

# Sincroniza los archivos con S3, eliminando archivos obsoletos
aws s3 sync "$SOURCE" "s3://$BUCKET" \
    --delete \
    --acl public-read

if [ $? -eq 0 ]; then
    echo "========================================="
    echo "  Despliegue completado exitosamente."
    echo "  URL: http://$BUCKET.s3-website-us-east-1.amazonaws.com"
    echo "========================================="
else
    echo "ERROR: El despliegue falló. Revisa las credenciales AWS o el nombre del bucket."
    exit 1
fi
