# Usa PHP 7.2 con FPM para compatibilidad con Laravel 5.4
FROM php:7.2-fpm

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    curl zip unzip git nano \
    && docker-php-ext-install pdo pdo_mysql

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Crear directorio de la aplicación
WORKDIR /var/www/html

# Copiar archivos de la aplicación
COPY . .

# Establecer permisos adecuados
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Instalar dependencias sin paquetes de desarrollo
RUN composer install --no-dev --optimize-autoloader || true

# Exponer el puerto 9000 para PHP-FPM
EXPOSE 9000

# Comando de inicio
CMD ["php-fpm"]
