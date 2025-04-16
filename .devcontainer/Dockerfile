# Set base image for PHP and Laravel
FROM php:8.2-fpm-alpine

# Install system dependencies and PHP extensions required for Laravel
RUN apk --no-cache add \
    bash \
    git \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    oniguruma-dev \
    libxml2-dev \
    nodejs \
    npm \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip \
    && rm -rf /var/cache/apk/*

# Set working directory
WORKDIR /var/www

# Copy the Composer installation script
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy project
COPY . .

# Set up permissions for Laravel
RUN chown -R www-data:www-data /var/www
RUN chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Expose necessary ports
EXPOSE 8000
