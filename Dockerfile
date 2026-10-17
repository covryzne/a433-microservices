# Gunakan Node.js 22 berbasis Alpine untuk image runtime yang relatif ringan.
FROM node:22-alpine

# Tetapkan direktori kerja aplikasi di dalam container.
WORKDIR /app

# Salin manifest dependency agar layer dependency bisa di-cache.
COPY package.json package-lock.json ./

# Instal dependency sesuai lockfile tanpa memasang dependency dev-only.
RUN npm ci --omit=dev

# Salin source code utama Order Service ke direktori kerja.
COPY index.js ./index.js

# Dokumentasikan port HTTP yang digunakan oleh Order Service.
EXPOSE 3000

# Jalankan aplikasi menggunakan user non-root bawaan image Node.js.
USER node

# Mulai aplikasi menggunakan script start dari package.json.
CMD ["npm", "start"]