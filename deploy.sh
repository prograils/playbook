#!/bin/bash
rsync -crvz --delete-after --delete-excluded _site/ prograils@prograils.com:~/pb/playbook
