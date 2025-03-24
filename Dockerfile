# Usa PHP 7.2 con FPM para compatibilidad con Laravel 5.4
FROM php:7.2-fpm

# Instalar dependencias del sistema y extensiones necesarias para Laravel
RUN apt-get update && apt-get install -y \
    curl zip unzip git nano \
    && docker-php-ext-install pdo pdo_mysql mbstring \
    && rm -rf /var/lib/apt/lists/*

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configurar el directorio de trabajo de Laravel
WORKDIR /var/www/html

# Copiar archivos del proyecto Laravel al contenedor
COPY . .

# Crear directorios necesarios y establecer permisos adecuados
RUN mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Instalar dependencias de Composer sin paquetes de desarrollo
RUN composer install --no-dev --prefer-dist --optimize-autoloader || true

# Exponer el puerto 9000 para PHP-FPM
EXPOSE 9000

# Iniciar PHP-FPM
ENTRYPOINT ["php-fpm"]
