#!/usr/bin/bash

year=$(date +%Y)
month=$(date +%m)

mkdir -p $year || true
touch $year/$month.rst
