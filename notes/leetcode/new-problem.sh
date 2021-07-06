#!/usr/bin/bash

title=$(python -c "print('$1'.replace('-', ' ').title())")
title_delim=$(python -c "print('='*len('$title'))")

cat <<EOF >> index.rst
$title
$title_delim

.. leetcode:: _
   :id: $1
   :diffculty:
   :language:
   :key:
EOF

mkdir $1
