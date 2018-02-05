#!/bin/bash
bundle exec jekyll b
rsync -crvz --delete-after --delete-excluded _site/ prograils@prograils.com:~/pb/playbook
