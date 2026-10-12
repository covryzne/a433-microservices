# Menggunakan base image resmi Node.js versi 14
FROM node:14

# Menentukan working directory (direktori kerja) utama di dalam container
WORKDIR /app

# Menyalin seluruh file dan folder dari host ke working directory di container
COPY . .

# Mengatur environment variable agar aplikasi berjalan di production mode dan terhubung ke container database 'item-db'
ENV NODE_ENV=production DB_HOST=item-db

# Menginstal dependencies khusus production secara aman (--unsafe-perm) dan melakukan build aplikasi
RUN npm install --production --unsafe-perm && npm run build

# Mengekspos port 8080 agar aplikasi dapat diakses dari luar container
EXPOSE 8080

# Menjalankan perintah untuk memulai server aplikasi saat container pertama kali diluncurkan
CMD ["npm", "start"]