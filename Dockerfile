# Usa una imagen oficial de PHP con soporte de Apache
FROM php:8.1-apache

# Instalar dependencias
RUN apt-get update && apt-get install -y curl unzip git

# Instalar Composer de manera segura
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Crear y usar un usuario no root para Composer
RUN useradd -m laravel && chown -R laravel:laravel /var/www/html
USER laravel

# Copiar los archivos del proyecto
COPY --chown=laravel:laravel . /var/www/html

# Configurar permisos y optimizar Laravel
RUN composer install --no-dev --optimize-autoloader

# Volver a root para ejecutar comandos administrativos
USER root

# Exponer el puerto de Apache
EXPOSE 80
