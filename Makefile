.PHONY: all

DOCKER_RUN_TEST_OPTIONS = --user www-data -w /home/www-data --rm

all: php test-php

.PHONY: php php81
php: php81

php81:
	docker build -t ghcr.io/phpsword/php:8.1 php/8.1
	docker build -t ghcr.io/phpsword/php:8.1-dev php/8.1-dev

.PHONY: test-php test-php81
test-php: test-php81

test-php81:
	docker run $(DOCKER_RUN_TEST_OPTIONS) ghcr.io/phpsword/php:8.1 bash -c "php -v | grep '8\.1'"
	docker run $(DOCKER_RUN_TEST_OPTIONS) ghcr.io/phpsword/php:8.1-dev bash -c "php -v | grep '8\.1' && php -v | grep 'Xdebug v3'"

.PHONY: deploy deploy81
deploy: deploy81

deploy81:
	docker push ghcr.io/phpsword/php:8.1
	docker push ghcr.io/phpsword/php:8.1-dev
