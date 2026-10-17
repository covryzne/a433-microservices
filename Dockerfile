# Gunakan Node.js 22 berbasis Alpine untuk runtime yang relatif ringan.
FROM node:22-alpine

# Tetapkan direktori kerja aplikasi di dalam container.
WORKDIR /app

# Salin manifest dependency untuk memanfaatkan cache layer Docker.
COPY package.json package-lock.json ./

# Instal dependency produksi berdasarkan lockfile.
RUN npm ci --omit=dev

# Salin source code utama Shipping Service.
COPY index.js ./index.js

# Dokumentasikan port HTTP Shipping Service.
EXPOSE 3001

# Jalankan aplikasi dengan user non-root bawaan image Node.js.
USER node

# Mulai Shipping Service menggunakan script start.
CMD ["npm", "start"]
