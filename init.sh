#!/usr/bin/env bash

php app/console doctrine:schema:drop --force
php app/console doctrine:database:drop --force
php app/console doctrine:database:create
php app/console doctrine:schema:create
php app/console khepin:yamlfixtures:load

