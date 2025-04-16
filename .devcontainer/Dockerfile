# Set base image for PHP and Laravel
FROM php:8.2-fpm-alpine

# Install system dependencies and PHP extensions required for Laravel
RUN apk --no-cache add \
    bash \
    git \
    libpng-dev \
    libjpeg-turbo-dev \
    libfreetype6-dev \
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

# Install Composer dependencies for Laravel
COPY . .

# Install Composer dependencies
RUN composer install --optimize-autoloader --no-dev

# Install Node.js dependencies (for Vue.js)
RUN npm install

# Set up permissions for Laravel
RUN chown -R www-data:www-data /var/www
RUN chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Expose necessary ports
EXPOSE 8000

# Set the command to start the PHP server for Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0"]

