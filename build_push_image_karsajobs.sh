#!/usr/bin/env bash

# Menghentikan script jika terjadi error, variabel kosong, atau kegagalan pipeline.
set -Eeuo pipefail

# Menentukan nama image backend di GitHub Container Registry.
IMAGE_NAME="ghcr.io/covryzne/karsajobs"
IMAGE_TAG="latest"

# Berpindah ke direktori script agar Dockerfile dan build context tepat.
cd "$(dirname "${BASH_SOURCE[0]}")"

# Memastikan kredensial GHCR sudah disediakan melalui environment variable.
: "${GHCR_USERNAME:?ERROR: Set GHCR_USERNAME terlebih dahulu.}"
: "${GHCR_TOKEN:?ERROR: Set GHCR_TOKEN terlebih dahulu.}"

# Memastikan Docker tersedia.
command -v docker >/dev/null 2>&1 || {
  echo "ERROR: Docker tidak tersedia di PATH." >&2
  exit 1
}

# Memastikan Docker daemon sedang berjalan.
docker info >/dev/null 2>&1 || {
  echo "ERROR: Docker daemon tidak berjalan." >&2
  exit 1
}

# Login ke GHCR menggunakan token tanpa menuliskannya ke argumen command.
printf '%s' "${GHCR_TOKEN}" |
  docker login ghcr.io --username "${GHCR_USERNAME}" --password-stdin

# Membangun image backend dari Dockerfile di direktori ini.
docker build -t "${IMAGE_NAME}:${IMAGE_TAG}" .

# Mengunggah image backend ke GHCR.
docker push "${IMAGE_NAME}:${IMAGE_TAG}"

# Menampilkan konfirmasi setelah seluruh proses berhasil.
echo "SUCCESS: Backend image pushed to ${IMAGE_NAME}:${IMAGE_TAG}"
