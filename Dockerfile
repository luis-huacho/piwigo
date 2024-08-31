FROM php:7.4-fpm

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    libmagickwand-dev \
    git \
    libicu-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo pdo_mysql mysqli zip exif opcache intl

# Instalar Imagick
RUN pecl install imagick && docker-php-ext-enable imagick

# Limpiar caché de apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Configurar PHP
COPY php.ini $PHP_INI_DIR/php.ini

# Configurar opcache
RUN echo "opcache.memory_consumption=128" >> /usr/local/etc/php/conf.d/opcache-recommended.ini \
    && echo "opcache.interned_strings_buffer=8" >> /usr/local/etc/php/conf.d/opcache-recommended.ini \
    && echo "opcache.max_accelerated_files=4000" >> /usr/local/etc/php/conf.d/opcache-recommended.ini \
    && echo "opcache.revalidate_freq=2" >> /usr/local/etc/php/conf.d/opcache-recommended.ini \
    && echo "opcache.fast_shutdown=1" >> /usr/local/etc/php/conf.d/opcache-recommended.ini

# Configurar límites de memoria y tiempo de ejecución
RUN echo "memory_limit = 1024M" >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini \
    && echo "max_execution_time = 3000" >> /usr/local/etc/php/conf.d/docker-php-maxexectime.ini \
    && echo "upload_max_filesize = 320M" >> /usr/local/etc/php/conf.d/docker-php-uploads.ini \
    && echo "post_max_size = 512M" >> /usr/local/etc/php/conf.d/docker-php-uploads.ini

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Establecer el directorio de trabajo
WORKDIR /var/www/html

# Instalar PHP-FFMpeg vía Composer
RUN composer require php-ffmpeg/php-ffmpeg

# Exponer el puerto para PHP-FPM
EXPOSE 9000