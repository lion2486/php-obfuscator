FROM composer AS composer

WORKDIR /app

COPY composer.json .

RUN composer install \
        --ignore-platform-reqs \
        --no-interaction \
        --no-plugins \
        --no-scripts \
        --prefer-dist

# Final PHP Image
FROM php:7.2-alpine

WORKDIR /app

COPY ./ ./
COPY --from=composer /app/vendor/ /app/vendor/

ENTRYPOINT ["php", "/app/bin/obfuscate", "obfuscate"]