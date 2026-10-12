#!/bin/bash

# 1. Membuat Docker image dari Dockerfile dengan nama 'item-app' dan tag 'v1'
docker build -t item-app:v1 .

# 2. Melihat daftar Docker image yang tersimpan di lokal
docker images

# 3. Mengubah nama (tag) image agar sesuai dengan format repository Docker Hub lu
# Ganti <username_dockerhub> dengan username Docker Hub lu sendiri!
docker tag item-app:v1 shendyeff/item-app:v1

# 4. Login ke Docker Hub via Terminal secara aman menggunakan environment variable
# Jalankan perintah: export PASSWORD_DOCKER_HUB="password_lu" di terminal sebelum menjalankan script ini
echo $PASSWORD_DOCKER_HUB | docker login -u shendyeff --password-stdin

# 5. Mengunggah (push) image yang sudah di-tag ke Docker Hub
docker push shendyeff/item-app:v1