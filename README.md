![Sword Logo](./sword-logo-sm.png)

<br>

[![Github Workflow](https://github.com/phpsword/docker-images/workflows/Build/badge.svg)](https://github.com/phpsword/docker-images/actions)

# Sword Docker images

This images are intented to be used with a Sword application.

Check the documentation for more info: https://getsword.com

## PHP 8.1 for production and development

Production version is bundled with:

* OPcache
* Cachetool (clear OPcache from CLI)
* Redis

Additionally, development version suffixed with `-dev` is bundled with same tools as production image, and:

* Git
* Xdebug 3
* Composer 2
* GNU Make

### Available tags:

| Image  |
| ------ |
| ghcr.io/phpsword/php:8.1     |
| ghcr.io/phpsword/php:8.1-dev |
