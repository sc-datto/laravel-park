# Usa una imagen base oficial de PHP con FPM
FROM php:8.2-fpm

# Instala herramientas del sistema y dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    zip \
    libxml2-dev \
    libonig-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    jq \
    default-mysql-client \
    nodejs \
    npm \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring zip gd xml

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia los archivos del proyecto
COPY . .

# Instala las dependencias de Laravel
RUN composer install --optimize-autoloader

# Instala las dependencias de Node.js
RUN npm install

# Da permisos necesarios a las carpetas de almacenamiento y caché
RUN chmod -R 775 storage bootstrap/cache && chown -R www-data:www-data storage bootstrap/cache

# Exponer puertos para Laravel y Vite
EXPOSE 8000 3000
