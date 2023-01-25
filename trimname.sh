#! /bin/bash

CAPTURE_PATTERN="(.+\S)\s{0,}-.+\..+\$"

# echo $CAPTURE_PATTERN

cat | sed -E "s/$CAPTURE_PATTERN/\1/"
