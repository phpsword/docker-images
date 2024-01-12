LOCAL ?= 0
DEPLOY ?= 0
PUSH =
BUILDX = buildx
PLATFORM = --platform=linux/amd64,linux/arm64

ifeq ($(DEPLOY),1)
	PUSH = --push
endif

ifeq ($(LOCAL),1)
	BUILDX =
	PLATFORM =
endif

DOCKER_RUN_TEST_OPTIONS = --user www-data -w /home/www-data --rm

.PHONY: all
all: php test-php

.PHONY: php php81 php82 php83
php: php81 php82 php83

php81:
	docker $(BUILDX) build $(PUSH) --no-cache $(PLATFORM) -t ghcr.io/phpsword/php:8.1 php/8.1
	docker $(BUILDX) build $(PUSH) --no-cache $(PLATFORM) -t ghcr.io/phpsword/php:8.1-dev php/8.1-dev

php82:
	docker $(BUILDX) build $(PUSH) --no-cache $(PLATFORM) -t ghcr.io/phpsword/php:8.2 php/8.2
	docker $(BUILDX) build $(PUSH) --no-cache $(PLATFORM) -t ghcr.io/phpsword/php:8.2-dev php/8.2-dev

php83:
	docker $(BUILDX) build $(PUSH) --no-cache $(PLATFORM) -t ghcr.io/phpsword/php:8.3 php/8.3
	docker $(BUILDX) build $(PUSH) --no-cache $(PLATFORM) -t ghcr.io/phpsword/php:8.3-dev php/8.3-dev

.PHONY: test-php test-php81 test-php82 test-php83
test-php: test-php81 test-php82 test-php83

test-php81:
	docker run $(DOCKER_RUN_TEST_OPTIONS) ghcr.io/phpsword/php:8.1 bash -c "php -v | grep '8\.1'"
	docker run $(DOCKER_RUN_TEST_OPTIONS) ghcr.io/phpsword/php:8.1-dev bash -c "php -v | grep '8\.1' && php -v | grep 'Xdebug v3'"

test-php82:
	docker run $(DOCKER_RUN_TEST_OPTIONS) ghcr.io/phpsword/php:8.2 bash -c "php -v | grep '8\.2'"
	docker run $(DOCKER_RUN_TEST_OPTIONS) ghcr.io/phpsword/php:8.2-dev bash -c "php -v | grep '8\.2' && php -v | grep 'Xdebug v3'"

test-php83:
	docker run $(DOCKER_RUN_TEST_OPTIONS) ghcr.io/phpsword/php:8.3 bash -c "php -v | grep '8\.3'"
	docker run $(DOCKER_RUN_TEST_OPTIONS) ghcr.io/phpsword/php:8.3-dev bash -c "php -v | grep '8\.3' && php -v | grep 'Xdebug v3'"
