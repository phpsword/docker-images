![Sword Logo](./sword-logo-sm.png)

<br>

[![Github Workflow](https://github.com/phpsword/docker-images/workflows/Build%20and%20deploy/badge.svg)](https://github.com/phpsword/docker-images/actions)

# Sword Docker images

This images are intented to be used with a Sword application.

Check the documentation for more info: https://getsword.com

## PHP 8.1 for production and development

Production version is bundled with:

* Cachetool
* Redis with igbinary

Additionally, development version suffixed with `-dev` is bundled with the same tools as production image, and:

* Git
* Xdebug 3
* Composer 2
* GNU Make

### Available tags:

| Image  |
| ------ |
| ghcr.io/phpsword/php:8.1     |
| ghcr.io/phpsword/php:8.1-dev |
| ghcr.io/phpsword/php:8.2     |
| ghcr.io/phpsword/php:8.2-dev |
