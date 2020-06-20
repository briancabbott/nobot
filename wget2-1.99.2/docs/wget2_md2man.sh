#!/bin/sh
#
# $1: input file (markdown)
# $2: output file (man)

set -u
set -e

(
  echo "% WGET2(1) GNU Wget2 User Manual|GNU Wget2 1.99.2"
  echo ""
  cat "$1"
) | \
sed '/# Wget2/,/^#/{/^# </!d}' | \
$PANDOC -s -f markdown -t man -o "$2"
