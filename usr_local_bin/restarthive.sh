#!/usr/bin/env bash

ssh hive01 'sudo service apache2 restart && echo restarted_1'
ssh hive02 'sudo service apache2 restart && echo restarted_2'
ssh hive03 'sudo service apache2 restart && echo restarted_3'
ssh hive04 'sudo service apache2 restart && echo restarted_4'
ssh hive05 'sudo service apache2 restart && echo restarted_5'
# ssh beta02 'sudo service apache2 restart'

