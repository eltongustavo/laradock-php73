# Use a imagem oficial do PHP com Apache como base
FROM php:7.3-apache

# Instale dependências necessárias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    libonig-dev \
    git \
    libicu-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Instale as extensões PHP necessárias
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/freetype2 --with-jpeg-dir=/usr/include \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip \
    && docker-php-ext-install intl \
    && docker-php-ext-install exif \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install mysqli

# Instale o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Defina o diretório de trabalho
WORKDIR /var/www/html

# Exponha a porta 80 para o Apache
EXPOSE 80

# Copie o arquivo de configuração do Apache
COPY apache.conf /etc/apache2/sites-available/000-default.conf

# Habilite o mod_rewrite do Apache
RUN a2enmod rewrite
