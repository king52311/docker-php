FROM php:8.2-fpm-alpine

# 安装系统依赖（如 GD 库、ZIP 等需要底层 C 库支持）
RUN apk add --no-cache \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libzip-dev \
    zip \
    unzip

# 编译并安装 PHP 核心扩展
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo_mysql mysqli zip opcache

# （可选）安装 Composer 用于管理 PHP 依赖包
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html